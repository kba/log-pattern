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
	requires_config: ['winston']
	accepts_arg: yes
	setup : ->
		if @arg
			def = Utils.splitCommaEquals @arg
			for level,styles of def
				def[level] = Utils.parseColor styles
			@_colorize = (level, inner) ->
				return inner unless level of def
				return def[level] inner
		else if 'winston' of @config
			@_colorize = @config.winston.config.colorize
		else 
			@throw_error "No level-color mapping!"
	exec: (options, inner) ->
		if 'level' of options
			return @_colorize options.level, inner
		return inner
