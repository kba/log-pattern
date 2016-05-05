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
	out += "\n#### #{name_or_alias}\n"
	# out += "\n#### #{macro.name}\n"
	if macro.alias
		for alias in macro.alias
			out += "#### #{alias}\n"
	out += "\n"
	if macro.description
		out += "#{macro.description}\n\n"
	if macro.example
		out += "\n```\n#{macro.example}\n```\n\n"
	out += "* Requires config: #{   if macro.requires_config then ":white_check_mark:" else ":x:"}\n"
	out += "* Takes argument: #{    if macro.requires_arg    then ":white_check_mark:" else ":x:"}\n"
	out += "* Requires argument: #{ if macro.requires_arg    then ":white_check_mark:" else ":x:"}\n"
	out += "* Accepts inner: #{     if macro.accepts_inner   then ":white_check_mark:" else ":x:"}\n"
	out += "* Requires inner: #{    if macro.requires_inner  then ":white_check_mark:" else ":x:"}\n"
	by_set[macro.macro_set].push out

out = ''
for macro_set of by_set
	out += "\n### #{macro_set}\n"
	out += v for v in by_set[macro_set]

console.log out
