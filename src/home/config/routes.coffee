angular.module '%module%.home'
.config ($stateProvider) ->
  $stateProvider
  .state 'home',
    url: '/'
    templateUrl: 'home/views/view.html'
    controller: 'HomeCtrl'
