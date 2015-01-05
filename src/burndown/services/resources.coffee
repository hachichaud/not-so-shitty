angular.module '%module%.burndown'
.factory 'Resources', ->
  # There has to be a better way ...
  generate = (devTeam, days) ->
    # console.log 'generate resources', devTeam, days
    return unless devTeam
    return unless days
    resources = []
    for day in days
      dayResources = []
      for member in devTeam
        dayResources.push 1
      resources.push dayResources
    # console.log 'generateResources', resources
    resources

  getTotalJH = (resources) ->
    total = 0
    for day in resources
      total += _.reduce day, (sum, num) -> sum + num
    total

  calculateSprintSpeed = (resources, sprintPoints) ->
    if not sprintPoints
      sprintPoints = 30 #random magic default number
    totalJH = getTotalJH resources
    speed = sprintPoints / totalJH
    return {
      jh: totalJH
      speed: speed
      sprintPoints: sprintPoints
    }

  generate: generate
  calculateSprintSpeed: calculateSprintSpeed
