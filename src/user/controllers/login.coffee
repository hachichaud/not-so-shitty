angular.module '%module%.user'
.controller 'LoginCtrl',
($scope, User) ->
  $scope.loginUrl = User.loginUrl
