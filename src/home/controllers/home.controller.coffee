angular.module '%module%.home'
.controller 'HomeCtrl',
($rootScope, $scope, UserTrello) ->
  $scope.requestTokenUrl = UserTrello.readWriteTokenUrl

  $scope.submitTrelloToken = ->
    return unless $rootScope.user.trelloToken
    UserTrello.setUserToken $rootScope.user.trelloToken

  $scope.submitCardId = ->
    return unless $rootScope.user.trelloCardId
    UserTrello.setTrelloCardId $rootScope.user.trelloCardId

  $scope.getBoardFromTrello = ->
    UserTrello.getBoardFromTrello()
