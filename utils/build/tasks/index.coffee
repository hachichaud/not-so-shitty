gulp = require 'gulp'
jade = require 'gulp-jade'
plumber = require 'gulp-plumber'
replace = require 'gulp-replace'

parameters = require '../parameters.coffee'

gulp.task 'index', ->
  gulp.src "#{parameters.paths.src.main}/*.jade"
  .pipe plumber()
  .pipe parameters.angular.module.replacer replace
  .pipe parameters.folders.scripts.replacer replace
  .pipe parameters.folders.styles.replacer replace
  .pipe jade
    doctype: 'html'
    pretty: true
  .pipe gulp.dest parameters.paths.www.main
