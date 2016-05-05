log-pattern
-----------
Formatter for logging output, targeted at winston

* [Description](#description)
* [Installation](#installation)
* [Usage](#usage)
* [Macros](#macros)
	* [colors](#colors)
		* [chalk](#chalk)
		* [C](#c)
		* [style](#style)
		* [@](#)
	* [colors](#colors-1)
		* [chalk](#chalk-1)
		* [C](#c-1)
		* [style](#style-1)
		* [@](#-1)
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
		* [?](#-2)
		* [s](#s)
	* [winston](#winston)
		* [level](#level)
		* [label](#label)
		* [LEVEL](#level-1)
		* [message](#message)
		* [!](#-3)
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

### colors

#### chalk
#### C

Renders text in ANSI color with [chalk](https://github.com/chalk/chalk).


```
%chalk{COLOR}(INNER)
%@{COLOR}(INNER)
```

* Requires config: :white_check_mark:
* Takes argument: :white_check_mark:
* Requires argument: :white_check_mark:
* Accepts inner: :white_check_mark:
* Requires inner: :white_check_mark:

#### style
#### @

* Requires config: :white_check_mark:
* Takes argument: :white_check_mark:
* Requires argument: :white_check_mark:
* Accepts inner: :white_check_mark:
* Requires inner: :white_check_mark:

### date

#### date

* Requires config: :white_check_mark:
* Takes argument: :x:
* Requires argument: :x:
* Accepts inner: :x:
* Requires inner: :x:

### env

#### config

* Requires config: :white_check_mark:
* Takes argument: :white_check_mark:
* Requires argument: :white_check_mark:
* Accepts inner: :x:
* Requires inner: :x:

#### env

* Requires config: :white_check_mark:
* Takes argument: :white_check_mark:
* Requires argument: :white_check_mark:
* Accepts inner: :x:
* Requires inner: :x:

### filename

#### pkg

* Requires config: :white_check_mark:
* Takes argument: :white_check_mark:
* Requires argument: :white_check_mark:
* Accepts inner: :x:
* Requires inner: :x:

#### short-path

* Requires config: :white_check_mark:
* Takes argument: :x:
* Requires argument: :x:
* Accepts inner: :white_check_mark:
* Requires inner: :x:

#### git-rev

* Requires config: :white_check_mark:
* Takes argument: :x:
* Requires argument: :x:
* Accepts inner: :x:
* Requires inner: :x:

#### pkgdir

* Requires config: :white_check_mark:
* Takes argument: :x:
* Requires argument: :x:
* Accepts inner: :x:
* Requires inner: :x:

#### -pkgdir

* Requires config: :white_check_mark:
* Takes argument: :x:
* Requires argument: :x:
* Accepts inner: :x:
* Requires inner: :x:

#### path

* Requires config: :white_check_mark:
* Takes argument: :x:
* Requires argument: :x:
* Accepts inner: :white_check_mark:
* Requires inner: :x:

### meta

#### meta

* Requires config: :white_check_mark:
* Takes argument: :x:
* Requires argument: :x:
* Accepts inner: :x:
* Requires inner: :x:

### string

#### uc

* Requires config: :white_check_mark:
* Takes argument: :x:
* Requires argument: :x:
* Accepts inner: :white_check_mark:
* Requires inner: :white_check_mark:

#### lc

* Requires config: :white_check_mark:
* Takes argument: :x:
* Requires argument: :x:
* Accepts inner: :white_check_mark:
* Requires inner: :white_check_mark:

#### pad

* Requires config: :white_check_mark:
* Takes argument: :white_check_mark:
* Requires argument: :white_check_mark:
* Accepts inner: :white_check_mark:
* Requires inner: :white_check_mark:

#### ?

* Requires config: :white_check_mark:
* Takes argument: :x:
* Requires argument: :x:
* Accepts inner: :white_check_mark:
* Requires inner: :white_check_mark:

#### s

* Requires config: :white_check_mark:
* Takes argument: :x:
* Requires argument: :x:
* Accepts inner: :white_check_mark:
* Requires inner: :white_check_mark:

### winston

#### level

* Requires config: :white_check_mark:
* Takes argument: :x:
* Requires argument: :x:
* Accepts inner: :x:
* Requires inner: :x:

#### label

* Requires config: :white_check_mark:
* Takes argument: :x:
* Requires argument: :x:
* Accepts inner: :x:
* Requires inner: :x:

#### LEVEL

* Requires config: :white_check_mark:
* Takes argument: :x:
* Requires argument: :x:
* Accepts inner: :x:
* Requires inner: :x:

#### message

* Requires config: :white_check_mark:
* Takes argument: :x:
* Requires argument: :x:
* Accepts inner: :x:
* Requires inner: :x:

#### !

* Requires config: :white_check_mark:
* Takes argument: :white_check_mark:
* Requires argument: :white_check_mark:
* Accepts inner: :x:
* Requires inner: :x:

#### levelColor

* Requires config: :white_check_mark:
* Takes argument: :x:
* Requires argument: :x:
* Accepts inner: :white_check_mark:
* Requires inner: :white_check_mark:

