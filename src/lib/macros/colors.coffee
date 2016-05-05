Utils = require '../utils'

module.exports = []
module.exports.push
	name: 'chalk'
	alias: ['C']
	description: '''
Renders text in ANSI color with [chalk](https://github.com/chalk/chalk).'

```
%chalk{red}(some text)
%@{blue bold}(bla)
```
	'''
	requires_inner: yes
	requires_arg: yes
	setup: ->
		try
			@_colorize = Utils.parseColor(@arg)
		catch e
			@throw_error(e)
	exec: (options, inner) ->
		@_colorize inner

module.exports.push
	name: 'style'
	alias: ['@']
	description: '''
Style the inner text using [chalk](https://github.com/chalk/chalk), but
referring to named styles defined in the config.

```js
patFmt = LogPattern.PatternFormaater({
	styles:{
		'date': 'red bold',
		'message': 'green underline'
	}
});
fmt = patFmt.formatter({'pattern': '%style{date}(%date) ---- %@{message}(foo!)'});
fmt()
// -> "01:02:03.432 - foo!"
//    |____________| |   |
//       green     | |   |
//     underline   |_|   |
//               default |
//                   |___|
//                    red
//                    bold
```
'''
	requires_arg: true
	requires_inner: yes
	requires_config: ['styles']
	setup: ->
		@_colorize = Utils.colorizeFunction @config.styles
	exec: (options, inner) ->
		@_colorize @arg, inner
