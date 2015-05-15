angular.module '%module%.setup'
.controller 'TeamBuilderWidgetCtrl',
($scope, Setup) ->
  $scope.clearTeam = ->
    Setup.clearTeam()
