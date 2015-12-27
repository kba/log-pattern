util = require 'util'

MACRO_SIGIL = '%'
CONDITION_SIGIL = '%'
OPEN_PARSE = '('
CLOSE_PARSE = ')'
OPEN_ARG = '{'
CLOSE_ARG = '}'
TRAVERSE_PRE_ORDER = 'PRE-ORDER'
TRAVERSE_POST_ORDER = 'BREADTH-FIRST'

ALLOWED_MACRO_CHARS = new RegExp("[-A-Za-z0-9_\?!]")

_showpos = (str, i) ->
	ret = "#{str}\n"
	ret += ' ' for x in [0 .. i - 1]
	ret += 'Δ'
	ret += "\n"
	ret += ' ' for x in [0 .. i - 1]
	ret += "│ *HERE*"
	return ret

_last = (arr) ->
	return arr[arr.length - 1]

Exception =
	unknown_macro: (str, i) ->
		new Error("Unknown macro \n#{_showpos str, i}")
	unbalanced: (str, i, stack, parens) ->
		msg = "Unbalanced parens."
		msg += "Open parens: <<< #{parens.join ' '} >>>"
		msg += "Open macro: #{_last(stack).name}"
		msg += "\n"
		msg += _showpos(str, i)
		new Error(msg)
	illegal_state: (str, i) ->
		new Error("Illegal parse state: \n#{_showpos str, i}")

_find_macro = (macros, str, i) ->
	if macros
		for macro in macros
			return macro if str.substr(i).startsWith macro
		throw Exception.unknown_macro(str, i)
	j = i
	while j++ < str.length
		break unless ALLOWED_MACRO_CHARS.test str[j]
	return str.substring(i, j)

_traverse = (type, tree, fn, ctx, args) ->
	for node,idx in tree
		if type is TRAVERSE_POST_ORDER
			if node.children
				_traverse type, node.children, fn, ctx, args
			fn.apply ctx, [node, args]
		else if type is TRAVERSE_PRE_ORDER
			fn.apply ctx, [node, args]
			if node.conditions
				_traverse type, node.conditions, fn, ctx, args
			if node.children
				_traverse type, node.children, fn, ctx, args
	return tree

module.exports =

	traverse: (tree, fn, ctx, args) ->
		args or= []
		return _traverse(TRAVERSE_PRE_ORDER, tree, fn, ctx, args)

	errorAtPos : _showpos

	###
	# Parse a format pattern
	#
	# @param str [string] The format pattern
	# @param macros [object] A list of macro names or an object with macro names as keys
	# @return [array] Parse tree
	###
	parse : (str, macros) ->
		if not str or typeof str isnt 'string'
			throw new Error("Usage: FmtParser.parse(str, macros)")
		if macros
			macros = Object.keys(macros) unless util.isArray macros
			macros = macros.sort (a,b) -> return b.length - a.length

		parens = []
		root = {'format': str, 'children':[]}
		stack = [ root ]
		i = 0
		while i < str.length
			cur = str[i]
			elem = _last(stack)
			__last_child = -> _last(elem.children)
			__add_child = (child) ->
				elem.children.push child
				return child
			__concat = (str) ->
				if typeof __last_child() isnt 'string'
					__add_child(str)
				else
					elem.children[elem.children.length - 1] += str

			if cur is MACRO_SIGIL
				i += __add_child(name: _find_macro(macros, str, i+1), pos: i).name.length
			else if cur is OPEN_PARSE and
			typeof __last_child() is 'object' and
			not(__last_child().children and __last_child().conditions)
				parens.push OPEN_PARSE
				if __last_child().children
					__last_child().conditions = __last_child().children
				__last_child().children = []
				stack.push __last_child()
			else if cur is CLOSE_PARSE and parens.indexOf(OPEN_PARSE) > -1
				parens.pop()
				stack.pop()
			else if cur is OPEN_ARG and typeof __last_child() is 'object'
				parens.push OPEN_ARG
				__last_child().arg = ''
				while ++i < str.length
					if str[i] is CLOSE_ARG
						parens.pop()
						break
					__last_child().arg += str[i]
			else
				__concat cur
			i += 1
		if stack.length != 1 or parens.length > 0
			throw Exception.unbalanced(str, i, stack, parens)
		return stack.pop().children
