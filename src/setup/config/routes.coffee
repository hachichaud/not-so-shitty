angular.module '%module%.setup'
.config ($stateProvider) ->
  $stateProvider
  .state 'setup',
    url: '/setup'
    templateUrl: 'setup/views/setup.html'
    controller: 'SetupCtrl'
    resolve:
      boards: (Setup) -> Setup.getBoards()
