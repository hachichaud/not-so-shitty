angular.module '%module%.scrumboard'
.directive 'burndown', ->
  restrict: 'AE'
  scope:
    data: '='
  templateUrl: 'scrumboard/directives/burndown/view.html'
  link: (scope, elem, attr) ->
    maxWidth = 1000
    whRatio = 0.54
    computeDimensions = ->
      if window.innerWidth > maxWidth
        width = 800
      else
        width = (window.innerWidth - 80)
      height = whRatio * width
      if height + 128 > window.innerHeight
        console.log window.innerHeight, height
        height = window.innerHeight - 128
        width = height / whRatio
      config =
        width: width
        height: height
        margins:
          top: 20
          right: 70
          bottom: 20
          left: 50
        tickSize: 5
        color:
          standard: '#D93F8E' # default colors
          done: '#5AA6CB'
      config

    config = computeDimensions()
    bdcgraph = d3.select '#bdcgraph'

    window.onresize = ->
      config = computeDimensions()
      render scope.data, config

    render = (data, cfg) ->
      bdcgraph.select '*'
      .remove()
      vis = bdcgraph.append 'svg'
      .attr 'width', cfg.width
      .attr 'height', cfg.height

      # RANGE
      xRange = d3.scale.linear()
      .range [
        cfg.margins.left
        cfg.width - cfg.margins.right
      ]
      .domain [
        d3.min data, (d, i) ->
          i + 1
        d3.max data, (d, i) ->
          i + 1
      ]

      yRange = d3.scale.linear()
      .range [
        cfg.height - cfg.margins.bottom
        cfg.margins.top
      ]
      .domain [
        d3.min data, (d, i) ->
          (Math.min d.standard, d.left) - 1
        d3.max data, (d, i) ->
          d.standard + 4
      ]

      # AXIS
      xAxis = d3.svg.axis()
      .scale xRange
      .tickSize 0
      .ticks data.length
      .tickFormat (d) ->
        data[d-1].day

      yAxis = d3.svg.axis()
      .scale yRange
      .tickSize 0
      .orient 'left'
      .tickSubdivide true
      .tickFormat (d) ->
        d

      vis.append 'svg:g'
      .attr 'class', 'x axis'
      .attr 'transform', 'translate(0,' + (yRange(0)) + ')'
      .call xAxis

      vis.append 'svg:g'
      .attr 'class', 'y axis'
      .attr 'transform', 'translate(' + (cfg.margins.left) + ',0)'
      .call yAxis

      drawZero = d3.svg.line()
      .x (d, i) ->
        xRange i + 1
      .y (d) ->
        yRange(0)
      .interpolate 'linear'

      vis.append 'svg:path'
      .attr 'class', 'axis'
      .attr 'd', drawZero data
      .attr 'stroke', cfg.color.done
      .attr 'stroke-width', 1
      .attr 'fill', 'none'

      # color: string
      drawBars = (type, color, textColor) ->
        vis.selectAll 'rect .' + type
        .data data
        .enter()
        .append 'rect'
        .attr 'class', type
        .attr 'x', (d) ->
          xRange d.week
        .attr 'y', (d) ->
          if type is 'ratio'
            yRange d.ratio
          else
            yRange 1
        .attr 'width', xRange.rangeBand()
        .attr 'height', (d) ->
          if type is 'ratio'
            (cfg.height - cfg.margins.bottom) - yRange d.ratio
          else
            (cfg.height - cfg.margins.bottom) - yRange 1
        .attr 'fill', color

        vis.selectAll 'text.' + type
        .data data
        .enter()
        .append 'text'
        .attr 'class', type
        .attr 'stroke', 'none'
        .attr 'fill', textColor
        .attr 'x', (d) ->
          xRange ( d.week )
        .attr 'y', (d) ->
          if type is 'ratio'
            yRange d.ratio
          else
            yRange 1
        .attr 'dy', '1.6em'
        .attr 'dx', xRange.rangeBand() - 10
        .style 'text-anchor', 'end'
        .text (d) ->
          if type is 'ratio'
            d.MEP
          else
            d.JH

      # DRAW STANDARD
      drawStandardLine = (color) ->

        standardArray = _.filter data, (d) ->
          return d.standard?
        standardArray = _.map standardArray, (d) ->
          d.standard

        drawStandard = d3.svg.line()
        .x (d, i) ->
          xRange i + 1
        .y (d) ->
          yRange d
        .interpolate 'linear'

        vis.append 'svg:path'
        .attr 'class', 'standard'
        .attr 'd', drawStandard standardArray
        .attr 'stroke', color
        .attr 'stroke-width', 2
        .attr 'fill', 'none'

        vis.selectAll 'circle .standard-point'
        .data data
        .enter()
        .append 'circle'
        .attr 'class', 'standard-point'
        .attr 'cx', (d, i) ->
          xRange i + 1
        .attr 'cy', (d) ->
          yRange d.standard
        .attr 'r', 4
        .attr 'fill', cfg.color.standard

      drawDoneLine = (color) ->

        values = _.filter data, (d) ->
          return d.left?
        valuesArray = _.map values, (d) ->
          d.left

        drawLine = d3.svg.line()
        .x (d, i) ->
          xRange i + 1
        .y (d) ->
          yRange d
        .interpolate 'linear'

        vis.append 'svg:path'
        .attr 'class', 'done-line'
        .attr 'd', drawLine valuesArray
        .attr 'stroke', color
        .attr 'stroke-width', 2
        .attr 'fill', 'none'

        vis.selectAll 'circle .done-point'
        .data values
        .enter()
        .append 'circle'
        .attr 'class', 'done-point'
        .attr 'cx', (d, i) ->
          xRange i + 1
        .attr 'cy', (d) ->
          return unless d.left?
          yRange d.left
        .attr 'r', 4
        .attr 'fill', cfg.color.done


      drawValues = (color) ->

        values = _.filter data, (d) ->
          return d.left? and d.standard? and d.diff?

        vis.selectAll 'text .done-values'
        .data values
        .enter()
        .append 'text'
        .attr 'class', 'done-values'
        .attr 'class', (d) ->
          if d.diff >= 0
            'good done-values'
          else
            'bad done-values'
        .attr 'x', (d, i) ->
          xRange i + 1
        .attr 'y', (d) ->
          - 10 + yRange(Math.max(d.standard, d.left))
        .attr 'fill', cfg.color.done
        .attr 'text-anchor', 'start'
        .text (d) ->
          if d.diff >= 0
            return '+' + d.diff.toPrecision(2) + ' :)'
          else
            return d.diff.toPrecision(2) + ' :('

      drawStandardLine cfg.color.standard
      drawDoneLine cfg.color.done
      drawValues()

    scope.$watch 'data', (data) ->
      return unless data
      render data, config
