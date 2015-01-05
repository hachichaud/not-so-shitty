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
  $rootScope.storage = storage
