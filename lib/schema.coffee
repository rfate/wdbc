path = require 'path'
fs   = require 'fs'

Schema =
  MAGIC_NUMBER: 1128416343
  HEADER_SIZE: 20

for file in fs.readdirSync("#{__dirname}/schema")
  name = path.basename(file, '.coffee')
  Schema[name] = require "./schema/#{name}"

module.exports = Schema