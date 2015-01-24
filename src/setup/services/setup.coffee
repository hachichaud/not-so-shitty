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

  getBoards: getBoards
