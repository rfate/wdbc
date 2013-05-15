#!/usr/bin/env coffee
path = require 'path'
fs   = require 'fs'

class DBC
  constructor: (@filename, @schema, auto_parse = true) ->
    @schema ?= path.baseName(@filename, '.dbc')
    file = fs.readFileSync(@filename)

    @data = @parse(file, @schema) if auto_parse

  save: (filename = @filename) ->
    fs.writeFileSync(filename, @dump(@data, @schema))

  parse: require './lib/parse'
  dump:  require './lib/dump'

module.exports = DBC