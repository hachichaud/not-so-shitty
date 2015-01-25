angular.module '%module%.setup'
.directive 'trelloAvatar', ->
  restrict: 'E'
  templateUrl: 'setup/directives/trello-avatar/view.html'
  scope:
    memberId: '@'
    size: '@'
  controller: 'TrelloAvatarCtrl'
