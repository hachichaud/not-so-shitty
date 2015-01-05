gulp = require 'gulp'
angularTemplatecache = require 'gulp-angular-templatecache'
jade = require 'gulp-jade'
plumber = require 'gulp-plumber'
replace = require 'gulp-replace'

parameters = require '../parameters.coffee'

gulp.task 'templates', ->
  gulp.src "#{parameters.paths.src.main}/*/**/*.jade"
  .pipe plumber()
  .pipe parameters.angular.module.replacer replace
  .pipe parameters.folders.scripts.replacer replace
  .pipe jade
    doctype: 'html'
  .pipe angularTemplatecache
    filename: parameters.files.templates
    module: parameters.angular.module.name
    standalone: false
  .pipe gulp.dest parameters.paths.www.scripts
