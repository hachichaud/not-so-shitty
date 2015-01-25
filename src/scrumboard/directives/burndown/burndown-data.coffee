angular.module '%module%.scrumboard'
.factory 'BurndownData', ->
  getCardPoints = (card) ->
    return unless card.name
    match = card.name.match /\(([-+]?[0-9]*\.?[0-9]+)\)/
    value = 0
    if match
      for matchVal in match
        value = parseFloat(matchVal, 10) unless isNaN(parseFloat(matchVal, 10))
    value

  getDoneBetweenDays = (doneCards, start, end, lastDay) ->
    return unless end
    # console.log 'getDoneBetweenDays :', start, end
    if lastDay
      endDate = moment()
    else
      endDate = end.date
    donePoints = 0
    for card in doneCards
      if card.movedDate
        if moment(card.movedDate).isBefore(endDate)
          if start
            if moment(card.movedDate).isAfter(start.date)
              donePoints += getCardPoints card
          else if not start
            donePoints += getCardPoints card
    # console.log donePoints + ' between ' + start?.label + ' and ' + end.label
    donePoints

  hideFutureDays = (value, day, dayPlusOne) ->
    return if isNaN value
    if not dayPlusOne
      return if moment().isBefore moment(day.date)
    else
      return if moment().isBefore moment(day.date).subtract(1, 'days')
    value

  generateData = (cards, days, resources, dayPlusOne) ->
  # generateGraphData = (settings, dayPlusOne) ->
    return unless cards and days and resources
    standard = resources.totalPoints
    totalDone = 0
    data = []
    # Fuck*** bdc, how does it work ?
    dayLabel = "Start"
    for day, i in days
      if i > 0
        dayResources = _.reduce resources.matrix[i - 1], (s, n) -> s + n
        standard = standard - dayResources*resources.speed
        totalDone += getDoneBetweenDays cards, previousDay, days[i], false
        diff = standard - (resources.totalPoints - totalDone) unless isNaN(totalDone)
        previousDay = days[i]
      else
        standard = parseFloat(standard, 10)
        left = parseFloat(standard, 10)
        diff = 0
        totalDone += 0
      data.push {
        "day": dayLabel
        "standard": standard
        "left": hideFutureDays resources.totalPoints - totalDone, day, dayPlusOne
        "diff": hideFutureDays diff, day, dayPlusOne
      }
      dayLabel = day.label
    # Last day
    dayResources = _.reduce resources.matrix[days.length - 1], (s, n) -> s + n
    standard = standard - dayResources*resources.speed
    totalDone += getDoneBetweenDays cards, previousDay, days[days.length - 1], true
    diff = standard - (resources.totalPoints - totalDone) unless isNaN(totalDone)
    data.push {
      "day": dayLabel
      "standard": standard
      "left": hideFutureDays resources.totalPoints - totalDone, day, dayPlusOne
      "diff": hideFutureDays diff, day, dayPlusOne
    }
    # console.log 'graph data ', data
    # console.log 'total done ', totalDone
    data

  generateData: generateData
