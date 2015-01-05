angular.module '%module%.trello'
.controller 'SetupTrelloCtrl',
($rootScope, $scope, $state, UserTrello) ->
  # Trello stuff
  $scope.requestTokenUrl = UserTrello.readWriteTokenUrl

  $scope.submitTrelloToken = ->
    return unless $rootScope.user.trelloToken
    UserTrello.setUserToken $rootScope.user.trelloToken
    $state.go 'setup.trello.me'
