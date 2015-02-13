angular.module '%module%.user'
.run ($rootScope, $state) ->
  $rootScope.$on '$stateChangeError', (event, toState, toParams, fromState, fromParams, error) ->
    event.preventDefault()
    $state.go 'login'
