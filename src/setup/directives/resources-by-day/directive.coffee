angular.module '%module%.setup'
.directive 'resourcesByDay', ->
  restrict: 'E'
  templateUrl: 'setup/directives/resources-by-day/view.html'
  scope:
    members: '='
    matrix: '='
    days: '='
  controller: 'ResourcesByDayCtrl'
