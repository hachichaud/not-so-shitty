angular.module '%module%.scrumboard'
.directive 'printTable', ->
  restrict: 'AE'
  scope:
    data: '='
  templateUrl: 'scrumboard/directives/print-table/view.html'
