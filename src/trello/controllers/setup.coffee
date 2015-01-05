angular.module '%module%.trello'
.controller 'SetupCtrl',
($scope, $rootScope, UserTrello) ->
  # Toggle Panel
  $scope.showTrelloSetup = true

  $scope.saveSettings = ->
    UserTrello.saveSettings $rootScope.user
