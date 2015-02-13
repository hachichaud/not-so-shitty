angular.module '%module%.setup'
.directive 'selectCard', ->
  restrict: 'E'
  templateUrl: 'setup/directives/select-card/view.html'
  scope:
    columns: '='
    cardId: '='
  controller: 'SelectCardCtrl'
