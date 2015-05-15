angular.module '%module%.setup'
.directive 'teamBuilderWidget', ->
  restrict: 'E'
  templateUrl: 'setup/directives/team-builder-widget/view.html'
  scope:
    boardMembers: '='
    team: '='
  controller: 'TeamBuilderWidgetCtrl'
