#!/usr/bin/env coffee
Fs = require 'fs'
Path = require 'path'

macro_sets =
	colors:
		description: '''
		Macros for adding ANSI highlighting and coloring to text.
		'''
	date:
		description: '''
		Macros for printing the current date.
		'''
	env:
		description: '''
		Macros for constants from environment or configuration variables.
		'''
	filename:
		description: '''
		Macros for manipulating a filename. All these macros expect a filename
		parameter and have the same logic for finding it:
		
		* If the config contains `filename`: Use `config.filename` as the filename.
		* If there is inner text, use the inner text as the filename.
		* Otherwise return the empty string.
		'''
	meta:
		description: '''
		Handles arbitrary data passed as `meta` key to formatter function.
		'''
	string:
		description: '''
		Macros for string manipulation.
		'''
	winston:
		description: '''
		Macros related to logging with winston.
		'''

done = {}
by_set = {}
for name_or_alias, macro of require('../lib/macros')
	continue if name_or_alias isnt macro.name
	continue if done[macro.name]
	done[macro.name] = true
	by_set[macro.macro_set] or= []
	out = ''
	out += "\n### #{name_or_alias}"
	# out += "\n### #{macro.name}\n"
	if macro.alias
		for alias in macro.alias
			out += " / #{alias}"
	out += "\n\n"
	out += "* Argument: #{
		if macro.requires_arg then ":black_circle:" else if macro.accepts_arg then ":white_circle:" else ":x:"
		}\n"
	out += "* Inner Text: #{
		if macro.requires_inner then ":black_circle:" else if macro.accepts_inner then ":white_circle:" else ":x:"
	}\n"
	if macro.requires_config and macro.requires_config.length > 0
		out += "* Configuration:\n"
		out += "  * #{v}\n" for v in macro.requires_config
	out += "\n"
	if macro.description
		out += "\n#{macro.description}\n"
	by_set[macro.macro_set].push out

out = ''
for macro_set of by_set
	out += "\n## #{macro_set}\n"
	if macro_sets[macro_set]?.description
		out += "\n#{macro_sets[macro_set].description}\n"
	out += v for v in by_set[macro_set]

console.log out
