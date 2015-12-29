Winston = require 'winston'

{parseColor} = require '../utils'

module.exports = []
module.exports.push
	name: 'chalk'
	requires_inner: yes
	requires_arg: yes
	setup: ->
		try
			@_colorize = parseColor(@arg)
		catch e
			@throw_error(e)
	exec: (options, inner) ->
		@_colorize inner
