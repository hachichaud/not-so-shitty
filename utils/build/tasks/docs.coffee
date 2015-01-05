gulp = require 'gulp'
dgeni = require 'dgeni'
path = require 'path'
rimraf = require 'gulp-rimraf'
webserver = require 'gulp-webserver'

gulp.task 'docs', ['app', 'clean-docs'], (done) ->
  new dgeni [
    require path.join __dirname, '../../..', 'docs/config.coffee'
  ]
  .generate()

gulp.task 'clean-docs', ->
  gulp.src 'docs/build'
  .pipe rimraf()

gulp.task 'docs-server', ->
  gulp.src 'docs/build/api'
  .pipe webserver
    fallback: 'index.html'
    port: 8001
