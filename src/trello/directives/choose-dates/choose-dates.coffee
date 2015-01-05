angular.module '%module%.trello'
.directive 'chooseDates', ->
  restrict: 'AE'
  scope:
    dates: '='
  templateUrl: 'trello/directives/choose-dates/view.html'
  controller: 'ChooseDatesCtrl'

.controller 'ChooseDatesCtrl',
($scope, ChooseDates) ->
  $scope.ok = ->
    return unless $scope.dates.start and $scope.dates.end
    $scope.dates.days = ChooseDates.generateDayList $scope.dates.start, $scope.dates.end

  $scope.$watch 'dates.end', (newDates) ->
    return unless newDates
    return unless $scope.dates.start
    $scope.dates.days = ChooseDates.generateDayList $scope.dates.start, $scope.dates.end
