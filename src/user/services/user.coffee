angular.module '%module%.user'
.factory 'User',
($http, $state, trello, storage) ->
  authUrl = trello.authEndpoint + '?key=' + trello.applicationKey
  authUrl += '&expiration=30days'
  authUrl += '&response_type=token'
  authUrl += '&scope=read,write'
  authUrl += '&callback_method=fragment'

  loginReturnUrl = $state.href 'login', {}, { absolute: true }
  loginUrl = authUrl + '&return_url=' + loginReturnUrl

  retrieveCardId = (toParams) ->
    if toParams?.cardId
      storage.trelloCardId = toParams.cardId

  retrieveToken = (event, toParams) ->
    if /#token=/.test location.href
      storage.token = location.href.replace /.*#token=(.*)/, '$1'
    if storage.token
      event.preventDefault()
      $state.go 'setup'

  retrieveToken: retrieveToken
  retrieveCardId: retrieveCardId
  loginUrl: loginUrl
