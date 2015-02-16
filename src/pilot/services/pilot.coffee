angular.module '%module%.pilot'
.factory 'Pilot',
($http, $q, storage, trello) ->
  getBoards = ->
    $http
      method: 'get'
      url: trello.url + '/members/me/boards'
      params:
        key: trello.applicationKey
        token: storage.token
    .then (res) ->
      res.data

  getLabels = (boardId) ->
    return unless boardId

    $http
      method: 'get'
      url: trello.apiUrl + '/boards/' + boardId + '/labels'
      params:
        key: trello.applicationKey
        token: storage.token
    .then (res) ->
      res.data

  getNumRetours = (desc) ->
    match = desc.match /retours?\(([-+]?[0-9]*.?[0-9]+)\)/i
    value = 0
    if match
      for matchVal in match
        value = parseFloat(matchVal, 10) unless isNaN(parseFloat(matchVal, 10))
    value

  getNumOfRetoursFromBoard = (boardId) ->
    $http
      method: 'get'
      url: trello.apiUrl + '/boards/' + boardId + '/cards'
      params:
        key: trello.applicationKey
        token: storage.token
    .then (res) ->
      retourCards = _.filter res.data, (card) ->
        _.some card.labels, (label) ->
          /retours?/i.test label.name
      total = 0
      for card in retourCards
        total += getNumRetours card.desc
      {
        numRetourCards: retourCards.length
        retours: total
      }

  getBoardsLabels = (boards) ->
    return unless boards
    getBoardLabels = []
    for board in boards
      getBoardLabels.push getLabels board.id
    $q.all getBoardLabels
    .then (results) ->
      results

  countLabels = (boardLabels, name) ->
    return unless name and boardLabels.length > 0
    num = 0
    for label in boardLabels
      if label.name is name
        num = label.uses
    num

  getRegressions = (boards) ->
    return unless boards
    getBoardsLabels boards
    .then (boardLabels) ->
      for board, i in boards
        board.regressions = countLabels boardLabels[i], 'regression'
      boards

  getRetours = (boards) ->
    return unless boards
    retours = []
    for board in boards
      retours.push getNumOfRetoursFromBoard board.id
    $q.all retours
    .then (boardRetours) ->
      for board, i in boards
        board.retours = boardRetours[i].retours
        board.numRetourCards = boardRetours[i].numRetourCards
      boards

  getBoards: getBoards
  getRegressions: getRegressions
  getRetours: getRetours
