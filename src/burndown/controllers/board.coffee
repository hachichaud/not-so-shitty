angular.module '%module%.burndown'
.controller 'BoardCtrl',
($stateParams, $state, UserTrello) ->

  if $stateParams.cardId
    if not $stateParams.token
      href = location.href.split /#token=/
      if href.length > 1
        token = href[href.length - 1]
    else
      token = $stateParams.token
    if token
      UserTrello.setUserToken token
      UserTrello.setTrelloCardId $stateParams.cardId
      UserTrello.getBoardFromTrello()
      .then ->
        $state.go 'burndown'
