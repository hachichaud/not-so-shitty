angular.module '%module%.trello'
.factory 'TrelloApi',
($http, $window) ->
  apiVersion = 1
  apiUrl = 'https://api.trello.com/' + apiVersion
  trelloUrl = 'https://trello.com/' + apiVersion
  # https://trello.com/1/appKey/generate
  applicationKey = '820fea551eb26ccde968e547a1c1ad4e'

  readWriteTokenUrl = 'https://trello.com/1/authorize?key=' + applicationKey
  readWriteTokenUrl += '&expiration=30days&response_type=token&scope=read,write'

  getUserRecord = (token) ->
    return unless token?
    url = trelloUrl + '/members/me'
    url += '?key=' + applicationKey
    url += '&token=' + token
    $http.get url
    .then (res) ->
      res.data

  getUserBoards = (token) ->
    return unless token?
    url = trelloUrl + '/members/me/boards'
    url += '?key=' + applicationKey
    url += '&token=' + token
    $http.get url
    .then (res) ->
      res.data

  getFromCollection = (collection, collectionId, token) ->
    return unless token?
    url = apiUrl + '/' + collection + '/' + collectionId
    url += '?key=' + applicationKey
    url += '&token=' + token
    $http.get url
    .then (res) ->
      res.data

  getItemFromCollection = (collection, collectionId, item, itemId, token) ->
    return unless token?
    url = apiUrl + '/' + collection + '/' + collectionId + '/' + item
    if itemId
      url += '/' + itemId
    url += '?key=' + applicationKey
    url += '&token=' + token
    $http.get url
    .then (res) ->
      res.data

  getCardUpdateListIdActions = (cardId, token) ->
    return unless token?
    url = apiUrl + '/cards/' + cardId + '/actions'
    url += '?key=' + applicationKey
    url += '&token=' + token
    url += '&filter=updateCard:idList'
    $http.get url
    .then (res) ->
      res.data

  getCardDesc = (cardId, token) ->
    return unless token?
    url = apiUrl + '/cards/' + cardId + '/desc'
    url += '?key=' + applicationKey
    url += '&token=' + token
    $http.get url
    .then (res) ->
      res.data

  writeDataToCard = (cardId, token, data) ->
    return unless token?
    url = apiUrl + '/cards/' + cardId + '/desc'
    url += '?key=' + applicationKey
    url += '&token=' + token
    $http
      url: url
      method: "PUT"
      headers:
        'Content-Type': undefined
      params:
        value: JSON.stringify data

  getCardDesc: getCardDesc
  writeDataToCard: writeDataToCard
  readWriteTokenUrl: readWriteTokenUrl
  getFromCollection: getFromCollection
  getItemFromCollection: getItemFromCollection
  getCardUpdateListIdActions: getCardUpdateListIdActions
  getUserRecord: getUserRecord
  getUserBoards: getUserBoards
