angular.module '%module%.setup'
.controller 'SelectPeopleCtrl',
($scope) ->
  $scope.teamCheck ?= {}
  $scope.check = ->
    team = []
    for key, checked of $scope.teamCheck
      if checked
        team.push key
    $scope.selectedMembers = team

  $scope.$watch 'selectedMembers', (newVal) ->
    return unless newVal
    $scope.teamCheck ?= {}
    for member in $scope.selectedMembers
      $scope.teamCheck[member] = true
