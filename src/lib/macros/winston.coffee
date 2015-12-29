{ parseColor, splitCommaEquals } = require '../utils'

module.exports = []
module.exports.push
	name: 'level'
	exec: (options) -> options.level
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
	requires_winston: yes
	accepts_arg: yes
	setup : ->
		if @arg
			def = splitCommaEquals @arg
			for level,styles of def
				def[level] = parseColor styles
			@_colorize = (level, inner) ->
				return inner unless level of def
				return def[level] inner
		else if 'winston' of @
			@_colorize = @winston.config.colorize
		else 
			@throw_error "No level-color mapping!"
	exec: (options, inner) ->
		if 'level' of options
			return @_colorize options.level, inner
		return inner
