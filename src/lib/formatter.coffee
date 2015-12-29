'use strict'
Chalk = require 'chalk'
Winston = require 'winston'

PatternParser = require './parser'
DefaultMacros = require './macros'

PRESETS = 
	'default': '[%level] %message %meta'
	'colored': '[%levelHighlight(%uc(%level))] - %date - %path{name} %message'

module.exports = class PatternFormatter

	constructor: (@config={}) ->
		if not @config.pattern
			@config.preset or= 'default'
			@config.pattern = PRESETS[@config.preset]
		@_loadMacros()
		@_loadPattern()

	_loadMacros : ->
		@macros = DefaultMacros
		@macros[macro.name] = macro for macro in @config.macros?
		return @macros

	_loadPattern: (patfmt) ->
		patfmt or= @config.pattern
		_tree = PatternParser.parse(patfmt, @macros)
		@tree = PatternParser.traverse _tree, (node) =>
			return if typeof node isnt 'object'
			try
				node.macro = @macros[node.name].instance {
					node: node,
					filename: @config.filename
					winston: @config.winston
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
