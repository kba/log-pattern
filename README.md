log-pattern
-----------
Formatter for logging output, targeted at winston

<!-- :GenTocGFM -->
* [Description](#description)
* [Installation](#installation)
* [Usage](#usage)
* [Macros](#macros)
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
	* [string](#string)
		* [uc](#uc)
		* [lc](#lc)
		* [pad](#pad)
		* [?](#)
		* [s](#s)
	* [winston](#winston)
		* [level](#level)
		* [label](#label)
		* [LEVEL](#level-1)
		* [message](#message)
		* [!](#-1)
		* [levelColor](#levelcolor)

## Description

...

## Installation

```
npm install --save log-pattern
```

## Usage

```js
var LogPattern = require('log-pattern');
fmt = LogPattern.formatter({ pattern: '%date{yyyy} - %uc(%path)' });
console.log(fmt.format({filename: '/bar/quux'}))
// -> "2016 - /BAR/QUUX"
```

## Macros
<!-- :r!coffee src/bin/gendoc.coffee -->

### colors

#### chalk / C

* Argument: **REQUIRED**
* Inner Text: **REQUIRED**


Renders text in ANSI color with [chalk](https://github.com/chalk/chalk).'

```
%chalk{red}(some text)
%@{blue bold}(bla)
```

#### style / @

* Argument: **REQUIRED**
* Inner Text: **REQUIRED**

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

### date

#### date

* Argument: *ALLOWED*
* Inner Text: :x:


Return the current date, formatted by [dateformat](https://github.com/felixge/node-dateformat).

```
%date{yyyy}
// -> "2016"
%date
// -> "01:02:03.123"
```

The argument defaults to `HH:mm:ss.l`

### env

#### config

* Argument: **REQUIRED**
* Inner Text: :x:


#### env

* Argument: **REQUIRED**
* Inner Text: :x:


### filename

#### pkg

* Argument: **REQUIRED**
* Inner Text: :x:


#### short-path

* Argument: *ALLOWED*
* Inner Text: *ALLOWED*


#### git-rev

* Argument: :x:
* Inner Text: :x:


#### pkgdir

* Argument: *ALLOWED*
* Inner Text: :x:


#### -pkgdir

* Argument: *ALLOWED*
* Inner Text: :x:


#### path

* Argument: *ALLOWED*
* Inner Text: *ALLOWED*


### meta

#### meta

* Argument: *ALLOWED*
* Inner Text: :x:


### string

#### uc

* Argument: :x:
* Inner Text: **REQUIRED**


Converts a string to upper case.

#### lc

* Argument: :x:
* Inner Text: **REQUIRED**


Converts a string to lower case.

#### pad

* Argument: **REQUIRED**
* Inner Text: **REQUIRED**


Pads a string with spaces or truncates it to fit into a fixed length field.

Uses [pad](http://github.com/wdavidw/node-pad).

#### ?

* Argument: :x:
* Inner Text: **REQUIRED**


** CONDITION **

Matches if the inner text is not an empty string or does not only contain whitespace.

#### s

* Argument: :x:
* Inner Text: **REQUIRED**


```
%s(|foo|bar| blafoobla) -> blabarbla
```

### winston

#### level

* Argument: :x:
* Inner Text: :x:


#### label

* Argument: :x:
* Inner Text: :x:


#### LEVEL

* Argument: :x:
* Inner Text: :x:


#### message

* Argument: :x:
* Inner Text: :x:


#### !

* Argument: **REQUIRED**
* Inner Text: :x:


#### levelColor

* Argument: *ALLOWED*
* Inner Text: **REQUIRED**


