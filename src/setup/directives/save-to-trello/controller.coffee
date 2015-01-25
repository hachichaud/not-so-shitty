angular.module '%module%.setup'
.controller 'SaveToTrelloCtrl',
(Setup, $scope) ->

  $scope.save = ->
    # console.log 'save ', $scope.data
    Setup.saveToCard $scope.cardId, $scope.data

  $scope.$watch 'cardId', (cardId) ->
    return unless cardId
    Setup.getCard cardId
    .then (card) ->
      $scope.card = card
