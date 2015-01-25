angular.module '%module%.setup'
.directive 'resourcesWidget', ->
  restrict: 'E'
  templateUrl: 'setup/directives/resources-widget/view.html'
  scope:
    boardMembers: '='
    team: '='
    dates: '='
    resources: '='
  controller: 'ResourcesWidgetCtrl'
