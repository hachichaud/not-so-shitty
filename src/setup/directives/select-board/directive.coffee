angular.module '%module%.setup'
.directive 'selectBoard', ->
  restrict: 'E'
  templateUrl: 'setup/directives/select-board/view.html'
  scope:
    boards: '='
    boardId: '='
  controller: 'SelectBoardCtrl'
