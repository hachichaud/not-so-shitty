###*
  @ngdoc module
  @name %module%
  @module %module%
  @description

  This module requires all submodules of your app
###

angular.module '%module%', [
  'ngMaterial'
  'ang-drag-drop'
  'angular-datepicker'
  '%module%.utils'
  '%module%.home'
  '%module%.mepgraph'
  '%module%.trello'
  '%module%.burndown'
  '%module%.bdc'
]

# .config ($httpProvider) ->
  # $httpProvider.defaults.useXDomain = true
  # $httpProvider.defaults.withCredentials = true
  # delete $httpProvider.defaults.headers.common['X-Requested-With']
  # $httpProvider.defaults.headers.put['Access-Control-Allow-Headers'] = '*'
