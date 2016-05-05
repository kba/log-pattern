module.exports = []
module.exports.push
	name: 'config'
	requires_arg: true
	setup: ->
		@precomputed = @config[@arg] or ''
	description: '''
Value of a configuration option, i.e. a constant.
'''

module.exports.push
	name: 'env'
	requires_arg: true
	setup: ->
		@precomputed = process.env[@arg]
	description: '''
Value of an environment variable

```
%env{NODE_ENV}
%env{PATH}
```
'''
