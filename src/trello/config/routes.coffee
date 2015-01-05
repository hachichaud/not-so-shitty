angular.module '%module%.trello'
.config ($stateProvider) ->
  $stateProvider
  .state 'setup',
    abstract: true
    url: '/setup'
    templateUrl: 'trello/views/setup.html'
    controller: 'SetupCtrl'
  .state 'setup.trello',
    url: '/trello'
    templateUrl: 'trello/views/setup-trello.html'
    controller: 'SetupTrelloCtrl'
  .state 'setup.trello.me',
    url: '/me'
    templateUrl: 'trello/views/my-trello.html'
    controller: 'MyTrelloCtrl'
