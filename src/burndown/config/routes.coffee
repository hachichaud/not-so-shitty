angular.module '%module%.burndown'
.config ($stateProvider) ->
  $stateProvider
  .state 'burndown',
    url: '/burndown'
    templateUrl: 'burndown/views/bdc.html'
    controller: 'BurnDownCtrl'
    resolve:
      bdcSettings: (BurndownSettings) ->
        BurndownSettings.getSettings()
  .state 'burndown.board',
    url: '/board'
    templateUrl: 'burndown/views/board.html'
    controller: 'BoardCtrl'
    resolve:
      bdcSettings: (BurndownSettings) ->
        BurndownSettings.getSettings()
  .state 'mastercard',
    url: '/mastercard/:cardId/:token'
    controller: 'BoardCtrl'
