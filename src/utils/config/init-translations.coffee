angular.module '%module%.utils'
.config ($translateProvider) ->
  $translateProvider.fallbackLanguage 'en'
  $translateProvider.determinePreferredLanguage()
