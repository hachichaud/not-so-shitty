angular.module '%module%.trello'
.factory 'UserTrello',
($rootScope, $window, $q, TrelloApi) ->
  # TODO separate trello and storage
  $rootScope.user ?= {}
  userTokenDeferred = $q.defer()
  boardIdDeferred = $q.defer()

  doneListCards = undefined

  getUserRecord = ->
    userTokenDeferred.promise
    .then (token) ->
      TrelloApi.getUserRecord token
      .then (res) ->
        $rootScope.user.memberId = res.id
        $rootScope.user.username = res.username
        res

  getUserBoards = ->
    userTokenDeferred.promise
    .then (token) ->
      TrelloApi.getUserBoards token

  getMember = (memberId) ->
    userTokenDeferred.promise
    .then (token) ->
      TrelloApi.getFromCollection 'member', memberId, token
      .then (res) ->
        if res.uploadedAvatarHash
          hash = res.uploadedAvatarHash
        else if res.avatarHash
          hash = res.avatarHash
        else
          hash = null
        return {
          username: res.username
          fullname: res.fullname
          hash: hash
          initials: res.initials
        }
        res

  getCardsFromList = (listId) ->
    userTokenDeferred.promise
    .then (token) ->
      TrelloApi.getItemFromCollection 'lists', listId, 'cards', null, token

  getMovedCardDate = (cardId) ->
    return unless cardId
    userTokenDeferred.promise
    .then (token) ->
      TrelloApi.getCardUpdateListIdActions cardId, token
      .then (data) ->
        if data.length > 0 and data[0].type is 'updateCard'
          # Last action date
          data[0].date
        else
          return undefined

  getDoneListCards = (listId) ->
    return doneListCards if doneListCards
    doneCards = []
    getCardsFromList listId
    .then (cards) ->
      # console.log 'get done list cards', cards
      for card in cards
        doneCards.push getMovedCardDate card.id
      $q.all doneCards
      .then (results) ->
        for card, i in cards
          card.movedDate = results[i] if results[i]?
        doneListCards = cards
        cards

  getList = (listId) ->
    userTokenDeferred.promise
    .then (token) ->
      TrelloApi.getFromCollection 'lists', listId, token

  getMembers = (boardId) ->
    userTokenDeferred.promise
    .then (token) ->
      TrelloApi.getItemFromCollection 'boards', boardId, 'members', null, token


  getListsFromBoard = (boardId) ->
    userTokenDeferred.promise
    .then (token) ->
      TrelloApi.getItemFromCollection 'boards', boardId, 'lists', null, token

  setMemberId = (memberId) ->
    return unless memberId
    $window.localStorage.memberId = memberId
    $rootScope.user.memberId = memberId

  setUserName = (username) ->
    return unless username
    $window.localStorage.username = username
    $rootScope.user.username = username

  setSprintDays = (days) ->
    return unless days
    $window.localStorage.sprintDays = JSON.stringify days
    $rootScope.user.sprintDays = days

  setUserBoardId = (boardId) ->
    return unless boardId?
    $window.localStorage.boardId = boardId
    $rootScope.user.boardId = boardId
    boardIdDeferred.resolve boardId

  setUserToken = (token) ->
    return unless token?
    $window.localStorage.userToken = token
    $rootScope.user.trelloToken = token
    userTokenDeferred.resolve token

  setUserLists = (lists) ->
    return unless lists?
    $window.localStorage.lists = JSON.stringify lists
    $rootScope.user.lists = lists

  getUserLists = ->
    if $window.localStorage.lists
      $rootScope.user.lists = JSON.parse $window.localStorage.lists

  getSprintDays = ->
    if $window.localStorage.sprintDays
      $rootScope.user.sprintDays = JSON.parse $window.localStorage.sprintDays

  getUserToken = ->
    if $window.localStorage.userToken
      userTokenDeferred.resolve $window.localStorage.userToken
      $rootScope.user.trelloToken = $window.localStorage.userToken
    userTokenDeferred.promise

  getUserBoardId = ->
    if $window.localStorage.boardId
      boardIdDeferred.resolve $window.localStorage.boardId
      $rootScope.user.boardId = $window.localStorage.boardId
    boardIdDeferred.promise

  getMemberId = ->
    if $window.localStorage.memberId
      $rootScope.user.memberId = $window.localStorage.memberId

  getUserName = ->
    if $window.localStorage.username
      $rootScope.user.username = $window.localStorage.username

  getTeam = ->
    if $window.localStorage.team
      $rootScope.user.team = JSON.parse $window.localStorage.team

  getResources = ->
    if $window.localStorage.resources
      $rootScope.user.resources = JSON.parse $window.localStorage.resources

  init = ->
    getTeam()
    getResources()
    getUserRecord()
    getUserBoardId()
    getUserToken()
    getUserLists()
    getSprintDays()
    getMemberId()
    getUserName()

  saveSettings = (user) ->
    setUserToken user.trelloToken
    setUserLists user.lists
    setSprintDays user.sprintDays
    setMemberId user.memberId
    setUserName user.username

  getUserSettings = ->
    init()
    $rootScope.user

  init()

  readWriteTokenUrl: TrelloApi.readWriteTokenUrl
  getList: getList
  getMembers: getMembers
  setUserBoardId: setUserBoardId
  setUserToken: setUserToken
  setUserLists: setUserLists
  setSprintDays: setSprintDays
  setMemberId: setMemberId
  setUserName: setUserName
  getUserBoardId: getUserBoardId
  getUserToken: getUserToken
  getUserRecord: getUserRecord
  getUserBoards: getUserBoards
  getMember: getMember
  getListsFromBoard: getListsFromBoard
  getCardsFromList: getCardsFromList
  saveSettings: saveSettings
  getUserSettings: getUserSettings
  getDoneListCards: getDoneListCards
