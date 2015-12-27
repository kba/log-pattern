Fs = require 'fs'
Path = require 'path'
Macro = require '../macro'

module.exports = {}
for mod_name in Fs.readdirSync Path.join(__dirname)
	macro_set = Path.parse(mod_name).name
	for macro in require("./#{macro_set}")
		if macro.name of module.exports
			throw new Error("Duplicate definition of #{opts.name} in macro macro_set #{macro_set}")
		macro.macro_set = macro_set
		module.exports[macro.name] = Macro.create(macro)

