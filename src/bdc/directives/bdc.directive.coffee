angular.module '%module%.bdc'
.directive 'bdcgraph', ($filter) ->
  restrict: 'AE'
  scope:
    data: '='
  templateUrl: 'bdc/views/bdcgraph.html'
  link: (scope, elem, attr) ->
    config =
      width: window.innerWidth - 20
      height: window.innerHeight * 0.6
      margins:
        top: 70
        right: 70
        bottom: 20
        left: 50
      tickSize: 5
      color:
        standard: '#D93F8E'
        foreground: '#5AA6CB'
        background: '#F2F2F2'
    scope.config = config

    bdcgraph = d3.select '#bdcgraph'

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
          d.standard - 10
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
      .attr 'stroke', cfg.color.foreground
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
        .attr 'fill', cfg.color.foreground


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
        .attr 'fill', cfg.color.foreground
        .attr 'text-anchor', 'start'
        .text (d) ->
          if d.diff >= 0
            return '+' + d.diff.toPrecision(2) + ' :)'
          else
            return d.diff.toPrecision(2) + ' :('

      drawLegends = (standardValue) ->
        sizes =
          width: 20
          height: 20
          margin: 10
          offsetLeft: 20
          lineheight: 20
          colWidth: 180

        # Standard
        vis.append 'rect'
        .attr 'class', 'standard-legend'
        .attr 'width', sizes.width
        .attr 'height', sizes.height
        .attr 'fill', cfg.color.standard
        .attr 'stroke', 'none'
        .attr 'x', sizes.offsetLeft + cfg.margins.right * 3
        .attr 'y', sizes.margin
        .attr 'dy', '20px'

        vis.append 'text'
        .attr 'class', 'standard-legend'
        .attr 'stroke', 'none'
        .attr 'fill', cfg.color.standard
        .attr 'x', sizes.offsetLeft + sizes.margin + sizes.width + cfg.margins.right * 3
        .attr 'y', 0
        .attr 'dy', '1.6em'
        .style 'text-anchor', 'start'
        .text 'Standard : ' + standardValue * 100 + '%JH'

        # JH
        vis.append 'rect'
        .attr 'class', 'jh-legend'
        .attr 'width', sizes.width
        .attr 'height', sizes.height
        .attr 'fill', cfg.color.background
        .attr 'stroke', 'none'
        .attr 'x', sizes.offsetLeft + cfg.margins.right * 3
        .attr 'y', sizes.margin * 2 + sizes.lineheight
        .attr 'dy', '20px'

        vis.append 'text'
        .attr 'class', 'jh-legend'
        .attr 'stroke', 'none'
        .attr 'fill', cfg.color.background
        .attr 'x', sizes.offsetLeft + sizes.margin + sizes.width + cfg.margins.right * 3
        .attr 'y', sizes.margin + sizes.lineheight
        .attr 'dy', '1.6em'
        .style 'text-anchor', 'start'
        .text 'Ressources en JH'

        # MEP
        vis.append 'rect'
        .attr 'class', 'jhmep-legend'
        .attr 'width', sizes.width
        .attr 'height', sizes.height
        .attr 'fill', cfg.color.foreground
        .attr 'stroke', 'none'
        .attr 'x', sizes.offsetLeft + cfg.margins.right * 3 + sizes.colWidth
        .attr 'y', sizes.margin * 2 + sizes.lineheight
        .attr 'dy', '20px'

        vis.append 'text'
        .attr 'class', 'jhmep-legend'
        .attr 'stroke', 'none'
        .attr 'fill', cfg.color.foreground
        .attr 'x', sizes.offsetLeft + sizes.margin + sizes.colWidth + sizes.width + cfg.margins.right * 3
        .attr 'y', sizes.margin + sizes.lineheight
        .attr 'dy', '1.6em'
        .style 'text-anchor', 'start'
        .text '- dont JH pour MEP'

      # drawBars 'background', cfg.color.background, cfg.color.foreground
      # drawBars 'ratio', cfg.color.foreground, cfg.color.background
      drawStandardLine cfg.color.standard
      drawDoneLine cfg.color.foreground
      drawValues()
      # drawLegends standard

    scope.$watch 'data', (newData) ->
      return unless newData
      render scope.data, scope.config
