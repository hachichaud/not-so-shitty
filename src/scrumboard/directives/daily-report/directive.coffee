angular.module '%module%.scrumboard'
.directive 'dailyReport', ->
  restrict: 'A'
  transclude: true
  scope:
    data: '='
    dailyColumnId: '='
  templateUrl: 'scrumboard/directives/daily-report/view.html'
  controller: ($scope, ScrumBoard, DailyReport) ->
    $scope.createDailyReport = ->
      cardId = undefined
      # console.log $scope.dailyColumnId
      dailyReport = DailyReport.createDailyDesc $scope.data
      DailyReport.createDailyReportCard $scope.dailyColumnId, dailyReport
      .then (card) ->
        # select burndown graph
        cardId = card.id
        svg = d3.select('#bdcgraph')[0][0].firstChild
        fd = DailyReport.getFormDataFromSvg svg
        DailyReport.postGraphToTrello card.id, fd
        .then ->
          DailyReport.putCardAtTopPosition cardId
