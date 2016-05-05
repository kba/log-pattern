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

* Config: :x:
* Arguments:
  * color
* Nestable: :white_check_mark:

Renders text in ANSI color with [chalk](https://github.com/chalk/chalk).

```
%chalk{COLOR}(INNER)
%@{COLOR}(INNER)
```

#### style
#### @


