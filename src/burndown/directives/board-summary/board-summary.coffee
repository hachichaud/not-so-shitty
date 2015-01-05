angular.module '%module%.burndown'
.directive 'boardSummary', ->
  restrict: 'AE'
  templateUrl: 'burndown/directives/board-summary/view.html'
  controller: 'BoardSummaryCtrl'
  scope:
    settings: '='

.controller 'BoardSummaryCtrl',
($scope, $rootScope, $q, BdcData) ->
  $scope.sprintColor = 'blue'
  $scope.sprintTitle = 'spri t teilte'
  $scope.lists = [
    'sprintBacklog'
    'doing'
    'validate'
    'done'
  ]

  getPointsFromListName = (listName) ->
    BdcData.getPointsFromListType listName

  getListsClass = (points, listTypes) ->
    return unless points
    listClass = {}
    limit = $rootScope.user.speed * $rootScope.user.team.dev.length
    for list in listTypes
      if $scope.points[list] < limit
        listClass[list] = 'good'
      else if $scope.points[list] < limit * 2
        listClass[list] = 'warning'
      else
        listClass[list] = 'danger'
    listClass

  getSprintColor = (className) ->
    # console.log className
    if className is 'good'
      'lime'
    else
      'orange'

  update = ->
    $q.all [
      getPointsFromListName 'sprintBacklog'
      getPointsFromListName 'doing'
      getPointsFromListName 'validate'
      getPointsFromListName 'done'
    ]
    .then (res) ->
      $scope.points = _.zipObject $scope.lists, res
      $scope.listsClass = getListsClass $scope.points, $scope.lists
      $scope.sprintColor = getSprintColor()
      BdcData.getDoneListName()
      .then (name) ->
        $scope.sprintTitle = name

  update()
  $rootScope.$on 'sprintspeed:changed', ->
    update()
