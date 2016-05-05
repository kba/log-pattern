Path = require 'path'
Utils = require '../utils'

module.exports = []

module.exports.push
	name: 'pkg'
	requires_arg: true
	setup: ->
		if @config.filename
			@precomputed = Utils.pkgjson(@config.filename)[@arg]
	exec: (options, inner) ->
		return Utils.pkgjson(inner)[@arg] if inner
		return @precomputed if @precomputed
		return @config.empty_string
	description: '''
	A value from the first package.json file above the filename in the file tree.
	'''

module.exports.push
	name: 'short-path'
	accepts_arg: true
	accepts_inner: true
	setup: ->
		if @config.filename
			@precomputed = Utils.shortenPath(Path.dirname(@config.filename), @arg)
	exec: (options, inner) ->
		return Utils.shortenPath(inner, @arg) if inner
		return @precomputed if @precomputed
		return @config.empty_string
	description: '''
	Turns the directory component of a filename into a shortened version:

	```
	%short-path(/foo/bar/baz/quux)
	// -> "f/b/b"
	```
	'''

module.exports.push
	name: 'git-rev'
	setup: ->
		if @config.filename
			@precomputed = Utils.gitrev(@config.filename)
	exec: (options, inner) ->
		return Utils.gitrev(inner) if inner
		return @precomputed if @precomputed
		return @config.empty_string
	description: '''
	The shorthand SHA of the last git commit of the filename.
	'''

module.exports.push
	name: 'pkgdir'
	accepts_arg: true
	setup: ->
		if @config.filename
			@precomputed = Utils.pkgdir(@config.filename)
	exec: (options, inner) ->
		return Utils.pkgdir(inner) if inner
		return @precomputed if @precomputed
		return @config.empty_string
	description: '''
	Absolute path of the first parent directory of the filename that contains a `package.json`.
	'''

module.exports.push
	name: '-pkgdir'
	accepts_arg: true
	setup: ->
		@precomputed = Utils.pkgdir_rel @config.filename if @config.filename
	exec: (options, inner) ->
		return Utils.pkgdir_rel inner if inner
		return @precomputed if @precomputed
		return @config.empty_string
	description: '''
	Relative path of the first parent directory of the filename that contains a `package.json`.
	'''

module.exports.push
	name: 'path'
	accepts_arg: true
	accepts_inner: true
	setup: ->
		@arg or= '%fullname'
		if @config.filename
			@precomputed = Utils.replace_path_tokens(@config.filename, @arg)
	exec : (options, inner) ->
		return Utils.replace_path_tokens(inner, @arg) if inner
		return @precomputed if @precomputed
		return @config.empty_string
	description: '''
	Replaces the filename with tokens passed as arguments, as returned by
	[`path.parse`](https://nodejs.org/api/path.html#path_path_parse_path)

	```
	// {filename: '/foo/bar/baz/quux.ext'}
	%path(%fullname)
	// -> "/foo/bar/baz/quux.ext"
	%path(%base)
	// -> "quux.ext"
	%path(%ext)
	// -> ".ext"
	%path(%name)
	// -> "quux"
	%path(%dir)
	// -> "/foo/bar/baz"
	```
	'''
