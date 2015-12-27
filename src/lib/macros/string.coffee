module.exports = []
module.exports.push
	name: 'uc'
	must_inner: true
	exec: (options, inner) ->
		return inner.toUpperCase()
module.exports.push
	name: 'lc'
	must_inner: true
	exec: (options, inner) ->
		return inner.toLowerCase()
module.exports.push
	name: '?'
	conditional: true
	check: (options, inner) ->
		console.log inner
		return typeof inner isnt undefined
	exec: (options, inner) -> inner
