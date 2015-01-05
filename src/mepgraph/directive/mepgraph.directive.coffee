angular.module '%module%.mepgraph'
.directive 'mepgraph', ->
  restrict: 'AE'
  scope:
    data: '='
    units: '='
    standard: '='
  templateUrl: 'mepgraph/views/mepgraph.html'
  link: (scope, elem, attr) ->
    config =
      width: window.innerWidth - 20
      height: window.innerHeight * 0.6
      margins:
        top: 70
        right: 20
        bottom: 20
        left: 50
      color:
        standard: '#D93F8E'
        ratioMEP: '#5AA6CB'
        background: '#F2F2F2'
    scope.config = config

    render = (data, standard, units, cfg) ->
      vis = d3.select '#mepgraph'
      # GRAPH SIZE
      vis.attr 'width', cfg.width
      .attr 'height', cfg.height
      # RANGE
      xRange = d3.scale.ordinal()
      .rangeRoundBands [cfg.margins.left, cfg.width - cfg.margins.right], 0.1
      .domain data.map (d) ->
        d.week

      yRange = d3.scale.linear()
      .range [
        cfg.height - cfg.margins.bottom
        cfg.margins.top
      ]
      .domain [0, 1]

      # AXIS
      xAxis = d3.svg.axis()
      .scale xRange
      .tickSize 5
      .tickSubdivide true

      yAxis = d3.svg.axis()
      .scale yRange
      .tickSize 5
      .orient 'left'
      .tickSubdivide true
      .tickFormat (d) ->
        d * 100

      vis.append 'svg:g'
      .attr 'class', 'x axis'
      .attr 'transform', 'translate(0,' + (cfg.height - cfg.margins.bottom) + ')'
      .call xAxis

      vis.append 'svg:g'
      .attr 'class', 'y axis'
      .attr 'transform', 'translate(' + (cfg.margins.left) + ',0)'
      .call yAxis
      .append 'text'
      .attr 'x', 0
      .attr 'y', cfg.margins.top / 2
      .attr 'dy', '.71em'
      .style 'text-anchor', 'end'
      .text units.ratio


      # color: string
      drawBars = (type, color, textColor) ->
        vis.selectAll 'rect .' + type
        .data data
        .enter()
        .append 'rect'
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
        .attr 'class', type

        vis.selectAll 'text .' + type
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
      drawStandardLine = (value, color) ->
        linearXRange = d3.scale.linear()
        .range [
          cfg.margins.left
          cfg.width - cfg.margins.right
        ]
        .domain [
          d3.min data, (d) ->
            d.week
          d3.max data, (d) ->
            d.week
        ]

        drawStandard = d3.svg.line()
        .x (d) ->
          linearXRange d.week
        .y (d) ->
          yRange value
        .interpolate 'linear'

        vis.append 'svg:path'
        .attr 'class', 'standard'
        .attr 'd', drawStandard data
        .attr 'stroke', color
        .attr 'stroke-width', 2
        .attr 'fill', 'none'

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
        .attr 'fill', cfg.color.ratioMEP
        .attr 'stroke', 'none'
        .attr 'x', sizes.offsetLeft + cfg.margins.right * 3 + sizes.colWidth
        .attr 'y', sizes.margin * 2 + sizes.lineheight
        .attr 'dy', '20px'

        vis.append 'text'
        .attr 'class', 'jhmep-legend'
        .attr 'stroke', 'none'
        .attr 'fill', cfg.color.ratioMEP
        .attr 'x', sizes.offsetLeft + sizes.margin + sizes.colWidth + sizes.width + cfg.margins.right * 3
        .attr 'y', sizes.margin + sizes.lineheight
        .attr 'dy', '1.6em'
        .style 'text-anchor', 'start'
        .text '- dont JH pour MEP'

      drawBars 'background', cfg.color.background, cfg.color.ratioMEP
      drawBars 'ratio', cfg.color.ratioMEP, cfg.color.background
      drawStandardLine standard, cfg.color.standard
      drawLegends standard

    scope.$watch 'data', (newData) ->
      return unless newData
      render scope.data, scope.standard, scope.units, scope.config
