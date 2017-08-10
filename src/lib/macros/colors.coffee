Utils = require '../utils'

module.exports = []
module.exports.push
	name: 'chalk'
	alias: ['C']
	requires_inner: yes
	requires_arg: yes
	setup: ->
		try
			return @_colorize = Utils.parseColor(@arg)
		catch e
			return @throw_error(e)
	exec: (options, inner) ->
		return @_colorize inner
	description: '''
Renders text in ANSI color with [chalk](https://github.com/chalk/chalk).'

```
%chalk{red}(some text)
%@{blue bold}(bla)
```
	'''

module.exports.push
	name: 'style'
	alias: ['@']
	requires_arg: true
	requires_inner: yes
	requires_config: ['styles']
	setup: ->
		return @_colorize = Utils.colorizeFunction @config.styles
	exec: (options, inner) ->
		return @_colorize @arg, inner
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
