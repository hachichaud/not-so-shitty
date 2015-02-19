angular.module '%module%.pilot'
.config ($stateProvider) ->
  $stateProvider
  .state 'pilot',
    url: '/pilot'
    templateUrl: 'pilot/views/pilot.html'
    controller: 'PilotCtrl'
    resolve:
      boards: (Pilot) -> Pilot.getBoards()
  .state 'rodolphe',
    url: '/rodolphe'
    templateUrl: 'pilot/views/rodolphe.html'
    controller: ($scope, csv) ->
      $scope.csv = csv
    resolve:
      csv: (Pilot) -> Pilot.rodolphe()
