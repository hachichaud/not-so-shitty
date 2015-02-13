angular.module '%module%.pilot'
.factory 'Board',
($http, storage, trello) ->
  getBoardFromTrello = (boardId) ->
    return unless boardId
    $http
      method: 'get'
      url: trello.apiUrl + '/boards/' + boardId
      params:
        fields: 'prefs,name'
        key: trello.applicationKey
        token: storage.token
    .then (res) ->
      res.data

  getBoard = (boardId) ->
    return unless boardId
    getBoardFromTrello boardId
    .then (board) ->
      if board.prefs.backgroundImage and board.prefs.backgroundImageScaled
        url = board.prefs.backgroundImageScaled[0].url
        color = null
      else if board.prefs.backgroundColor
        url = null
        color = board.prefs.backgroundColor
      return {
        name: board.name
        url: url
        color: color
      }

  getBoard: getBoard
