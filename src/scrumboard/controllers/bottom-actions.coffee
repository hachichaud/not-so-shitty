angular.module '%module%.scrumboard'
.controller 'BottomActionsCtrl',
($scope, bdcData, storage) ->
  $scope.bdcData = bdcData
  $scope.setup = storage.setup
