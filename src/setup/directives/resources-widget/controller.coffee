angular.module '%module%.setup'
.controller 'ResourcesWidgetCtrl',
($scope, Setup) ->
  $scope.datePattern = /^(19|20)\d\d[- /.](0[1-9]|1[012])[- /.](0[1-9]|[12][0-9]|3[01])$/

  generateDayList = (start, end) ->
    return unless start and end
    # check if start < end
    current = moment start
    endM = moment(end).add(1, 'days')
    return unless endM.isAfter current
    days = []
    while not current.isSame endM
      day = current.isoWeekday()
      if day isnt 6 and day isnt 7
        days.push {
          label: current.format 'dddd'
          date: current.format()
        }
      current.add 1, 'days'
    days

  $scope.$watch 'dates.end', (newVal) ->
    return unless newVal?
    $scope.dates.days = generateDayList $scope.dates.start, $scope.dates.end
