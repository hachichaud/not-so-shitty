angular.module '%module%.setup'
.factory 'Setup',
($http, storage, trello) ->
  calculateTotalPoints = (totalManDays, speed) ->
    totalManDays * speed

  calculateSpeed = (totalPoints, totalManDays) ->
    return unless totalManDays > 0
    totalPoints / totalManDays

  saveToCard = (cardId, data) ->
    $http
      method: 'put'
      url: trello.apiUrl + '/cards/' + cardId + '/desc'
      headers:
        'Content-Type': undefined
      params:
        key: trello.applicationKey
        token: storage.token
        value: JSON.stringify data

  getCard = (cardId) ->
    return unless cardId
    $http
      method: 'get'
      url: trello.apiUrl + '/cards/' + cardId
      params:
        key: trello.applicationKey
        token: storage.token
    .then (res) ->
      res.data

  generateResources = (days, devTeam) ->
    return unless days and devTeam
    matrix = []
    for day in days
      line = []
      for member in devTeam
        line.push 1
      matrix.push line
    matrix

  getCardsFromColumn = (listId) ->
    $http
      method: 'get'
      url: trello.apiUrl + '/lists/' + listId + '/cards'
      params:
        key: trello.applicationKey
        token: storage.token
    .then (res) ->
      res.data

  getBoards = ->
    $http
      method: 'get'
      url: trello.url + '/members/me/boards'
      params:
        key: trello.applicationKey
        token: storage.token
    .then (res) ->
      res.data

  getBoardColumns = (boardId) ->
    $http
      method: 'get'
      url: trello.apiUrl + '/boards/' + boardId + '/lists'
      params:
        key: trello.applicationKey
        token: storage.token
    .then (res) ->
      res.data

  getBoardMembers = (boardId) ->
    $http
      method: 'get'
      url: trello.apiUrl + '/boards/' + boardId + '/members'
      params:
        key: trello.applicationKey
        token: storage.token
    .then (res) ->
      res.data

  getBoards: getBoards
  getBoardColumns: getBoardColumns
  getBoardMembers: getBoardMembers
  generateResources: generateResources
  calculateSpeed: calculateSpeed
  calculateTotalPoints: calculateTotalPoints
  getCardsFromColumn: getCardsFromColumn
  getCard: getCard
  saveToCard: saveToCard
