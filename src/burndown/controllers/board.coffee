angular.module '%module%.burndown'
.controller 'BoardCtrl',
($stateParams, $state, UserTrello) ->

  if $stateParams.cardId and $stateParams.token
    UserTrello.setUserToken $stateParams.token
    UserTrello.setTrelloCardId $stateParams.cardId
    UserTrello.getBoardFromTrello()
    .then ->
      $state.go 'burndown'
