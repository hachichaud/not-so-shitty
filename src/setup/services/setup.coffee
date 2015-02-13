angular.module '%module%.setup'
.factory 'Setup',
($http, $state, storage, trello) ->
  getTotalManDays = (matrix) ->
    total = 0
    for line in matrix
      for cell in line
        total += cell
    total

  calculateTotalPoints = (totalManDays, speed) ->
    totalManDays * speed

  calculateSpeed = (totalPoints, totalManDays) ->
    return unless totalManDays > 0
    totalPoints / totalManDays

  postLink = (cardId) ->
    return unless cardId
    link = getShareLink cardId
    $http
      method: 'post'
      url: trello.apiUrl + '/cards/' + cardId + '/attachments'
      headers:
        'Content-Type': undefined
      params:
        key: trello.applicationKey
        token: storage.token
        url: link
        name: 'Link to Burndown Chart'

  getShareLink = (cardId) ->
    $state.href 'login', { cardId: cardId}, { absolute: true }

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
    .then ->
      postLink cardId

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


  getMyBoards = ->
    $http
      method: 'get'
      url: trello.url + '/members/me/boards'
      params:
        key: trello.applicationKey
        token: storage.token
    .then (res) ->
      res.data

  getCardDesc = (cardId) ->
    $http
      method: 'get'
      url: trello.apiUrl + '/cards/' + cardId + '/desc'
      params:
        key: trello.applicationKey
        token: storage.token
    .then (res) ->
      res?.data?._value

  getBoards = ->
    if storage.trelloCardId
      getCardDesc storage.trelloCardId
      .then (desc) ->
        delete storage.trelloCardId
        storage.setup = JSON.parse desc
        getMyBoards()
    else getMyBoards()


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

  clearTeam = ->
    storage.setup.team.dev = []
    storage.setup.team.rest = []

  clearTeam: clearTeam
  getBoards: getBoards
  getBoardColumns: getBoardColumns
  getBoardMembers: getBoardMembers
  generateResources: generateResources
  calculateSpeed: calculateSpeed
  calculateTotalPoints: calculateTotalPoints
  getCardsFromColumn: getCardsFromColumn
  getCard: getCard
  saveToCard: saveToCard
  getTotalManDays: getTotalManDays
