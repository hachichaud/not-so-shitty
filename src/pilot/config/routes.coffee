angular.module '%module%.pilot'
.config ($stateProvider) ->
  $stateProvider
  .state 'pilot',
    url: '/pilot'
    templateUrl: 'pilot/views/pilot.html'
    controller: 'PilotCtrl'
    resolve:
      boards: (Pilot) -> Pilot.getBoards()
