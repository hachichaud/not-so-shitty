angular.module '%module%.mepgraph'
.config ($translateProvider) ->
  $translateProvider.translations 'en',
    MEPGRAPH_TITLE: 'Resources vs MEP'
    MEPGRAPH_TEXT: 'See how much you waste...'

  $translateProvider.translations 'fr',
    MEPGRAPH_TITLE: 'Ressources vs MEP'
    MEPGRAPH_TEXT: 'See how much you waste...'
