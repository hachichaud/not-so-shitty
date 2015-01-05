angular.module '%module%.home'
.config ($translateProvider) ->
  $translateProvider.translations 'en',
    HOME_TITLE: 'Welcome'
    HOME_TEXT: 'This is the beginning of an extraordinary app...'
    NAV_TO_BDC: 'BDC'
    NAV_TO_MEP: 'MEP'

  $translateProvider.translations 'fr',
    HOME_TITLE: 'Bienvenue'
    HOME_TEXT: 'Ceci est le commencement d\'une appli extraordinaire...'
    NAV_TO_BDC: 'BDC'
    NAV_TO_MEP: 'MEP'
