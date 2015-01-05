angular.module '%module%.mepgraph'
.config ($stateProvider) ->
  $stateProvider
  .state 'home.mepgraph',
    templateUrl: 'mepgraph/views/view.html'
    controller: 'MepGraphCtrl'
