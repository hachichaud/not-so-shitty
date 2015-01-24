angular.module '%module%.user'
.run ($rootScope, User) ->
  $rootScope.$on '$stateChangeStart', (event, toState) ->
    return unless toState.name is 'login'
    User.retrieveToken event
