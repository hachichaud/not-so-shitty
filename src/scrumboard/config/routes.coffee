angular.module '%module%.scrumboard'
.config ($stateProvider) ->
  $stateProvider
  .state 'scrumboard',
    url: '/'
    templateUrl: 'scrumboard/views/scrumboard.html'
    controller: 'ScrumBoardCtrl'
