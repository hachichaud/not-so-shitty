angular.module '%module%.pilot'
.controller 'TrelloBoardCtrl',
(Board, $scope) ->
  $scope.$watch 'boardId', (boardId) ->
    return unless boardId
    Board.getBoard $scope.boardId
    .then (board) ->
      $scope.board = board
