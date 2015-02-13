angular.module '%module%.setup'
.controller 'TrelloAvatarCtrl',
(Avatar, $scope) ->
  $scope.size = '30' unless $scope.size
  $scope.$watch 'memberId', (memberId) ->
    return unless memberId
    Avatar.getMember $scope.memberId
    .then (member) ->
      $scope.member = member
