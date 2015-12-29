LogPattern = require '../lib/'
winston = require 'winston'
winston.level = 'debug'
util = require 'util'

winston.info 'foo'
LogPattern.setFormatter winston, winston.transports.Console, preset: 'colored', filename: __filename, winston: winston
winston.info 'foo'
