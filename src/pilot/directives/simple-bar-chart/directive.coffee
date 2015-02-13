angular.module '%module%.pilot'
.directive 'simpleBarChart', ->
  restrict: 'E'
  scope:
    data: '='
  templateUrl: 'pilot/directives/simple-bar-chart/view.html'
  controller: ($scope) ->
    $scope.maxValue = _.max $scope.data, (val) -> val
    console.log $scope.maxValue
