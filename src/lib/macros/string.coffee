Pad = require 'pad'

module.exports = []
module.exports.push
	name: 'uc'
	requires_inner: true
	exec: (options, inner) ->
		return inner.toUpperCase()
	description: '''
	Converts a string to upper case.
	'''

module.exports.push
	name: 'lc'
	requires_inner: true
	exec: (options, inner) ->
		return inner.toLowerCase()
	description: '''
	Converts a string to lower case.
	'''

module.exports.push
	name: 'pad'
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
	description: '''
	Pads a string with spaces or truncates it to fit into a fixed length field.
	
	Uses [pad](http://github.com/wdavidw/node-pad).
	'''

module.exports.push
	name: '?'
	is_condition: true
	check: (options, inner) ->
		return not /^\s*$/.test(inner)
	exec: (options, inner) -> inner
	description: '''
	**CONDITION**

	Matches if the inner text is not an empty string or does not only contain whitespace.
	'''

# %s(|foo|bar| blafoobla) -> blabarbla
module.exports.push
	name: 's'
	requires_inner: true
	exec: (options, inner) ->
		delim = inner[0]
		[to_replace, replace_with, inner] = inner.substr(1).split(delim)
		return inner.replace(new RegExp(to_replace), replace_with)
	description: '''
	```
	%s(|foo|bar| blafoobla) -> blabarbla
	```
	'''
