Utils = require '../utils'

module.exports = []
module.exports.push
	name: 'chalk'
	alias: ['C']
	requires_inner: yes
	requires_arg: yes
	setup: ->
		try
			@_colorize = Utils.parseColor(@arg)
		catch e
			@throw_error(e)
	exec: (options, inner) ->
		@_colorize inner

module.exports.push
	name: 'style'
	alias: ['@']
	requires_arg: true
	requires_inner: yes
	requires_config: ['styles']
	setup: ->
		@_colorize = Utils.colorizeFunction @config.styles
	exec: (options, inner) ->
		@_colorize @arg, inner
