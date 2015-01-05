dgeni = require 'dgeni'
path = require 'path'

module.exports = new dgeni.Package 'dgeni-docs', [
  require 'dgeni-packages/ngdoc'
]
.config (log, readFilesProcessor, templateFinder, writeFilesProcessor) ->
  log.level = 'debug'
  readFilesProcessor.basePath = path.join __dirname, '..'
  readFilesProcessor.sourceFiles = [
    include: 'www/js/notsoshitty-app.js'
  ,
    include: 'docs/content/**/*.ngdoc'
  ]

  # Add support for personnalized templates
  templateFinder.templateFolders.unshift path.join __dirname, 'templates'

  writeFilesProcessor.outputFolder = 'docs/build'
