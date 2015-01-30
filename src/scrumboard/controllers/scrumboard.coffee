angular.module '%module%.scrumboard'
.controller 'ScrumBoardCtrl',
($scope, doneCards, storage, BurndownData) ->
  $scope.doneCards = doneCards
  $scope.setup = storage.setup

  $scope.bdcData = BurndownData.generateData doneCards, storage.setup.dates.days, storage.setup.resources, false

  $scope.showTable = false
