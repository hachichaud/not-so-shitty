angular.module '%module%.mepgraph'
.factory 'MepData', ($http) ->
  getData = ->
    $http.get 'data-mep.json'
    .then (res) ->
      res.data
    .catch (err) ->
      console.log err

  getData: getData
