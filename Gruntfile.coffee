module.exports = (grunt) ->
    require("load-grunt-tasks")(grunt)

    grunt.registerTask "default", ["concurrent"]

    grunt.initConfig
        concurrent:
            options:
                logConcurrentOutput: true
            dev:
                tasks: ["watch", "connect:serve"]

        connect:
            serve:
                options:
                    port: 3000
                    hostname: "0.0.0.0"
                    debug: true
                    livereload: true
                    base: "dist/static"
                    keepalive: true

        bower_concat:
            concat:
                cssDest: "dist/static/css/vendor/deps.css"
                dest: "dist/static/js/vendor/deps.js"

                dependencies:
                    "bootstrap": ["jquery"]

        coffee:
            compile:
                files:
                    "dist/app/app.js": ["src/app/app.coffee"]

        jade:
            compile:
                files:
                    "dist/static/index.html": ["src/jade/index.jade"]

        stylus:
            compile:
                files:
                    "dist/static/css/main.css": ["src/stylus/main.styl"]

        watch:
            options:
                livereload: true

            jade:
                files: ["src/jade/**/*.jade"]
                tasks: ["jade:compile"]

            coffee:
                files: ["src/coffee/**/*.coffee", "src/app/**/*.coffee"]
                tasks: ["coffee:compile"]

            stylus:
                files: ["src/stylus/**/*.styl"]
                tasks: ["stylus:compile"]

            bower_concat:
                files: ["bower_components/**"]
                tasks: ["bower_concat:concat"]
