Schema = require './schema'

module.exports = (file, file_type) ->
  throw "Unknown schema #{file_type}" unless Schema[file_type]

  string_block_size = 1
  for record in file.records
    for field, value of record
      string_block_size += value.length + 1 if typeof value is 'string'

  length = Schema.HEADER_SIZE + file.records.length*file.record_size + string_block_size
  buf = new Buffer(length)

  buf.writeUInt32LE(Schema.MAGIC_NUMBER, 0)
  buf.writeUInt32LE(file.records.length, 4)
  buf.writeUInt32LE(file.field_count,    8)
  buf.writeUInt32LE(file.record_size,    12)
  buf.writeUInt32LE(string_block_size,   16)

  if string_block_size > 1
    string_block = buf.slice(buf.length - string_block_size)
    string_ptr = 1
    string_block.writeInt32LE(0, 0)

  record_block = buf.slice(Schema.HEADER_SIZE, buf.length - string_block_size)

  ptr = 0
  for record, i in file.records
    for [type, field] in Schema[file_type]
      if type is 'int'
        record_block.writeInt32LE(record[field], ptr)
        ptr += 4

      else if type is 'uint'
        record_block.writeUInt32LE(record[field], ptr)
        ptr += 4

      else if type is 'byte'
        record_block.writeInt8(record[field], ptr)
        ptr += 1

      else if type is 'string'
        string_block.write("#{record[field]}\u0000", string_ptr, record[field].length+1)
        record_block.writeInt32LE(string_ptr, ptr)

        ptr += 4
        string_ptr += record[field].length + 1

      else if type is 'localization'
        record_block.writeInt32LE(0, ptr)
        record_block.writeInt32LE(0, ptr + 4)
        record_block.writeInt32LE(0, ptr + 8)
        record_block.writeInt32LE(0, ptr + 12)
        record_block.writeInt32LE(0, ptr + 16)
        record_block.writeInt32LE(0, ptr + 20)
        record_block.writeInt32LE(0, ptr + 24)
        record_block.writeInt32LE(record['localization_mask'], ptr + 28)
        ptr += 32

      else if type is 'float'
        record_block.writeFloatLE(record[field], ptr)
        ptr += 4

      else if type is 'null'
        record_block.writeInt32LE(0, ptr)
        ptr += 4
  
      else
        throw "Unknown field type '#{type}' for field '#{field}'"

  return buf
