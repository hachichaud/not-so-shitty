gulp = require 'gulp'
plumber = require 'gulp-plumber'

parameters = require '../parameters.coffee'

gulp.task 'assets', ->
  gulp.src "#{parameters.paths.src.assets}/**"
  .pipe plumber()
  .pipe gulp.dest parameters.paths.www.main
