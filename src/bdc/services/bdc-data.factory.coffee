angular.module '%module%.bdc'
.factory 'BdcData',
($window, $rootScope, $q, Resources, UserTrello) ->
  getCardPoints = (card) ->
    return unless card.name
    match = card.name.match /\(([-+]?[0-9]*\.?[0-9]+)\)/
    value = 0
    if match
      for matchVal in match
        value = parseFloat(matchVal, 10) unless isNaN(parseFloat(matchVal, 10))
    value

  setSprintSpeed = (totalJH, speed, sprintPoints) ->
    $rootScope.user.totalJH = totalJH
    $rootScope.user.speed = speed
    $rootScope.user.sprintPoints = sprintPoints
    $window.localStorage.totalJH = totalJH
    $window.localStorage.speed = speed
    $window.localStorage.sprintPoints = sprintPoints

  getSprintPoints = ->
    if $window.localStorage.sprintPoints
      $rootScope.user.sprintPoints = parseFloat($window.localStorage.sprintPoints, 10)
      return $rootScope.user.sprintPoints
    else return

  getDoneBetweenDays = (doneCards, start, end, lastDay, dayPlusOne) ->
    return unless end
    if dayPlusOne
      return if moment(end.date).isAfter moment().add(1, 'days')
    else
      return if moment(end.date).isAfter moment()
    # console.log 'getDoneBetweenDays :', start, end
    if lastDay
      endDate = new Date()
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

  generateGraphData = (settings, dayPlusOne) ->
    return unless settings
    standard = settings.sprintPoints
    totalDone = 0
    data = []
    # Fuck*** bdc, how does it work ?
    $q.when UserTrello.getDoneListCards settings.lists.done
    .then (doneCards) ->
      for day, i in settings.sprintDays
        if i > 0
          dayResources = _.reduce settings.resources[i - 1], (s, n) -> s + n
          standard = standard - dayResources*settings.speed
          totalDone += getDoneBetweenDays doneCards, previousDay, settings.sprintDays[i], ((i) >= settings.sprintDays.length - 1), dayPlusOne
          diff = standard - (settings.sprintPoints - totalDone) unless isNaN(totalDone)
          previousDay = settings.sprintDays[i]
        else
          standard = parseFloat(standard, 10)
          left = parseFloat(standard, 10)
          diff = 0
          totalDone += 0
        data.push {
          "day": day.label
          "standard": standard
          "left": settings.sprintPoints - totalDone unless isNaN(totalDone)
          "diff": diff
        }
      data

  updateButSprintSpeed = (settings, dayPlusOne) ->
    setSprintSpeed settings.totalJH, settings.speed, settings.sprintPoints
    generateGraphData $rootScope.user, dayPlusOne
    .then (data) ->
      $rootScope.graphData = data

  updateData = (settings, dayPlusOne) ->
    sprintSpeed = Resources.calculateSprintSpeed $rootScope.user.resources, getSprintPoints()
    setSprintSpeed sprintSpeed.jh, sprintSpeed.speed, sprintSpeed.sprintPoints
    generateGraphData $rootScope.user, dayPlusOne
    .then (data) ->
      $rootScope.graphData = data

  getDonePointsFromCards = (cards) ->
    return unless cards
    points = 0
    for card in cards
      points += getCardPoints card
    points

  getDoneListName = ->
    # console.log $rootScope.user.lists.done
    UserTrello.getList $rootScope.user.lists.done
    .then (list) ->
      list.name

  getAddableMembers = ->
    result = []
    UserTrello.getMembers $rootScope.user.boardId
    .then (members) ->
      for member in members
        unless ($rootScope.user.team.dev.indexOf(member.id) >= 0) or ($rootScope.user.team.other.indexOf(member.id) >= 0)
          result.push member.id
      result

  getPointsFromListType = (listType) ->
    UserTrello.getCardsFromList $rootScope.user.lists[listType]
    .then (res) ->
      getDonePointsFromCards res

  updateButSprintSpeed: updateButSprintSpeed
  getAddableMembers: getAddableMembers
  getDoneListName: getDoneListName
  getDonePointsFromCards: getDonePointsFromCards
  generateGraphData: generateGraphData
  updateData: updateData
  getPointsFromListType: getPointsFromListType
