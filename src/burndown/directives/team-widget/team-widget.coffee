angular.module '%module%.burndown'
.directive 'teamWidget', ->
  restrict: 'AE'
  templateUrl: 'burndown/directives/team-widget/view.html'
  controller: 'TeamWidgetCtrl'
  scope:
    settings: '='

.controller 'TeamWidgetCtrl',
($scope, $rootScope, UserTrello, BdcData) ->
  $scope.showAddable = false
  $scope.showPlaceHolder = false
  broadcastChange = (type, destType, index) ->
    if type is 'dev' or destType is 'dev'
      if index > -1
        $rootScope.$broadcast 'team:dev:remove', index
      else
        $rootScope.$broadcast 'team:dev:add'
    else
      $rootScope.$broadcast 'team:changed'

  update = ->
    $scope.team = $scope.settings.team
    BdcData.getAddableMembers()
    .then (extTeam) ->
      $scope.team.ext = extTeam
      if extTeam.length <= 0
        $scope.showPlaceHolder = true
      else $scope.showPlaceHolder = false

  update()

  changeMember = (member, dest) ->
    index = $scope.team[member.type].indexOf(member.id)
    if index > -1
      $scope.team[member.type].splice index, 1
      $scope.team[dest].push member.id
      if member.type is 'dev'
        removeIndex = index
      else
        removeIndex = - 1
      update()
      broadcastChange member.type, dest, removeIndex

  $scope.dropMember = (event, member, type) ->
    return unless $scope.team
    changeMember member, type

  $scope.dropValidate = (member, type) ->
    return member.type != type
