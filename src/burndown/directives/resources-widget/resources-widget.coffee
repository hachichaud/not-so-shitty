angular.module '%module%.burndown'
.directive 'resourcesWidget', ->
  restrict: 'AE'
  templateUrl: 'burndown/directives/resources-widget/view.html'
  controller: 'ResourcesWidgetCtrl'
  scope:
    settings: '='

.controller 'ResourcesWidgetCtrl',
($scope, $rootScope) ->
  $scope.changeRes = (iday, imember) ->
    delta = $scope.settings.resources[iday][imember]
    $scope.settings.resources[iday][imember] += 0.5
    if $scope.settings.resources[iday][imember] > 1
      $scope.settings.resources[iday][imember] = 0
    delta = $scope.settings.resources[iday][imember] - delta

    $rootScope.$broadcast 'resources:changed'
