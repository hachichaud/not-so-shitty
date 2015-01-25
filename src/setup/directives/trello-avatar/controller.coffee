angular.module '%module%.setup'
.controller 'TrelloAvatarCtrl',
(Avatar, $scope) ->
  $scope.size = '30' unless $scope.size
  Avatar.getMember $scope.memberId
  .then (member) ->
    $scope.member = member
