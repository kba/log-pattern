Chalk = require 'chalk'
Uniq = require 'uniq'
FindUp = require 'find-up'
ReadPkgUp = require 'read-pkg-up'
ChildProcess = require 'child_process'
Path = require 'path'
Memoize = require 'memoizee'

module.exports.EMPTY_STRING = EMPTY_STRING = ''

module.exports.RE_SPLIT_COMMA = RE_SPLIT_COMMA = new RegExp('\\s*,\\s*')
module.exports.RE_SPLIT_EQUALS = RE_SPLIT_EQUALS = new RegExp('\\s*=\\s*')
module.exports.RE_SPLIT_SPACE_DOT = RE_SPLIT_SPACE_DOT = new RegExp('[\\.\\s]+')

module.exports.splitCommaEquals = Memoize (str) ->
	ret = {}
	for kvpair in str.split RE_SPLIT_COMMA
		[k,v] = kvpair.split RE_SPLIT_EQUALS
		ret[k] = v
	return ret

module.exports.parseColor = (str) ->
	_colorize = Chalk
	styles = Uniq str.split(RE_SPLIT_SPACE_DOT).sort()
	if styles.length == 0
		throw("Must set at least one style for color")
	for style in styles
		if style not of Chalk
			throw("Not a valid chalk style: '#{style}'")
		_colorize = _colorize[style]
	return _colorize

module.exports.pkgdir = Memoize (filename) ->
	ret = Path.dirname(FindUp.sync 'package.json', cwd: filename)
	return ret

module.exports.replace_path_tokens = Memoize (filename, arg) ->
	tokens = Path.parse(filename)
	tokens.fullname = filename
	tokens['-pkgdir'] = Path.relative(module.exports.pkgdir(filename), filename)
	tokensOrder = Object.keys(tokens).sort((a,b) -> b.length - a.length)
	for k in tokensOrder
		arg = arg.replace('%'+k, tokens[k])
	return arg

module.exports.gitrev = Memoize (filename) ->
	gitdir = FindUp.sync '.git', cwd: filename
	rev = ChildProcess.execSync "git log -1 --pretty=format:%h", {
		cwd: gitdir
		encoding: 'ascii'
	}

module.exports.shortenPath = Memoize (filename, arg) ->
	shortened = []
	segments = Path.dirname(filename).split(Path.sep)
	if typeof arg isnt 'undefined'
		segments = segments.slice(parseInt arg)
	for v in segments
		shortened.push v[0]
	shortened.push Path.basename filename
	return shortened.join(Path.sep)

module.exports.pkgjson = Memoize (filename) ->
	return ReadPkgUp.sync(cwd: filename).pkg or {}

