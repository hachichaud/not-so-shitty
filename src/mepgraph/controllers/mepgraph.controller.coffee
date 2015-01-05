angular.module '%module%.mepgraph'
.controller 'MepGraphCtrl',
($scope, MepData) ->
  $scope.standard = 0.20
  $scope.units =
    week: 'Semaine'
    JH: 'JH'
    MEP: 'JH MEP'
    ratio: '%JH'

  MepData.getData()
  .then (data) ->
    $scope.data = data
