module.exports = []
module.exports.push
	name: 'env'
	must_arg: true
	setup: ->
		@precomputed = process.env[@arg]
