angular.module '%module%.burndown'
.controller 'BurnDownCtrl',
($scope, $rootScope, bdcSettings, BdcData, UserTrello) ->
  $rootScope.dayPlusOne = false
  updateGraph = ->
    BdcData.updateData bdcSettings, $rootScope.dayPlusOne
    .then (data) ->
      $rootScope.graphData = data
      $scope.dump = data

  $scope.toggleDayPlusOne = ->
    $rootScope.dayPlusOne = !$rootScope.dayPlusOne
    updateGraph()

  $scope.saveToTrello = ->
    UserTrello.saveToTrello $rootScope.user, $rootScope.user.trelloCardId
    .then ->
      $scope.trelloShareLink = UserTrello.getTrelloShareLink $rootScope.user.trelloCardId

  updateGraph()
