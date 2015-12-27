Chalk = require 'chalk'
Winston = require 'winston'

module.exports = []
module.exports.push
	name: 'levelHighlight'
	must_inner: yes
	exec: (options, inner) ->
		return Winston.config.colorize(options.level, inner)
module.exports.push
	name: 'chalk'
	must_inner: yes
	must_arg: yes
	setup: ->
		@_colorize = Chalk
		styles = @arg.split(/[\.\s]+/)
		if styles.length == 0
			@throw_error("Must set at least one style for color")
		for style in styles
			if style not of Chalk
				@throw_error("Not a valid chalk style: '#{style}'")
			@_colorize = @_colorize[style]
	exec: (options, inner) ->
		@_colorize inner
