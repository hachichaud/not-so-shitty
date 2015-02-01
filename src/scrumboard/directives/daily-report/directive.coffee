angular.module '%module%.scrumboard'
.directive 'dailyReport', ->
  restrict: 'AE'
  scope:
    data: '='
    dailyColumnId: '='
  templateUrl: 'scrumboard/directives/daily-report/view.html'
  controller: ($scope, ScrumBoard, DailyReport) ->
    $scope.createDailyReport = ->
      dailyReport = DailyReport.createDailyDesc $scope.data
      DailyReport.createDailyReportCard $scope.dailyColumnId, dailyReport
      .then (card) ->
        # select burndown graph
        svg = d3.select('#bdcgraph')[0][0].firstChild
        fd = DailyReport.getFormDataFromSvg svg
        DailyReport.postGraphToTrello card.id, fd
