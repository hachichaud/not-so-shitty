angular.module '%module%.user'
.factory 'UnauthorizedInterceptor', (storage) ->
  unauthorizedInterceptor =
    responseError: (response) ->
      if 401 is response.status
        delete storage.token
  unauthorizedInterceptor
