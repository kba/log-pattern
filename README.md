log-pattern
-----------
Formatter for logging output, targeted at winston

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
