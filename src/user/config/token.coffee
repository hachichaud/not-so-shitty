angular.module '%module%.user'
.run ($rootScope, User) ->
  $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams) ->
    return unless toState.name is 'login'
    User.retrieveCardId toParams
    User.retrieveToken event
