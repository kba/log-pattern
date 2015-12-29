PatternFormatter = require './formatter.coffee'
PatternParser = require('./parser')
Winston = require 'winston'
util = require 'util'

module.exports.PatternParser = PatternParser
module.exports.PatternFormatter = PatternFormatter
module.exports.formatter = (config) ->
	return new PatternFormatter(config).formatter()
module.exports.setFormatter = (logger, transport, formatter_config={}) ->
	logger_def = logger.remove transport
	logger_def.formatter = new PatternFormatter(formatter_config).formatter()
	logger.add transport, logger_def
module.exports.Macros = {}
