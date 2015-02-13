angular.module '%module%.pilot'
.controller 'PilotCtrl',
($scope, Pilot, storage, boards) ->
  $scope.boards = boards
  storage.pilotSetup ?= {}
  $scope.pilotSetup = storage.pilotSetup
  $scope.pilotSetup.boards ?= []

  $scope.addBoard = ->
    $scope.pilotSetup.boards.push
      id: boards[0].id

  if $scope.pilotSetup.boards.length is 0
    $scope.addBoard()

  $scope.$watch 'pilotSetup.boards', (newVal) ->
    Pilot.getRegressions newVal
    .then (res) ->
      Pilot.getRetours newVal
