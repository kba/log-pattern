module.exports = []
module.exports.push
	name: 'pid'
	accepts_arg : false
	requires_config: false
	exec: (options) ->
		return process.pid
	description: '''
Return the PID of the current process

```
%pid
// -> "17432"
```
'''



