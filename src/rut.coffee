((root, factory) ->

	if typeof define is 'function' && define.amd
		define ->
			(root.Rut = factory())
	else if typeof exports is 'object'
		module.exports = factory();
	else
		root.Rut = factory()

	return

)(this, ->

	class Rut

		constructor: (rut, withoutCheckDigit) ->
			@setRut rut, withoutCheckDigit

		setRut: (rut, withoutCheckDigit = false) ->
			throw new Error 'rut tiene que ser string' if typeof rut isnt 'string'

			@rut = if withoutCheckDigit then _cleanRut rut else _cleanRut rut.substr 0, rut.length - 1

			@checkDigit = if withoutCheckDigit then _getCheckDigit rut else rut.substr(rut.length - 1).toUpperCase()

			@isValid = @validate()

			return

		validate: ->
			return false unless /([0-9]|k)/i.test @checkDigit

			checkDigit = _getCheckDigit @rut

			@checkDigit.toLowerCase() is checkDigit.toLowerCase()

		getCleanRut: -> @rut + '' + @checkDigit

		getNiceRut: (type = true) ->
			if type
				_formatRut(@rut) + '-' + @checkDigit
			else
				@rut + '-' + @checkDigit

		_cleanRut = (rut) -> rut.replace /(\.|\-)/g, ''

		_getCheckDigit = (rut) ->
			sum = 0
			i = rut.length
			mul = 2

			while --i >= 0
				sum += rut.charAt(i) * mul
				mul = 2 if ++mul is 8

			res = sum % 11

			if res is 1 then 'K'
			else if res is 0 then '0'
			else String 11 - res

		_formatRut = (rut) ->
			rut.split('').reverse().reduce (a, b, i) ->
				a = if i % 3 is 0 then b + '.' + a else b + '' + a

	Rut

)