angular.module '%module%.burndown'
.controller 'BoardCtrl',
($scope, $rootScope, BdcData, bdcSettings, BurndownSettings) ->
  update = ->
    BdcData.updateData $rootScope.user, $rootScope.dayPlusOne
    .then (data) ->
      $rootScope.graphData = data

  $rootScope.$on 'resources:changed', ->
    BurndownSettings.saveTeam()
    update()

  $rootScope.$on 'team:dev:add', ->
    BurndownSettings.addDev()
    update()

  $rootScope.$on 'team:dev:remove', (event, index) ->
    BurndownSettings.removeDev index
    update()

  $rootScope.$on 'sprintspeed:changed', ->
    BdcData.updateButSprintSpeed $rootScope.user, $rootScope.dayPlusOne
    .then (data) ->
      $rootScope.graphData = data
