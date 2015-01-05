gulp = require 'gulp'
coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
plumber = require 'gulp-plumber'
replace = require 'gulp-replace'
sourcemaps = require 'gulp-sourcemaps'

parameters = require '../parameters.coffee'

gulp.task 'app', ->
  gulp.src [
    "#{parameters.paths.src.main}/main.coffee"
    "#{parameters.paths.src.main}/**/module.coffee"
    "#{parameters.paths.src.main}/**/*.coffee"
  ]
  .pipe plumber()
  .pipe parameters.angular.module.replacer replace
  .pipe sourcemaps.init()
  .pipe coffee
    bare: true
  .pipe concat parameters.files.app
  .pipe sourcemaps.write()
  .pipe gulp.dest parameters.paths.www.scripts
