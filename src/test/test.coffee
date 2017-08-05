Winston = require 'winston'
FmtParser = require '../lib/parser'
PatternFormatter = require '../lib/formatter'
util = require('util')
macros =
	a: 'foo'
	b: 'bar'

dump = (obj) ->
	util.inspect obj, {
		depth: 5
	}

# console.log require.main.children
patfmt = new PatternFormatter(
	#
	# pattern: "[%?(%level)([%level])] %chalk{red}(%env{HOME}) %date %path{name} %!{level} %meta"
	# pattern: "%?(%level)([%level])"
	pattern: "%date %pkg{name}@%pkg{version}/%git-rev [%LEVEL] %levelHighlight(%date) %message %meta"
	filename: __filename
)
# console.log dump patfmt.tree
fmt = patfmt.formatter()
options =
	level: 'debug'
	message: 'foo'
	meta:
		foo : 
			bar: "foo\nbarxenkjewnfewfewkfew"
		quux: [ 1, 2 ]

console.log fmt options
console.log fmt options

testWinston =  ->
	log = new Winston.Logger(
		transports: [
			new Winston.transports.Console(
				level: 'silly'
				formatter: (options) ->
					patfmt.formatter()(options)
			)
		]
	)
	log.silly 'yay'
	log.debug 'yay'
	log.info 'yay'
	log.warn 'yay'
	log.silly 'yay'
	log.debug 'yay'
	log.info 'yay'
	log.warn 'yay'
	log.silly 'yay'
	log.debug 'yay'
	log.info 'yay'
	log.warn 'yay'
	log.silly 'yay'
	log.debug 'yay'
	log.info 'yay'
	log.warn 'yay'
	log.silly 'yay'
	log.debug 'yay'
	log.info 'yay'
	log.warn 'yay'
	log.silly 'yay'
	log.debug 'yay'
	log.info 'yay'
	log.warn 'yay'
testWinston()
# console.log fmter.exec({
	# level: 'debug'
# })

# console.log dump FmtParser.parse 'root-text-1%a(a-text-1 %b(b-text) a-text-2)'
# console.log dump FmtParser.parse 'root-text-1%a(a-text %b(b-parse %c){b-arg}){a-arg}'
