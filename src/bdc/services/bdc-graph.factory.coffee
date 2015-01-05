angular.module '%module%.bdc'
.factory 'BdcGraph',
(BdcData) ->
  generateBdcData = (boardConfig, resources, speed, doneList) ->
    return unless boardConfig
    standard = boardConfig.sprint.sprintPoints
    totalDone = 0
    data = [
      {
        "day": "Start"
        "standard": standard
        "left": standard
        "diff": 0
      }
    ]

    for day, i in boardConfig.sprint.days
      dayResources = _.reduce resources[i], (s, n) -> s + n
      standard = standard - dayResources*speed
      totalDone += BdcData.getDoneByDay doneList, boardConfig.sprint.days[i]

      data.push {
        "day": day.label
        "standard": standard
        "left": boardConfig.sprint.sprintPoints - totalDone unless isNaN(totalDone)
        "diff": standard - (boardConfig.sprint.sprintPoints - totalDone) unless isNaN(totalDone)
      }

    data

  generateBdcData: generateBdcData
