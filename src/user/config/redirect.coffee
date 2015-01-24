angular.module '%module%.user'
.config ($urlRouterProvider) ->
  $urlRouterProvider.otherwise '/login'
