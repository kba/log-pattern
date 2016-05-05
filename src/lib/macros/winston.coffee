Utils = require '../utils'

module.exports = []

module.exports.push
	name: 'options'
	alias: ['!']
	requires_arg: true
	exec: (options) ->
		return options[@arg]
	description: '''
	Any value in the object passed to the formatter function.

	```
	// {foo:bar}
	%!{foo}
	// -> "bar"
	```
	'''

module.exports.push
	name: 'level'
	exec: (options) -> options.level
	description: '''
	Logging level.
	'''

module.exports.push
	name: 'label'
	exec: (options) ->
		options.label
	description: '''
	Label of the current logger
	'''

module.exports.push
	name: 'LEVEL'
	exec: (options) ->
		options.level.toUpperCase()
	description: '''
	Upper case version of the logging level.
	'''

module.exports.push
	name: 'message'
	exec: (options) -> options.message
	description: '''
	Log message.
	'''

module.exports.push
	name: 'levelColor'
	requires_inner: yes
	accepts_arg: yes
	setup : ->
		if @arg
			@_colorize = Utils.colorizeFunction Utils.splitCommaEquals @arg
		else if 'levelColors' of @config and typeof @config.levelColors is 'object'
			@_colorize = Utils.colorizeFunction @config.levelColors
		else if 'levelColors' of @config and typeof @config.levelColors is 'function'
			@_colorize = @config.levelColor
		else
			@throw_error "No level-color mapping. Either pass 'levelColor' function or define mapping."
	exec: (options, inner) ->
		return @_colorize options.level, inner
	description: '''
	Colorize output depending on the logging level.
	'''
