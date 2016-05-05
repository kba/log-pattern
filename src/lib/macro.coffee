Fs = require 'fs'
Path = require 'path'

module.exports = class MacroBuilder

	accepts_inner: false
	requires_inner: false

	accepts_arg: false
	requires_arg: false

	requires_config: []

	is_condition: false
	
	@allowedOpts = {
		'name'
		'alias'
		'description'
		'macro_set'
		'accepts_inner'
		'requires_inner'
		'accepts_arg'
		'requires_arg'
		'requires_config'
		'is_condition'
		'setup'
		'exec'
		'check'
	}

	constructor: (opts={}) ->
		for opt of opts
			continue if opt[0] is '_'
			if opt not of MacroBuilder.allowedOpts
				throw("Unknown property #{opt} for #{opts.macro_set}/#{opts.name}")
		@[k] = v for k,v of opts
		if not opts.name
			throw new Error("Must define name for macro")
		if not opts.macro_set
			throw new Error("Must specify macro_set for macro '#{opts.name}'")
		if @requires_arg   then @accepts_arg = true
		if @is_condition   then @requires_inner = true
		if @requires_inner then @accepts_inner = true
		if @is_condition and not @check
			@throw_error("Must pass 'check' function for is_condition")
		@setup or= @default_setup

	instance: (opts={}) ->
		if not opts.node
			throw new Error("Must pass 'node' to Macro instance.")
		opts.config or= {}
		if not @accepts_arg   and opts.node.arg            then @throw_error("takes no argument")
		if @requires_arg      and not opts.node.arg        then @throw_error("requires argument")
		if not @accepts_inner and opts.node.children       then @throw_error("takes no inner")
		if @requires_inner    and not opts.node.children   then @throw_error("requires inner")
		if @is_condition      and not opts.node.conditions then @throw_error("requires condition")
		if not @is_condition  and opts.node.conditions     then @throw_error("takes no condition")
		for config_opt in @requires_config
			if not opts.config[config_opt] then @throw_error("requires config.#{config_opt}")
		return new Macro(@, opts)

	throw_error: (msg) ->
		throw new Error("#{@macro_set}/#{@name}: #{msg}")

	default_setup: ->
		# do nothing by default

	default_exec: (options, inner) ->
		return @precomputed if 'precomputed' of @
		@throw_error "exec not implemented"

Macro = class Macro

	constructor: (builder, opts) ->
		@[k] = builder[k] for k of builder
		@arg = opts.node.arg
		@config = opts.config
		@setup()
		if not @exec
			if @precomputed or @precomputed is ''
				@exec = builder.default_exec
			else
				@throw_error("Must pass 'exec' function or set 'precomputed'")
