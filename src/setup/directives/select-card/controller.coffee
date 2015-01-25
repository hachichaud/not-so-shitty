angular.module '%module%.setup'
.controller 'SelectCardCtrl',
($scope, Setup) ->
  $scope.$watch 'columnId', (newVal) ->
    return unless newVal
    Setup.getCardsFromColumn newVal
    .then (col) ->
      $scope.chosenColumn = col
