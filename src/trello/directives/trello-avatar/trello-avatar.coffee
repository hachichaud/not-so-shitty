angular.module '%module%.trello'
.directive 'trelloAvatar',
(UserTrello) ->
  restrict: 'AE'
  scope:
    memberId: '@'
    size: '@'
  templateUrl: 'trello/directives/trello-avatar/view.html'
  link: ($scope) ->
    if not $scope.size
      $scope.size = '30'
    $scope.$watch 'memberId', (memberId) ->
      return unless memberId
      UserTrello.getMember $scope.memberId
      .then (member) ->
        $scope.username = member.username
        $scope.avatarHash = member.hash
        $scope.initials = member.initials
