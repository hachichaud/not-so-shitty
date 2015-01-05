angular.module '%module%.bdc'
.factory 'BdcData',
($window, $rootScope, Resources, UserTrello) ->
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

  getDoneBetweenDays = (doneCards, start, end, lastDay) ->
    return unless end
    return if moment(end.date).isAfter moment().subtract(1, 'days')
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

  generateGraphData = (settings) ->
    return unless settings
    standard = settings.sprintPoints
    totalDone = 0
    data = [
      {
        "day": "Start"
        "standard": parseFloat(standard, 10)
        "left": parseFloat(standard, 10)
        "diff": 0
      }
    ]
    UserTrello.getDoneListCards settings.lists.done
    .then (doneCards) ->
      # console.log 'doneCards', doneCards
      previousDay = undefined
      for day, i in settings.sprintDays
        dayResources = _.reduce settings.resources[i], (s, n) -> s + n
        standard = standard - dayResources*settings.speed
        totalDone += getDoneBetweenDays doneCards, previousDay, settings.sprintDays[i], (i >= settings.sprintDays.length - 1)
        # console.log settings.sprintDays[i].label + ' : ' + totalDone
        data.push {
          "day": day.label
          "standard": standard
          "left": settings.sprintPoints - totalDone unless isNaN(totalDone)
          "diff": standard - (settings.sprintPoints - totalDone) unless isNaN(totalDone)
        }
        previousDay = settings.sprintDays[i]

      data

  updateButSprintSpeed = (settings) ->
    setSprintSpeed settings.totalJH, settings.speed, settings.sprintPoints
    generateGraphData $rootScope.user
    .then (data) ->
      $rootScope.graphData = data

  updateData = (settings) ->
    sprintSpeed = Resources.calculateSprintSpeed $rootScope.user.resources, getSprintPoints()
    setSprintSpeed sprintSpeed.jh, sprintSpeed.speed, sprintSpeed.sprintPoints
    generateGraphData $rootScope.user
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
