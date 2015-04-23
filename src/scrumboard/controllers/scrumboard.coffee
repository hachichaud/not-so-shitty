angular.module '%module%.scrumboard'
.controller 'ScrumBoardCtrl',
($scope, doneCards, storage, BurndownData, $mdBottomSheet) ->
  $scope.showAllActions = false
  $scope.doneCards = doneCards
  $scope.setup = storage.setup

  showDayPlusOne = false

  $scope.bdcData = BurndownData.generateData doneCards, storage.setup.dates.days, storage.setup.resources, showDayPlusOne, storage.setup.dailyHour

  $scope.toggleDayPlusOne = ->
    showDayPlusOne = !showDayPlusOne
    $scope.bdcData = BurndownData.generateData doneCards, storage.setup.dates.days, storage.setup.resources, showDayPlusOne, storage.setup.dailyHour

  $scope.showTable = false

  $scope.openActions = ->
    $scope.showAllActions = !$scope.showAllActions
