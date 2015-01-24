angular.module '%module%.setup'
.controller 'SetupCtrl', ($scope, boards) ->
  $scope.boards = boards
