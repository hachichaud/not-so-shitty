angular.module '%module%.burndown'
.factory 'DelaySprint', ->

  getDelayValues = (diff1, diff2) ->
    if not (diff2 and diff1)
      variation = 'neutral'
      delayClass = ''
      delay = 0
    else
      delay = diff2.toPrecision 2
      if diff2 - diff1 < 0
        variation = 'down'
      else if diff2 - diff1 > 0
        variation = 'up'
      else
        variation = 'neutral'
      delayClass = if diff2 >= 0 then 'good' else 'bad'
    return {
      delayClass: delayClass
      delay: delay
      variation: variation
    }

  calculateDelay = (graphData) ->
    for day, i in graphData
      if not day.diff
        if i > 1
          getDelayValues graphData[i-2].diff, graphData[i-1].diff
          return
        else if i > 0
          getDelayValues
          return
    if graphData.length > 1 and graphData[graphData.length - 1].diff
      getDelayValues graphData[graphData.length - 2].diff, graphData[graphData.length - 1].diff

  calculateDelay: calculateDelay
