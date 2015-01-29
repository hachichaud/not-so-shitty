angular.module '%module%.scrumboard'
.directive 'printTable', ($filter) ->
  restrict: 'AE'
  scope:
    data: '='
  templateUrl: 'scrumboard/directives/print-table/view.html'
  link: (scope, elem, attr) ->
    
