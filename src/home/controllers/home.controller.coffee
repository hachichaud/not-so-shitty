angular.module '%module%.home'
.controller 'HomeCtrl',
($rootScope, $scope, UserTrello) ->
  $scope.requestTokenUrl = UserTrello.readWriteTokenUrl

  $scope.submitTrelloToken = ->
    return unless $rootScope.user.trelloToken
    UserTrello.setUserToken $rootScope.user.trelloToken

  $scope.getBoardFromTrello = ->
    UserTrello.getBoardFromTrello()
