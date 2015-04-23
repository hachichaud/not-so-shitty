angular.module '%module%.scrumboard'
.directive 'bdcSummary', ->
  restrict: 'AE'
  scope:
    resources: '='
    label: '='
  templateUrl: 'scrumboard/directives/bdc-summary/view.html'
