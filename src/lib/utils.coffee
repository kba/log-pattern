Chalk = require 'chalk'
Uniq = require 'uniq'

EMPTY_STRING = ''

RE_SPLIT_COMMA = new RegExp('\\s*,\\s*')
RE_SPLIT_EQUALS = new RegExp('\\s*=\\s*')
RE_SPLIT_SPACE_DOT = new RegExp('[\\.\\s]+')

splitCommaEquals = (str) ->
	ret = {}
	for kvpair in str.split RE_SPLIT_COMMA
		[k,v] = kvpair.split RE_SPLIT_EQUALS
		ret[k] = v
	return ret

parseColor = (str) ->
	_colorize = Chalk
	styles = Uniq str.split(RE_SPLIT_SPACE_DOT).sort()
	if styles.length == 0
		throw("Must set at least one style for color")
	for style in styles
		if style not of Chalk
			throw("Not a valid chalk style: '#{style}'")
		_colorize = _colorize[style]
	return _colorize

module.exports = {
	RE_SPLIT_COMMA
	RE_SPLIT_EQUALS
	RE_SPLIT_SPACE_DOT
	parseColor
	splitCommaEquals
}
