angular.module '%module%.mepgraph'
.factory 'MepData', ($http) ->
  getData = ->
    $http.get '/api/data/mep'
    .then (res) ->
      res.data
    .catch (err) ->
      console.log err

  getData: getData
