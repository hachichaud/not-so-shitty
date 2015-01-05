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
