module.exports = []
module.exports.push
	name: 'config'
	requires_arg: true
	setup: ->
		@precomputed = @config[@arg] or ''
module.exports.push
	name: 'env'
	requires_arg: true
	setup: ->
		@precomputed = process.env[@arg]
