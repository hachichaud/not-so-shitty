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
  '%module%.scrumboard'
  '%module%.setup'
  '%module%.user'
]
.config ($mdThemingProvider) ->
  $mdThemingProvider.theme('blue')
    .primaryPalette 'blue',
      'default': '400'
      'hue-1': '100'
      'hue-2': '600'
      'hue-3': '900'
    .accentPalette 'purple',
      'default': '500'
      'hue-1': '100'
      'hue-2': '600'
      'hue-3': '800'
