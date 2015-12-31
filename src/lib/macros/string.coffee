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
