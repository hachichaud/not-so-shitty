angular.module '%module%.scrumboard'
.controller 'ScrumBoardCtrl',
($scope, doneCards, storage, BurndownData, ScrumBoard) ->
  $scope.doneCards = doneCards
  $scope.setup = storage.setup

  $scope.bdcData = BurndownData.generateData doneCards, storage.setup.dates.days, storage.setup.resources, false

  $scope.showTable = false

  $scope.export = ->
    svg = d3.select('#bdcgraph')[0][0].firstChild
    img = new Image()
    serializer = new XMLSerializer()
    svgStr = serializer.serializeToString(svg)
    img.src = 'data:image/svg+xml;base64,' + window.btoa(svgStr)

    canvas = document.createElement("canvas")
    document.body.appendChild(canvas)
    canvas.width = 400
    canvas.height = 200
    canvas.getContext("2d").drawImage(img,0,0,400,200)
    dataurl = canvas.toDataURL("image/png")

    dataURItoBlob = (dataURI) ->
      # convert base64/URLEncoded data component to raw binary data held in a string
      byteString = undefined
      if dataURI.split(',')[0].indexOf('base64') >= 0
        byteString = atob(dataURI.split(',')[1])
      else
        byteString = unescape(dataURI.split(',')[1])
      # separate out the mime component
      mimeString = dataURI.split(',')[0].split(':')[1].split(';')[0]
      # write the bytes of the string to a typed array
      ia = new Uint8Array(byteString.length)
      i = 0
      while i < byteString.length
        ia[i] = byteString.charCodeAt(i)
        i++
      new Blob([ ia ], type: mimeString)

    blob = dataURItoBlob dataurl

    # dataURL = canvas.toDataURL('image/jpeg', 0.5)
    # blob = dataURItoBlob(dataURL)
    fd = new FormData(document.forms[0])
    fd.append 'file', blob, 'image.png'
    ScrumBoard.testtest fd
