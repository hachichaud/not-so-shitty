angular.module '%module%.burndown'
.directive 'sprintSummary', ->
  restrict: 'AE'
  templateUrl: 'burndown/directives/sprint-summary/view.html'
  controller: 'SprintSummaryCtrl'
  scope:
    graphData: '='

.controller 'SprintSummaryCtrl',
($scope, DelaySprint) ->
  update = (graphData) ->
    $scope.delay = DelaySprint.calculateDelay graphData

  $scope.$watch 'graphData', (graphData) ->
    return unless graphData
    update graphData
