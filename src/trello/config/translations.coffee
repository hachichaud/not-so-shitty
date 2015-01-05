angular.module '%module%.trello'
.config ($translateProvider) ->
  $translateProvider.translations 'en',
    BACKLOG: 'Backlog'
    SPRINTBACKLOG: 'Sprint Backlog'
    PRODUCTBACKLOG: 'Product Backlog'
    DOING: 'Doing'
    BLOCKED: 'Blocked'
    VALIDATE: 'To Validate'
    DONE: 'Done'
    SPRINT_DATES: 'Sprint Dates'

  $translateProvider.translations 'fr',
    BACKLOG: 'Backlog'
    SPRINTBACKLOG: 'Sprint Backlog'
    PRODUCTBACKLOG: 'Product Backlog'
    DOING: 'Doing'
    BLOCKED: 'Blocked'
    VALIDATE: 'To Validate'
    DONE: 'Done'
    SPRINT_DATES: 'Dates du sprint'
