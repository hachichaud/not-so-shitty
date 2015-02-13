angular.module '%module%.setup'
.directive 'selectPeople', ->
  restrict: 'E'
  templateUrl: 'setup/directives/select-people/view.html'
  scope:
    members: '='
    selectedMembers: '='
  controller: 'SelectPeopleCtrl'
