angular.module '%module%.user'
.factory 'User',
($http, $state, storage) ->
  apiVersion = 1
  # apiUrl = 'https://api.trello.com/' + apiVersion
  authEndpoint = 'https://trello.com/' + apiVersion + '/authorize'
  # https://trello.com/1/appKey/generate
  applicationKey = '820fea551eb26ccde968e547a1c1ad4e'

  authUrl = authEndpoint + '?key=' + applicationKey
  authUrl += '&expiration=30days'
  authUrl += '&response_type=token'
  authUrl += '&scope=read,write'
  authUrl += '&callback_method=fragment'

  loginReturnUrl = $state.href 'login', {}, { absolute: true }
  loginUrl = authUrl + '&return_url=' + loginReturnUrl

  retrieveToken = (event) ->
    if /#token=/.test location.href
      storage.token = location.href.replace /.*#token=(.*)/, '$1'
    if storage.token
      event.preventDefault()
      $state.go 'scrumboard'

  retrieveToken: retrieveToken
  loginUrl: loginUrl
