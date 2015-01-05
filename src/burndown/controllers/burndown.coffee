angular.module '%module%.burndown'
.controller 'BurnDownCtrl',
($scope, $rootScope, bdcSettings, BdcData) ->
  BdcData.updateData bdcSettings
  .then (data) ->
    $rootScope.graphData = data
    $scope.dump = data
