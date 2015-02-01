angular.module '%module%.user'
.config ($stateProvider) ->
  $stateProvider
  .state 'login',
    url: '/login/:cardId'
    templateUrl: 'user/views/login.html'
    controller: 'LoginCtrl'
