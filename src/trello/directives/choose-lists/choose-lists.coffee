angular.module '%module%.trello'
.directive 'chooseLists', ->
  restrict: 'AE'
  scope:
    lists: '='
    boardId: '@'
    listTypes: '@'
  templateUrl: 'trello/directives/choose-lists/view.html'
  controller: 'ChooseListsCtrl'

.controller 'ChooseListsCtrl',
(UserTrello, $scope) ->
  listTypes = [
    'productBacklog'
    'sprintBacklog'
    'doing'
    'blocked'
    'validate'
    'done'
  ]
  if not $scope.listTypes
    $scope.listTypes = listTypes

  $scope.dropList = (data, type) ->
    # console.log data, type
    $scope.lists[type] = data.id

  $scope.$watch 'boardId', (boardId) ->
    return unless boardId
    UserTrello.getListsFromBoard boardId
    .then (res) ->
      $scope.boardLists = res
