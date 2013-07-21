# *Rut.js* Validador de Rut

Rut.js es una pequeña herramienta que te ayuda al validado y formateo de rut's en tus aplicaciones JavaScript. La herramienta esta escrita en CoffeeScript y puede ser utilizado tanto en nodejs como en el browser.

## Descarga

Puedes obtener Rut.js en Bower o en NPM.

```shell
# Desde bower
$ bower install rutjs
# O desde npm
$ npm install rutjs
```

## Ejemplos de uso

```js
var rut = new Rut('12345678-k');
```

Se retorna un objeto con propiedades y metodos.

### Propiedades

#### .isValid `boolean`

```js
if ( rut.isValid ) {
	// true
} else {
	// false
}
```

#### .rut `string`

```js
console.log( rut.rut );
// "12345678"
```

#### .checkDigit `string`

```js
console.log( rut.checkDigit );
// "K"
```

### Metodos

#### .validate() :`boolean`

```js
console.log( rut.validate() );
// true or false
```

#### .getCleanRut() :`string`

```js
console.log( rut.getCleanRut() );
// "12345678K"
```

#### .getNiceRut([`boolean`]) :`string`

```js
console.log( rut.getNiceRut() );
// "12.345.678-K"

console.log( rut.getNiceRut(false) );
// "12345678-K"
```

#### .setRut(`string` [,`boolean`]) :`void`

Actualiza el rut en la variable, el segundo parametro es opcional.

```js
// Con dígito verificador
rut.setRut('12.345.678-K');

// Sin dígito verificador
rut.setRut('12345678', true);
```

### Opciones

```js
// Con dígito verificador
var rut = new Rut('12345678-k');

// Sin dígito verificador
var rut = new Rut('12345678', true);
```

## ¿Quieres ayudar?

Hace [fork](http://help.github.com/fork-a-repo/) del proyecto, clonalo y asegurate de instalar las dependencias:

```shell
$ npm install
```

Crea un branch con el nombre de tu característica-mejora-fix y hace tu [pull request](https://help.github.com/articles/using-pull-requests).

### Compilar

Se requiere de Grunt `~0.4.0`

Solo tiene la opción default así que solo tienen que ejecutar:

```shell
$ grunt
```