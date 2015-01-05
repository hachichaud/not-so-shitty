angular.module '%module%.burndown'
.directive 'sprintPointsWidget', ->
  restrict: 'AE'
  templateUrl: 'burndown/directives/sprint-points-widget/view.html'
  controller: 'SprintPointsWidgetCtrl'
  scope:
    settings: '='

.controller 'SprintPointsWidgetCtrl',
($scope, $rootScope, Resources) ->
  broadcast = ->
    $rootScope.$broadcast 'sprintspeed:changed'

  $scope.changeSprintPoints = ->
    $scope.settings.speed = $scope.settings.sprintPoints / $scope.settings.totalJH
    broadcast()

  $scope.changeSpeed = ->
    $scope.settings.sprintPoints = $scope.settings.speed * $scope.settings.totalJH
    broadcast()
