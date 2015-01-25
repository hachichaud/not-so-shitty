angular.module '%module%.setup'
.directive 'selectColumns', ->
  restrict: 'E'
  templateUrl: 'setup/directives/select-columns/view.html'
  scope:
    boardColumns: '='
    columnIds: '='
