angular.module '%module%.trello'
.factory 'ChooseDates', ->
  generateDayList = (start, end) ->
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

  generateDayList: generateDayList
