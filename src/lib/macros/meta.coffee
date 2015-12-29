Cycle = require 'cycle'
Util = require 'util'

EMPTY_STRING = ''
{RE_SPLIT_COMMA, RE_SPLIT_EQUALS} = require '../utils'

module.exports = []
module.exports.push
	name: 'meta'
	accepts_arg: true
	_config:
		decycle: true
		stringify: false
		inspect: true
		colors: true
		depth: 5
		indent: 2
	setup: ->
		return unless @arg
		for kvpair in @arg.split(RE_SPLIT_COMMA)
			[k,v] = kvpair.split(RE_SPLIT_EQUALS, 2)
			if k not of @_config
				throw new Error("Invalid argument: '#{k}'. Must be one of #{Object.keys @_config}")
			if k in ['depth', 'indent']
				@_config[k] = parseInt v
			else
				@_config[k] = v is 'true' or v is '1'
	exec: (options) ->
		if typeof options isnt 'object' or typeof options.meta isnt 'object'
			return EMPTY_STRING
		obj = options.meta
		if obj and
		typeof obj == 'object' and (obj.name or Object.keys(obj).length > 0)
			if @_config.decycle
				obj = Cycle.decycle(obj)
			if @_config.inspect
				inspect_opts =
					colors: @_config.colors
					depth: @_config.depth
				msg = Util.inspect(obj, inspect_opts)
				if @_config.indent > 0
					if /\n/.test(msg)
					  msg = ">\n" + msg.replace(/^/mg, "  ")
				return msg
			if @_config.indent > 0
				return JSON.stringify(obj, null, @_config.indent)
			return JSON.stringify(obj)
