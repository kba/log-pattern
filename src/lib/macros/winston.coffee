Utils = require '../utils'

module.exports = []
module.exports.push
	name: 'level'
	exec: (options) -> options.level
module.exports.push
	name: 'label'
	exec: (options) ->
		options.label
module.exports.push
	name: 'LEVEL'
	exec: (options) ->
		options.level.toUpperCase()
module.exports.push
	name: 'message'
	exec: (options) -> options.message
module.exports.push
	name: '!'
	requires_arg: true
	exec: (options) ->
		return options[@arg]
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
