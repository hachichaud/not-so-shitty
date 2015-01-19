angular.module '%module%.burndown'
.controller 'BurnDownCtrl',
($scope, $rootScope, bdcSettings, BdcData) ->
  $rootScope.dayPlusOne = false
  updateGraph = ->
    BdcData.updateData bdcSettings, $rootScope.dayPlusOne
    .then (data) ->
      $rootScope.graphData = data
      $scope.dump = data

  $scope.toggleDayPlusOne = ->
    $rootScope.dayPlusOne = !$rootScope.dayPlusOne
    updateGraph()

  updateGraph()
