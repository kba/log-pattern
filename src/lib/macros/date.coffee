DateFormat = require 'dateformat'

module.exports = []
module.exports.push
	name: 'date'
	accepts_arg : true
	# _date_iso: ->
		# tzoffset = (new Date).getTimezoneOffset() * 60000
		# return new Date(Date.now() - tzoffset).toISOString().substring 11, 23
	setup: ->
		@arg or= 'HH:mm:ss.l'
	exec: (options) ->
		return DateFormat(new Date(), @arg)


