angular.module '%module%.scrumboard'
.controller 'ScrumBoardCtrl',
($scope, doneCards, storage, BurndownData, $mdBottomSheet) ->
  $scope.doneCards = doneCards
  $scope.setup = storage.setup

  showDayPlusOne = false

  $scope.bdcData = BurndownData.generateData doneCards, storage.setup.dates.days, storage.setup.resources, showDayPlusOne

  $scope.toggleDayPlusOne = ->
    showDayPlusOne = !showDayPlusOne
    $scope.bdcData = BurndownData.generateData doneCards, storage.setup.dates.days, storage.setup.resources, showDayPlusOne

  $scope.showTable = false

  $scope.openActions = ->
    $mdBottomSheet.show
      controller: 'BottomActionsCtrl'
      locals:
        bdcData: $scope.bdcData
      templateUrl: 'scrumboard/views/bottom-actions.html'
