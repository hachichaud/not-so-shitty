angular.module '%module%.pilot'
.controller 'PilotCtrl',
($scope, Pilot, storage, boards) ->
  $scope.boards = boards
  storage.pilotSetup ?= {}
  $scope.pilotSetup = storage.pilotSetup
  $scope.pilotSetup.boards ?= []

  $scope.haveFun = ->
    links = [
      'http://www.iamagiant.co.uk/images/drawings/major_steakholder.jpg'
      'http://i.imgur.com/moaauGB.jpg'
      'http://www.imgur.com/r/funny'
      'http://www.imgur.com/random'
      'http://ljdchost.com/2oukOLc.gif'
      'http://ljdchost.com/Y407gtf.gif'
      'http://ljdchost.com/KCeRKdI.gif'
      'http://ljdchost.com/ibb9r509E89ayu.gif'
    ]
    i = _.random 0, links.length - 1
    location.href = links[i]

  $scope.addBoard = ->
    $scope.pilotSetup.boards.push
      id: boards[0].id

  if $scope.pilotSetup.boards.length is 0
    $scope.addBoard()

  $scope.$watch 'pilotSetup.boards', (newVal) ->
    Pilot.getRegressions newVal
    .then (res) ->
      Pilot.getRetours newVal
  , true
