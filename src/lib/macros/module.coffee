Path = require 'path'
ChildProcess = require 'child_process'
FindPackageJson = require 'find-package-json'
Fs = require 'fs'

_find_parent_dir = (root, check) ->
	if root is Path.sep
		return null
	if Fs.existsSync "#{root}/#{check}"
		return root
	else
		return _find_parent_dir Path.dirname(root), check

module.exports = []

module.exports.push
	name: 'pkg'
	must_arg: true
	must_module: true
	setup: ->
		pkgjson = FindPackageJson(@module.filename).next()
		@precomputed = pkgjson.value[@arg]

module.exports.push
	name: 'git-rev'
	must_module: true

	setup: ->
		gitdir = _find_parent_dir @module.filename, '.git'
		rev = ChildProcess.execSync "git log -1 --pretty=format:%h", {
			cwd: gitdir
			encoding: 'ascii'
		}
		@precomputed = rev

module.exports.push
	name: 'path'
	can_arg: true
	must_module: true
	setup: ->
		@arg or= 'basename'
		@precomputed = @arg
		tokens = Path.parse(@module.filename)
		for k,v of tokens
			@precomputed = @precomputed.replace(k, v)

