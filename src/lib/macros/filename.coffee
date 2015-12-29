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
	requires_arg: true
	requires_filename: true
	setup: ->
		pkgjson = FindPackageJson(@filename).next()
		@precomputed = pkgjson.value[@arg]

module.exports.push
	name: 'git-rev'
	requires_filename: true

	setup: ->
		gitdir = _find_parent_dir @filename, '.git'
		rev = ChildProcess.execSync "git log -1 --pretty=format:%h", {
			cwd: gitdir
			encoding: 'ascii'
		}
		@precomputed = rev

module.exports.push
	name: 'path'
	accepts_arg: true
	requires_filename: true
	setup: ->
		@arg or= 'name'
		@precomputed = @arg
		tokens = Path.parse(@filename)
		for k in Object.keys(tokens).sort((a,b) -> a.length - b.length)
			@precomputed = @precomputed.replace(k, tokens[k])

