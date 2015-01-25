angular.module '%module%.scrumboard'
.controller 'ScrumBoardCtrl', ($scope, doneCards) ->
  $scope.doneCards = doneCards
