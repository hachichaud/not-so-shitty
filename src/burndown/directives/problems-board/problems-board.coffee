angular.module '%module%.burndown'
.directive 'problems-board', ->
  restrict: 'AE'
  templateUrl: 'burndown/directives/problems-board/view.html'
  controller: 'ReactionsCtrl'
  scope:
    settings: '='

.controller 'ReactionsCtrl',
($scope, $rootScope, Reactions) ->
  $rootScope.$on 'problem', (event, data) ->
    console.log data
