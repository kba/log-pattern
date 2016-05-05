DateFormat = require 'dateformat'

module.exports = []
module.exports.push
	name: 'date'
	description: '''
Return the current date, formatted by [dateformat](https://github.com/felixge/node-dateformat).

```
%date{yyyy}
// -> "2016"
%date
// -> "01:02:03.123"
```

The argument defaults to `HH:mm:ss.l`
'''
	accepts_arg : true
	requires_config: false
	# _date_iso: ->
		# tzoffset = (new Date).getTimezoneOffset() * 60000
		# return new Date(Date.now() - tzoffset).toISOString().substring 11, 23
	setup: ->
		@arg or= 'HH:mm:ss.l'
	exec: (options) ->
		return DateFormat(new Date(), @arg)


