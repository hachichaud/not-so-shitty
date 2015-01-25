angular.module '%module%.scrumboard'
.controller 'ScrumBoardCtrl',
($scope, doneCards, storage) ->
  $scope.doneCards = doneCards
  $scope.setup = storage.setup
