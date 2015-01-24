###*
  @ngdoc object
  @name storage
  @module %module%.utils
  @description

  This value object is an application-wide data-store.
  It's published in `$rootScope` for easy-access in views.
###

angular.module '%module%.utils'
.value 'storage', {}

.run ($rootScope, storage) ->
  if localStorage.storage
    for key, value of JSON.parse localStorage.storage
      storage[key] = value

  $rootScope.storage = storage

  store = (next, prev) ->
    return if next == prev
    localStorage.storage = JSON.stringify next

  $rootScope.$watch 'storage', store, true
