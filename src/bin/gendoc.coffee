#!/usr/bin/env coffee
Fs = require 'fs'
Path = require 'path'

done = {}
by_set = {}
for name_or_alias, macro of require('../lib/macros')
	continue if name_or_alias isnt macro.name
	continue if done[macro.name]
	done[macro.name] = true
	by_set[macro.macro_set] or= []
	out = ''
	out += "\n#### #{name_or_alias}"
	# out += "\n#### #{macro.name}\n"
	if macro.alias
		for alias in macro.alias
			out += " / #{alias}"
	out += "\n\n"
	out += "* Argument: #{
		if macro.requires_arg   then "**REQUIRED**" else if macro.accepts_arg   then "*ALLOWED*" else ":x:"
		}\n"
	out += "* Inner Text: #{
		if macro.requires_inner then "**REQUIRED**" else if macro.accepts_inner then "*ALLOWED*" else ":x:"
	}\n"
	out += "\n"
	if macro.requires_config and macro.requires_config.length > 0
		out += "* Configuration:\n"
		out += "  * #{v}\n" for v in macro.requires_config
	if macro.description
		out += "\n#{macro.description}\n"
	by_set[macro.macro_set].push out

out = ''
for macro_set of by_set
	out += "\n### #{macro_set}\n"
	out += v for v in by_set[macro_set]

console.log out
