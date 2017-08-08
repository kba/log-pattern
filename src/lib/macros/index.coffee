Path = require 'path'
MacroBuilder = require('../macro')
IsArray = require('util').isArray

bundles = {
	colors:   Array.from(require('./colors')),
	date:     Array.from(require('./date')),
	env:      Array.from(require('./env')),
	filename: Array.from(require('./filename')),
	meta:     Array.from(require('./meta')),
	process:  Array.from(require('./process')),
	string:   Array.from(require('./string')),
	winston:  Array.from(require('./winston')),
}

conflicts = {}
module.exports = {}
for bundleName of bundles
	bundle = bundles[bundleName]
	for macro in bundle
		if macro.name of module.exports
			throw new Error(
				"Duplicate definition of #{macro.name} in macro #{macro_set} of #{bundleName}")
		macro.macro_set = bundleName
		macroBuilder = new MacroBuilder(macro)
		module.exports[macro.name] = macroBuilder
		if IsArray macro.alias
			for alias in macro.alias
				module.exports[alias] = macroBuilder
