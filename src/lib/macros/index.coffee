Fs = require 'fs'
Path = require 'path'
MacroBuilder = require('../macro')
IsArray = require('util').isArray

conflicts = {}
module.exports = {}
for mod_name in Fs.readdirSync Path.join(__dirname)
	macro_set = Path.parse(mod_name).name
	for macro in require("./#{macro_set}")
		if macro.name of module.exports
			throw new Error("Duplicate definition of #{opts.name} in macro macro_set #{macro_set}")
		macro.macro_set = macro_set
		macroBuilder = new MacroBuilder(macro)
		module.exports[macro.name] = macroBuilder
		if IsArray macro.alias
			for alias in macro.alias
				module.exports[alias] = macroBuilder
