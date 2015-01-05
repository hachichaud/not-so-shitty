parameters = require '../utils/build/parameters.coffee'

coffeeFiles = "#{parameters.paths.src.main}/**/*.coffee"

module.exports = (config) ->
  karmaConfig =
    basePath: '../'

    files: [
      "#{parameters.paths.www.scripts}/#{parameters.files.vendors.scripts}"
      # TODO Consider adding html2js to tests directives/templates
      'bower_components/angular-mocks/angular-mocks.js'
      "#{parameters.paths.src.main}/*.coffee"
      "#{parameters.paths.src.main}/**/module.coffee"
      coffeeFiles
      'test/specs/**/*.coffee'
    ]

    frameworks: [
      'mocha'
      'sinon-chai'
    ]

    preprocessors:
      'test/specs/**/*.coffee': 'coffee'

    reporters: [
      'dots'
      'coverage'
    ]

    coverageReporter:
      type: 'lcov'
      dir: 'coverage/'

    browsers: [
      'Firefox'
    ]

    logLevel:       config.LOG_WARN
    autoWatch:      true

  karmaConfig.preprocessors[coffeeFiles] = 'coffee'
# karmaConfig.preprocessors[coffeeFiles] = 'coverage'

  config.set karmaConfig
