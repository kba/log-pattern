module.exports = []
module.exports.push
	name: 'env'
	requires_arg: true
	setup: ->
		@precomputed = process.env[@arg]
