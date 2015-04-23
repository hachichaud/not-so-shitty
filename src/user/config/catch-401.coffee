angular.module '%module%.user'
.config ($httpProvider) ->
  $httpProvider.interceptors.push 'UnauthorizedInterceptor'
