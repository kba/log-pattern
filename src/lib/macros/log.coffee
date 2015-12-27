module.exports = []
module.exports.push
	name: 'level'
	exec: (options) -> options.level
module.exports.push
	name: 'LEVEL'
	exec: (options) -> options.level.toUpperCase()
module.exports.push
	name: 'message'
	exec: (options) -> options.message
module.exports.push
	name: '!'
	must_arg: true
	exec: (options) ->
		return options[@arg]
