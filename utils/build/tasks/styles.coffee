gulp = require 'gulp'
path = require 'path'
concat = require 'gulp-concat'
plumber = require 'gulp-plumber'
replace = require 'gulp-replace'
sourcemaps = require 'gulp-sourcemaps'
less = require 'gulp-less'

parameters = require '../parameters.coffee'

gulp.task 'styles', ->
  gulp.src "#{parameters.paths.src.main}/**/*.less"
  .pipe plumber()
  .pipe parameters.angular.module.replacer replace
  .pipe parameters.folders.scripts.replacer replace
  .pipe sourcemaps.init()
  .pipe less paths: [ path.join(__dirname) ]
  .pipe concat parameters.files.styles
  .pipe sourcemaps.write()
  .pipe gulp.dest parameters.paths.www.styles
