angular.module '%module%.trello'
.controller 'MyTrelloCtrl',
($rootScope, $scope, UserTrello) ->
  UserTrello.getUserBoards()
  .then (res) ->
    $scope.myBoards = res

  $scope.myLists = $rootScope.user.lists or {}
  $scope.myDates = {}

  $scope.submitBoardId = ->
    UserTrello.setUserBoardId $rootScope.user.boardId

  $scope.submitLists = ->
    UserTrello.setUserLists $scope.myLists

  $scope.submitDays = ->
    UserTrello.setSprintDays $scope.myDates.days
