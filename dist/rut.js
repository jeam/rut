/*!
 * Rut.js v0.1.1
 * http://jeam.github.io/rut
 *
 * Copyright (c) 2013 Jorge Álvarez <jorge@jalvarez.cl>
 * Released under the MIT license
 */
(function(root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(function() {
      return root.Rut = factory();
    });
  } else if (typeof exports === 'object') {
    module.exports = factory();
  } else {
    root.Rut = factory();
  }
})(this, function() {
  var Rut;
  Rut = (function() {
    var _cleanRut, _formatRut, _getCheckDigit;

    function Rut(rut, withoutCheckDigit) {
      this.setRut(rut, withoutCheckDigit);
    }

    Rut.prototype.setRut = function(rut, withoutCheckDigit) {
      if (withoutCheckDigit == null) {
        withoutCheckDigit = false;
      }
      if (typeof rut !== 'string') {
        throw new Error('rut tiene que ser string');
      }
      this.rut = withoutCheckDigit ? _cleanRut(rut) : _cleanRut(rut.substr(0, rut.length - 1));
      this.checkDigit = withoutCheckDigit ? _getCheckDigit(rut) : rut.substr(rut.length - 1).toUpperCase();
      this.isValid = this.validate();
    };

    Rut.prototype.validate = function() {
      var checkDigit;
      if (!/([0-9]|k)/i.test(this.checkDigit)) {
        return false;
      }
      checkDigit = _getCheckDigit(this.rut);
      return this.checkDigit.toLowerCase() === checkDigit.toLowerCase();
    };

    Rut.prototype.getCleanRut = function() {
      return this.rut + '' + this.checkDigit;
    };

    Rut.prototype.getNiceRut = function(type) {
      if (type == null) {
        type = true;
      }
      if (type) {
        return _formatRut(this.rut) + '-' + this.checkDigit;
      } else {
        return this.rut + '-' + this.checkDigit;
      }
    };

    _cleanRut = function(rut) {
      return rut.replace(/(\.|\-)/g, '');
    };

    _getCheckDigit = function(rut) {
      var i, mul, res, sum;
      sum = 0;
      i = rut.length;
      mul = 2;
      while (--i >= 0) {
        sum += rut.charAt(i) * mul;
        if (++mul === 8) {
          mul = 2;
        }
      }
      res = sum % 11;
      if (res === 1) {
        return 'K';
      } else if (res === 0) {
        return '0';
      } else {
        return String(11 - res);
      }
    };

    _formatRut = function(rut) {
      return rut.split('').reverse().reduce(function(a, b, i) {
        return a = i % 3 === 0 ? b + '.' + a : b + '' + a;
      });
    };

    return Rut;

  })();
  return Rut;
});
