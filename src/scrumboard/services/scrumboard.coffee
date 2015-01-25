angular.module '%module%.scrumboard'
.factory 'ScrumBoard',
($http, $q, trello, storage) ->
  doneListCards = undefined

  getMovedCardDate = (cardId) ->
    return unless cardId
    $http
      method: 'get'
      url: trello.apiUrl + '/cards/' + cardId + '/actions'
      params:
        key: trello.applicationKey
        token: storage.token
        filter: 'updateCard:idList'
    .then (res) ->
      if res.data.length > 0 and res.data[0].type is 'updateCard'
        # Last action date
        res.data[0].date
      else
        return undefined

  getDoneCards = ->
    return doneListCards if doneListCards?
    doneCards = []
    $http
      method: 'get'
      url: trello.apiUrl + '/lists/' + storage.setup.columnIds.done + '/cards'
      params:
        key: trello.applicationKey
        token: storage.token
    .then (res) ->
      for card in res.data
        doneCards.push getMovedCardDate card.id
      $q.all doneCards
      .then (results) ->
        for card, i in res.data
          card.movedDate = results[i] if results[i]?
        doneListCards = res.data
        res.data

  getDoneCards: getDoneCards
