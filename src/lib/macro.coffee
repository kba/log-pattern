Fs = require 'fs'
Path = require 'path'

EMPTY_STRING = ''
RE_SPLIT_COMMA = new RegExp('\s*,\s*')
RE_SPLIT_EQUALS = new RegExp('\s*=\s*')

module.exports = class Macro

	can_inner: false
	must_inner: false

	can_arg: false
	must_arg: false

	can_inner: false
	must_inner: false

	condition: false

	must_module: false

	throw_error: (msg) ->
		throw new Error("#{@macro_set}/#{@name}: #{msg}")

	setup: ->
		# Nothing by default

	@create: (opts={}) ->
		if not opts.name
			throw new Error("Must define name for macro")
		if not opts.macro_set
			throw new Error("Must specify macro_set for macro '#{opts.name}'")
		return (node, module) -> 
			new Macro(opts, node, module)

	constructor: (opts, node, @module) ->
		@[k] = v for k,v of opts
		if @must_arg      then @can_arg = true
		if @conditional   then @must_inner = true
		if @must_inner    then @can_inner = true
		if not @can_arg     and node.arg            then @throw_error("takes no argument")
		if @must_arg        and not node.arg        then @throw_error("requires argument")
		if not @can_inner   and node.children       then @throw_error("takes no inner")
		if @must_inner      and not node.children   then @throw_error("requires inner")
		if @conditional     and not node.conditions then @throw_error("requires condition")
		if not @conditional and node.conditions     then @throw_error("takes no condition")
		if @must_module     and not @module         then @throw_error("requires module")
		@arg = node.arg
		@setup()
		if @conditional and not opts.check
			@throw_error("Must pass 'check' function for conditional")
		if not opts.exec and not @precomputed
			@throw_error("Must pass 'exec' function or set 'precomputed'")

	exec: (options) ->
		return @precomputed if 'precomputed' of @
		@throw_error "exec implemented"
