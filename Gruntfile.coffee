module.exports = (grunt) ->
    require("load-grunt-tasks")(grunt)

    grunt.registerTask "default", ["concurrent"]

    grunt.initConfig
        #nodemon:
        #   #exec:
        #   #   options:
        #   #       exec: "less"

        #   dev:
        #       script: "dist/index.js"

        #   options:
        #       env:
        #           PORT: process.env.PORT or 3000
        #           HOST: process.env.HOST or "127.0.0.1"
        #           NODE_ENV: process.env.NODE_ENV or "development"
        #       #callback: -> console.log "woo"
        #       #nodeArgs: [""]
        #       #args: [""]
        #       #cwd: __dirname
        #       ignore: ["node_modules/**"]
        #       ext: "js, coffee"
        #       watch: ["server, index"]
        #       delay: 1000
        #       legacyWatch: false


        concurrent:
            options:
                logConcurrentOutput: true
            dev:
                tasks: ["watch", "connect"]

        connect:
            serve:
                options:
                    port: process.env.PORT or 3000
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

        copy:
            config:
                expand: false
                src: ["src/server/config.js"]
                dest: "dist/config.js"

        coffee:
            compile:
                files:
                    "dist/server.js" : ["src/server/server.coffee"]
                    "dist/index.js"  : ["src/server/index.coffee"]
                    "dist/static/js/main.js": ["src/coffee/main.coffee"]

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

            copy:
                files: ["src/server/config.js"]
                tasks: ["copy:config"]

            jade:
                files: ["src/jade/**/*.jade"]
                tasks: ["jade:compile"]

            coffee:
                files: ["src/**/*.coffee"]
                tasks: ["coffee:compile"]

            stylus:
                files: ["src/stylus/**/*.styl"]
                tasks: ["stylus:compile"]

            bower_concat:
                files: ["bower_components/**"]
                tasks: ["bower_concat:concat"]

            grunt:
                files: ["Gruntfile.coffee"]
