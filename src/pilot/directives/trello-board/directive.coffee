angular.module '%module%.pilot'
.directive 'trelloBoard', ->
  restrict: 'E'
  templateUrl: 'pilot/directives/trello-board/view.html'
  scope:
    boardId: '@'
  controller: 'TrelloBoardCtrl'
