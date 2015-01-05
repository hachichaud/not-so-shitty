gulp = require 'gulp'
concat = require 'gulp-concat'
filter = require 'gulp-filter'
mainBowerFiles = require 'main-bower-files'
plumber = require 'gulp-plumber'

parameters = require '../parameters.coffee'

gulp.task 'vendor', ->
  # Scripts
  gulp.src mainBowerFiles()
  .pipe filter '**/*.js'
  .pipe concat parameters.files.vendors.scripts
  .pipe gulp.dest parameters.paths.www.scripts

  # Styles
  gulp.src mainBowerFiles()
  .pipe filter '**/*.css'
  .pipe concat parameters.files.vendors.styles
  .pipe gulp.dest parameters.paths.www.styles

  # Fonts
  gulp.src mainBowerFiles()
  .pipe filter [
      '**/*.woff'
      '**/*.svg'
      '**/*.eot'
      '**/*.ttf'
      '**/*.otf'
    ]
  .pipe gulp.dest "#{parameters.paths.www.main}/fonts"
