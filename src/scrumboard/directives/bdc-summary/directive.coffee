angular.module '%module%.scrumboard'
.directive 'bdcSummary', ->
  restrict: 'AE'
  scope:
    resources: '='
  templateUrl: 'scrumboard/directives/bdc-summary/view.html'
