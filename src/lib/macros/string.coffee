Pad = require 'pad'

module.exports = []
module.exports.push
	name: 'uc'
	requires_inner: true
	exec: (options, inner) ->
		return inner.toUpperCase()

module.exports.push
	name: 'lc'
	requires_inner: true
	exec: (options, inner) ->
		return inner.toLowerCase()

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

module.exports.push
	name: '?'
	is_condition: true
	check: (options, inner) ->
		return not /^\s*$/.test(inner)
	exec: (options, inner) -> inner

# %s(|foo|bar| blafoobla) -> blabarbla
module.exports.push
	name: 's'
	requires_inner: true
	exec: (options, inner) ->
		delim = inner[0]
		[to_replace, replace_with, inner] = inner.substr(1).split(delim)
		return inner.replace(to_replace, replace_with)
