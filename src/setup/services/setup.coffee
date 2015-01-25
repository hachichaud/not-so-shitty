angular.module '%module%.setup'
.factory 'Setup',
($http, storage, trello) ->
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
