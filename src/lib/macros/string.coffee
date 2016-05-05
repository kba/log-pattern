Pad = require 'pad'

module.exports = []
module.exports.push
	name: 'uc'
	description: '''
Converts a string to upper case.
'''
	requires_inner: true
	exec: (options, inner) ->
		return inner.toUpperCase()

module.exports.push
	name: 'lc'
	description: '''
Converts a string to lower case.
'''
	requires_inner: true
	exec: (options, inner) ->
		return inner.toLowerCase()

module.exports.push
	name: 'pad'
	description: '''
Pads a string with spaces or truncates it to fit into a fixed length field.

Uses [pad](http://github.com/wdavidw/node-pad).
'''
	requires_arg: true
	requires_inner: true
	setup: ->
		@_pad_opts =
			colors: true
			strip: true
		@_amount = parseInt @arg
		if @_amount > 0
			@_pad_left = true
		@_amount = Math.abs(@_amount)
	exec: (options, inner) ->
		if @_pad_left
			return Pad(@_amount, inner, @_pad_opts)
		return Pad(inner, @_amount, @_pad_opts)

module.exports.push
	name: '?'
	description: '''
** CONDITION **

Matches if the inner text is not an empty string or does not only contain whitespace.
'''
	is_condition: true
	check: (options, inner) ->
		return not /^\s*$/.test(inner)
	exec: (options, inner) -> inner

# %s(|foo|bar| blafoobla) -> blabarbla
module.exports.push
	name: 's'
	description: '''
```
%s(|foo|bar| blafoobla) -> blabarbla
```
'''
	requires_inner: true
	exec: (options, inner) ->
		delim = inner[0]
		[to_replace, replace_with, inner] = inner.substr(1).split(delim)
		return inner.replace(new RegExp(to_replace), replace_with)
