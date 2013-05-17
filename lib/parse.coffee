Schema = require './schema'

parse_string_block = (buf, file) ->
  strings = {}
  ptr = 0

  # TODO: check performance against iterating through buffer without #toString
  for str in buf.toString().split("\u0000")
    strings[ptr] = str
    ptr += str.length + 1

  strings

module.exports = (buf, file_type) ->
  throw "Unknown schema #{file_type}" unless Schema[file_type] or file_type is 'debug'
  if buf.readUInt32LE(0) isnt Schema.MAGIC_NUMBER
    throw "File isn't valid DBC (missing magic number)"

  file =
    record_count: buf.readUInt32LE(4)
    field_count:  buf.readUInt32LE(8)
    record_size:  buf.readUInt32LE(12)

  return file if file_type is 'debug'

  string_block_position = buf.length - buf.readUInt32LE(16)

  file.strings = parse_string_block(buf.slice(string_block_position), file)

  record_block = buf.slice(20, string_block_position)

  file.records = for i in [0...file.record_count]
    record_data = record_block.slice(i*file.record_size, (i+1) * file.record_size)

    ptr = 0
    record = {}
    for [type, field] in Schema[file_type]
      if type is 'int'
        record[field] = record_data.readInt32LE(ptr)
        ptr += 4
      else if type is 'uint'
        record[field] = record_data.readUInt32LE(ptr)
        ptr += 4
      else if type is 'byte'
        record[field] = record_data.readInt8(ptr)
        ptr += 1
      else if type is 'string'
        record[field] = file.strings[record_data.readInt32LE(ptr)]
        ptr += 4
      else if type is 'localization'
        record['localization_mask'] = record_data.readInt32LE(ptr+4*7)
        ptr += 4 * 8
      else if type is 'float'
        record[field] = record_data.readFloatLE(ptr)
        ptr += 4
      else if type is 'null'
        field ?= 1
        ptr += 4 * field
      else
        throw "Unknown field type '#{type}' for field '#{field}'"

    record

  return file
