module.exports = (grunt) ->
	'use strict'

	pkg = require './package.json'

	for name of pkg.devDependencies when name.substring(0, 6) is 'grunt-'
		grunt.loadNpmTasks name

	grunt.initConfig
		pkg: pkg
		clean: ['dist']
		concat:
			options:
				stripBanners: true
				banner: '''
						/*!
						 * <%= pkg.title || pkg.name %> v<%= pkg.version %>
						 * <%= pkg.homepage %>
						 *
						 * Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author.name %> <<%= pkg.author.email %>>
						 * Released under the MIT license
						 */

						'''
			dist:
				src: ['dist/<%= pkg.filename %>.js']
				dest: 'dist/<%= pkg.filename %>.js'
		uglify:
			options:
				banner: '''
						/*! <%= pkg.title || pkg.name %> v<%= pkg.version %> - <%= pkg.homepage %> */
						
						'''
			dist:
				src: ['<%= concat.dist.dest %>']
				dest: 'dist/<%= pkg.filename %>.min.js'
		coffee:
			compile:
				options:
					bare: true
				files:
					'dist/<%= pkg.filename %>.js': 'src/*.coffee'

	grunt.registerTask 'default', ['clean', 'coffee', 'concat', 'uglify']