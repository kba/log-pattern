'use strict'
Chalk = require 'chalk'

PatternParser = require './parser'
DefaultMacros = require './macros'

PRESETS =
	'default': '[%level] %message %meta'
	'colored': '[%levelColor(%uc(%level))] - %date - %path{name} %message'

module.exports = class PatternFormatter

	constructor: (opts={}) ->
		if typeof opts is 'string'
			opts = { pattern: opts }
		@config = opts
		if not @config.pattern
			@config.preset or= 'default'
			@config.pattern = PRESETS[@config.preset]
		@_loadMacros()
		@_loadPattern()

	_loadMacros : ->
		@macros = DefaultMacros
		if @config.macros
			for macro in @config.macros
				@macros[macro.name] = macro
		return @macros

	_loadPattern: (patfmt) ->
		patfmt or= @config.pattern
		_tree = PatternParser.parse(patfmt, @macros)
		@tree = PatternParser.traverse _tree, (node) =>
			return if typeof node isnt 'object'
			try
				node.macro = @macros[node.name].instance {
					node: node
					config: @config
				}
			catch e
				console.error PatternParser.errorAtPos(@config.pattern, node.pos)
				throw e
		return @tree

	formatter : ->
		(options) =>
			_stringify = (node) ->
				return node if typeof node is 'string'
				return node.macro.exec(options) unless node.children
				if node.conditions
					inner = []
					for child in node.conditions
						inner.push _stringify child
					return '' unless node.macro.check options, inner.join('')
				inner = []
				for child in node.children
					inner.push _stringify child
				return node.macro.exec options, inner.join('')
			ret = []
			for node,idx in @tree
				ret.push _stringify node
			return ret.join('')
