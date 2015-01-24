angular.module '%module%.scrumboard'
.config ($stateProvider) ->
  $stateProvider
  .state 'scrumboard',
    url: '/scrumboard'
    templateUrl: 'scrumboard/views/scrumboard.html'
    controller: 'ScrumBoardCtrl'
