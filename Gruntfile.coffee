module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    uglify:
      project:
        build:
          src: 'src/js/<%= pkg.name %>.js'
          dest: 'build/<%= pkg.name %>.min.js'
        examples:
          src: 'examples/js/exampleapp.js'
          dest: 'examples/build/exampleapp.min.js'
    coffee:
      options:
        join: true
      project:
        files:
          'src/js/<%= pkg.name %>.js':
            [
              'src/coffee/*.coffee'
            ]
      examples:
        files:
          'examples/js/exampleapp.js':
            [
              'examples/coffee/*.coffee'
            ]
    watch:
      project:
        files: 'src/coffee/*.coffee'
        tasks:
          [
            'coffee:project',
            'uglify:project'
          ]
      examples:
        files: 'examples/coffee/*.coffee'
        tasks:
          [
            'coffee:examples'
          ]


  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-uglify'

  grunt.registerTask 'default', ['coffee:project', 'uglify:project']
  grunt.registerTask 'dev-project', ['coffee:project', 'uglify:project', 'watch:project']
  grunt.registerTask 'dev-examples', ['coffee:examples', 'watch:examples']
  grunt.registerTask 'dev-full', ['coffee', 'uglify', 'watch']

  return