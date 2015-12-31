test = require('tape')
PatternFormatter = require '../lib/formatter'
Path = require 'path'
Winston = require 'winston'
_pkg = require('read-pkg-up').sync()
PACKAGE_JSON = _pkg.pkg
PACKAGE_DIR = Path.dirname(_pkg.path)

fmt = (pat, args...) -> 
	patFmt = new PatternFormatter(pattern: pat, filename: __filename, winston: Winston)
	return patFmt.formatter().apply patFmt, args

test 'string', (t) ->
	t.plan 5
	t.equals fmt("%uc(foo)"), 'FOO', 'string/uc'
	t.equals fmt("%lc(FOO)"), 'foo', 'string/lc'
	t.equals fmt("%?()(FOO)"), '', 'string/? notok'
	t.equals fmt("%?(something)(FOO)"), 'FOO', 'string/? ok'
	t.equals fmt('%s(|foo|000|blafoobla)'), 'bla000bla', 's|||'

test 'chalk', (t) ->
	t.plan 3
	t.equals fmt("%chalk{red}(red)"), '\x1b[31mred\x1b[39m', 'colors/chalk{red}'
	t.equals fmt("%chalk{red bold}(red)"), '\x1b[1m\x1b[31mred\x1b[39m\x1b[22m', 'colors/chalk{red bold}'
	t.equals fmt("%chalk{red bold bold}(red)"), '\x1b[1m\x1b[31mred\x1b[39m\x1b[22m', 'colors/chalk{red bold}'

test 'date', (t) ->
	t.plan 1
	t.equals fmt("%date{yyyy}"), '2015', 'date/date{YYYY}'

test 'env', (t) ->
	t.plan 1
	process.env.FOO='bar'
	t.equals fmt("%env{FOO}"), 'bar', 'env/env{FOO}'

test 'filename', (t) ->
	t.plan 10
	t.equals fmt("%pkg{name}"), PACKAGE_JSON.name, 'filename/pkg{name}'
	t.equals fmt("%pkg{name}%pkg{version}"), PACKAGE_JSON.name + PACKAGE_JSON.version, 'filename/pkg{name} + pkg{version}'
	t.equals fmt("%pkg{version}"), PACKAGE_JSON.version, 'filename/pkg{version}'
	git_rev = fmt("%git-rev")
	t.ok typeof git_rev is 'string' and git_rev.length == 7, "filename/git-rev"
	t.equals fmt("%path"), __filename, 'filename/path = %path{%fullname}'
	t.equals fmt("%path{%dir}"), Path.parse(__filename).dir, 'filename/path{%dir}'
	t.equals fmt("%path{%dir/%name}(/foo/bar)"), '/foo/bar', 'filename/path{%dir/%name} with inner'
	t.equals fmt("%short-path(/foo/bar/quux/bla)"), '/f/b/q/bla', 'short-path'
	t.equals fmt("%short-path{-2}(/foo/bar/quux/bla)"), 'b/q/bla', 'short-path{-1}'
	t.equals fmt("%path{%-pkgdir}"), Path.relative(PACKAGE_DIR, __filename), 'short-path{-1}'

test 'meta', (t) ->
	t.plan 5
	t.equals fmt("%meta{colors=false}", meta: {foo:42}), '{ foo: 42 }', 'meta/meta{colors=false}'
	t.equals fmt("%meta{colors=false,inspect=false}", meta: {foo:42}), '{\n  "foo": 42\n}', 'meta/meta{colors=false,inspect=false}'
	t.equals fmt("%meta{inspect=false,indent=4}", meta: {foo:42}), '{\n    "foo": 42\n}', 'meta/meta{colors=false,inspect=false,indent=4}'
	cyclic = {'foo':'bar'}
	cyclic.bar = cyclic
	t.throws (-> fmt "%meta{decycle=0}", meta: cyclic), /TypeError.*circular/, 'meta/meta{decycle=0} notok'
	t.doesNotThrow (-> fmt "%meta{decycle=1}", meta: cyclic), /TypeError.*circular/, 'meta/meta{decycle=1} ok'

test 'winston', (t) ->
	t.plan 8
	t.equal fmt("%level", level: 'debug'), 'debug', 'winston/level'
	t.equal fmt("%LEVEL", level: 'debug'), 'DEBUG', 'winston/LEVEL'
	t.equal fmt("%LEVEL", level: 'debug'), fmt("%uc(%level)", level:'debug'), 'winston/LEVEL = %uc(%level)'
	t.equal fmt("%message", message: 'foo'), 'foo', 'winston/message'
	t.equal fmt("%label", label: 'label1'), 'label1', 'winston/label'
	t.equal fmt("%!{foo}", foo: 'bar'), 'bar', 'winston/!{message}'
	t.equal fmt("%levelColor(foo)", level: 'debug'), '\x1b[34mfoo\x1b[39m', 'winston/levelColor (@winston)'
	t.equal fmt("%levelColor{debug=green}(foo)", level: 'debug'), '\x1b[32mfoo\x1b[39m', 'winston/levelColor (@arg)'
