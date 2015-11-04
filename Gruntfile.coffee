module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    uglify:
      project:
        build:
          src: 'src/js/<%= pkg.name %>.js'
          dest: 'build/<%= pkg.name %>.min.js'
        examples:
          src: 'devserver/public/js/exampleapp.js'
          dest: 'devserver/public/build/exampleapp.min.js'
    coffee:
      options:
        join: true
      project:
        files:
          'src/js/<%= pkg.name %>.js':
            [
              'src/coffee/*.coffee'
            ]
      public:
        files:
          'devserver/public/js/exampleapp.js':
            [
              'devserver/public/coffee/*.coffee'
            ]
      devserver:
        files:
          'devserver/build/js/devserver.js':
            [
              'devserver/build/coffee/*.coffee'
            ]
    express:
      options: {}
      dev:
        options:
          script: 'devserver/build/js/devserver.js'
    watch:
      project:
        files: 'src/coffee/*.coffee'
        tasks:
          [
            'coffee:project',
            'uglify:project'
          ]
      examples:
        files: 'devserver/public/coffee/*.coffee'
        tasks:
          [
            'coffee:public'
          ]
      devserver:
        files: 'devserver/build/coffee/*.coffee'
        tasks:
          [
            'coffee:devserver',
            'express:dev'
          ]
        options:
          spawn: false


  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-express-server'

  grunt.registerTask 'default', ['coffee:project', 'uglify:project']
  grunt.registerTask 'dev-project', ['coffee:project', 'uglify:project', 'watch:project']
  grunt.registerTask 'dev-public', ['coffee:public', 'watch:public']
  grunt.registerTask 'dev-server', ['coffee:devserver', 'watch:devserver']
  grunt.registerTask 'dev-full', ['coffee', 'uglify', 'express:dev', 'watch']

  return