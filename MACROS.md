# Macros

<!-- BEGIN-MARKDOWN-TOC coffee src/bin/gendoc-coffee -->
* [colors](#colors)
	* [chalk / C](#chalk--c)
	* [style / @](#style--)
* [date](#date)
	* [date](#date-1)
* [env](#env)
	* [config](#config)
	* [env](#env-1)
* [filename](#filename)
	* [pkg](#pkg)
	* [short-path](#short-path)
	* [git-rev](#git-rev)
	* [pkgdir](#pkgdir)
	* [-pkgdir](#-pkgdir)
	* [path](#path)
* [meta](#meta)
	* [meta](#meta-1)
* [process](#process)
	* [pid](#pid)
* [string](#string)
	* [uc](#uc)
	* [lc](#lc)
	* [pad](#pad)
	* [?](#)
	* [s](#s)
* [winston](#winston)
	* [options / !](#options--)
	* [level](#level)
	* [label](#label)
	* [LEVEL](#level-1)
	* [message](#message)
	* [levelColor](#levelcolor)

<!-- END-MARKDOWN-TOC -->

<!-- BEGIN-EVAL coffee src/bin/gendoc.coffee -->

## colors

Macros for adding ANSI highlighting and coloring to text.

### chalk / C

* Argument: :black_circle:
* Inner Text: :black_circle:


Renders text in ANSI color with [chalk](https://github.com/chalk/chalk).'

```
%chalk{red}(some text)
%@{blue bold}(bla)
```

### style / @

* Argument: :black_circle:
* Inner Text: :black_circle:
* Configuration:
  * styles


Style the inner text using [chalk](https://github.com/chalk/chalk), but
referring to named styles defined in the config.

```js
patFmt = LogPattern.PatternFormaater({
	styles:{
		'date': 'red bold',
		'message': 'green underline'
	}
});
fmt = patFmt.formatter({'pattern': '%style{date}(%date) ---- %@{message}(foo!)'});
fmt()
// -> "01:02:03.432 - foo!"
//    |____________| |   |
//       green     | |   |
//     underline   |_|   |
//               default |
//                   |___|
//                    red
//                    bold
```

## date

Macros for printing the current date.

### date

* Argument: :white_circle:
* Inner Text: :x:


Return the current date, formatted by [dateformat](https://github.com/felixge/node-dateformat).

```
%date{yyyy}
// -> "2016"
%date
// -> "01:02:03.123"
```

The argument defaults to `HH:mm:ss.l`

## env

Macros for constants from environment or configuration variables.

### config

* Argument: :black_circle:
* Inner Text: :x:


Value of a configuration option, i.e. a constant.

### env

* Argument: :black_circle:
* Inner Text: :x:


Value of an environment variable

```
%env{NODE_ENV}
%env{PATH}
```

## filename

Macros for manipulating a filename. All these macros expect a filename
parameter and have the same logic for finding it:

* If the config contains `filename`: Use `config.filename` as the filename.
* If there is inner text, use the inner text as the filename.
* Otherwise return the empty string.

### pkg

* Argument: :black_circle:
* Inner Text: :x:


A value from the first package.json file above the filename in the file tree.

### short-path

* Argument: :white_circle:
* Inner Text: :white_circle:


Turns the directory component of a filename into a shortened version:

```
%short-path(/foo/bar/baz/quux)
// -> "f/b/b"
```

### git-rev

* Argument: :x:
* Inner Text: :x:


The shorthand SHA of the last git commit of the filename.

### pkgdir

* Argument: :white_circle:
* Inner Text: :x:


Absolute path of the first parent directory of the filename that contains a `package.json`.

### -pkgdir

* Argument: :white_circle:
* Inner Text: :x:


Relative path of the first parent directory of the filename that contains a `package.json`.

### path

* Argument: :white_circle:
* Inner Text: :white_circle:


Replaces the filename with tokens passed as arguments, as returned by
[`path.parse`](https://nodejs.org/api/path.html#path_path_parse_path)

```
// {filename: '/foo/bar/baz/quux.ext'}
%path(%fullname)
// -> "/foo/bar/baz/quux.ext"
%path(%base)
// -> "quux.ext"
%path(%ext)
// -> ".ext"
%path(%name)
// -> "quux"
%path(%dir)
// -> "/foo/bar/baz"
```

## meta

Handles arbitrary data passed as `meta` key to formatter function.

### meta

* Argument: :white_circle:
* Inner Text: :x:

Handles a `meta` element of the object passed to the formatter function to pretty print it.

Can be configured with key-value pairs passed as argument.

```
// {meta:{foo:{bar:42}}}
%meta{decycle=true,colors=true}
// {
//   foo: {
//     bar: 42
//   }
// }
```

## process

### pid

* Argument: :x:
* Inner Text: :x:


Return the PID of the current process

```
%pid
// -> "17432"
```

## string

Macros for string manipulation.

### uc

* Argument: :x:
* Inner Text: :black_circle:


Converts a string to upper case.

### lc

* Argument: :x:
* Inner Text: :black_circle:


Converts a string to lower case.

### pad

* Argument: :black_circle:
* Inner Text: :black_circle:


Pads a string with spaces or truncates it to fit into a fixed length field.

Uses [pad](http://github.com/wdavidw/node-pad).

### ?

* Argument: :x:
* Inner Text: :black_circle:


**CONDITION**

Matches if the inner text is not an empty string or does not only contain whitespace.

### s

* Argument: :x:
* Inner Text: :black_circle:


```
%s(|foo|bar| blafoobla) -> blabarbla
```

## winston

Macros related to logging with winston.

### options / !

* Argument: :black_circle:
* Inner Text: :x:


Any value in the object passed to the formatter function.

```
// {foo:bar}
%!{foo}
// -> "bar"
```

### level

* Argument: :x:
* Inner Text: :x:


Logging level.

### label

* Argument: :x:
* Inner Text: :x:


Label of the current logger

### LEVEL

* Argument: :x:
* Inner Text: :x:


Upper case version of the logging level.

### message

* Argument: :x:
* Inner Text: :x:


Log message.

### levelColor

* Argument: :white_circle:
* Inner Text: :black_circle:


Colorize output depending on the logging level.

<!-- END-EVAL -->
