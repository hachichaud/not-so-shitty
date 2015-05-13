angular.module '%module%.setup'
.controller 'SetupCtrl',
($scope, Setup, boards, storage) ->
  storage.setup ?= {}
  $scope.setup = storage.setup
  $scope.boards = boards
  $scope.setup.resources ?= {}
  $scope.setup.dailyHour ?= 10
  # Get board colums when board is set
  $scope.$watch 'setup.boardId', (next, prev) ->
    return unless next
    Setup.getBoardColumns next
    .then (col) ->
      $scope.boardColumns = col
    Setup.getBoardMembers next
    .then (boardMembers) ->
      $scope.boardMembers = boardMembers

  $scope.showWidget = (widgetName) ->
    $scope.currentWidget = widgetName
