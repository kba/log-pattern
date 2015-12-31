Chalk = require 'chalk'
Uniq = require 'uniq'
FindUp = require 'find-up'
ReadPkgUp = require 'read-pkg-up'
ChildProcess = require 'child_process'
Path = require 'path'
Memoize = require 'memoizee'

Utils = module.exports

Utils.EMPTY_STRING = EMPTY_STRING = ''

Utils.RE_SPLIT_COMMA = RE_SPLIT_COMMA = new RegExp('\\s*,\\s*')
Utils.RE_SPLIT_EQUALS = RE_SPLIT_EQUALS = new RegExp('\\s*=\\s*')
Utils.RE_SPLIT_SPACE_DOT = RE_SPLIT_SPACE_DOT = new RegExp('[\\.\\s]+')

Utils.splitCommaEquals = Memoize (str) ->
	ret = {}
	for kvpair in str.split RE_SPLIT_COMMA
		[k,v] = kvpair.split RE_SPLIT_EQUALS
		ret[k] = v
	return ret

Utils.parseColor = (str) ->
	_colorize = Chalk
	styles = Uniq str.split(RE_SPLIT_SPACE_DOT).sort()
	if styles.length == 0
		return (x) -> x
	for style in styles
		if style not of Chalk
			throw("Not a valid chalk style: '#{style}'")
		_colorize = _colorize[style]
	return _colorize

Utils.pkgdir = Memoize (filename) ->
	return Path.dirname(FindUp.sync 'package.json', cwd: filename)

Utils.pkgdir_rel = Memoize (filename) ->
	return Path.dirname(Path.relative(Utils.pkgdir(filename), filename))

Utils.replace_path_tokens = Memoize (filename, arg) ->
	tokens = Path.parse(filename)
	tokens.fullname = filename
	tokensOrder = Object.keys(tokens).sort((a,b) -> b.length - a.length)
	for k in tokensOrder
		arg = arg.replace('%'+k, tokens[k])
	return arg

Utils.gitrev = Memoize (filename) ->
	gitdir = FindUp.sync '.git', cwd: filename
	rev = ChildProcess.execSync "git log -1 --pretty=format:%h", {
		cwd: gitdir
		encoding: 'ascii'
	}

Utils.shortenPath = Memoize (filename, arg) ->
	shortened = []
	segments = Path.dirname(filename).split(Path.sep)
	if typeof arg isnt 'undefined'
		segments = segments.slice(parseInt arg)
	for v in segments
		shortened.push v[0]
	shortened.push Path.basename filename
	return shortened.join(Path.sep)

Utils.pkgjson = Memoize (filename) ->
	return ReadPkgUp.sync(cwd: filename).pkg or {}

Utils.colorizeFunction = (def) ->
	colorizers = {}
	for styleName,styles of def
		colorizers[styleName] = Utils.parseColor styles
	return (styleName, inner) ->
		return inner unless styleName of colorizers
		return colorizers[styleName](inner)

