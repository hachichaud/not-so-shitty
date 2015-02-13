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
    getBoardsLabels boards
    .then (boardLabels) ->
      for board, i in boards
        board.retours = countLabels boardLabels[i], 'retour'
      boards

  getBoards: getBoards
  getRegressions: getRegressions
  getRetours: getRetours
