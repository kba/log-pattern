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

module.exports.push
	name: 'git-rev'
	setup: ->
		if @config.filename
			@precomputed = Utils.gitrev(@config.filename)
	exec: (options, inner) ->
		return Utils.gitrev(inner) if inner
		return @precomputed if @precomputed
		return @config.empty_string

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

module.exports.push
	name: '-pkgdir'
	accepts_arg: true
	setup: ->
		@precomputed = Utils.pkgdir_rel @config.filename if @config.filename
	exec: (options, inner) ->
		return Utils.pkgdir_rel inner if inner
		return @precomputed if @precomputed
		return @config.empty_string

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
