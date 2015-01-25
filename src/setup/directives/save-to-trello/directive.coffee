angular.module '%module%.setup'
.directive 'saveToTrello', ->
  restrict: 'E'
  templateUrl: 'setup/directives/save-to-trello/view.html'
  scope:
    cardId: '='
    data: '='
  controller: 'SaveToTrelloCtrl'
