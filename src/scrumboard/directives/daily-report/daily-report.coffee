angular.module '%module%.scrumboard'
.factory 'DailyReport',
($http, $state, storage, trello) ->
  putCardAtTopPosition = (cardId) ->
    return unless cardId
    $http
      method: 'put'
      url: trello.apiUrl + '/cards/' + cardId + '/pos'
      headers:
        'Content-Type': undefined
      params:
        key: trello.applicationKey
        token: storage.token
        value: 'top'
    .then (res) ->
      res.data

  # using same data as BurnDown chart
  createDailyDesc = (data) ->
    return unless data
    totalDone = 0
    diff = 0
    for day in data
      totalDone += day.done
      diff = day.diff if day.diff
    dailyReport = 'DONE : ' + totalDone.toFixed(1) + ' pts\n'
    if diff > 0
      dailyReport += 'AVANCE : '
    else
      dailyReport += 'RETARD : '
    dailyReport += diff.toFixed(1) + ' pts\n'
    dailyReport

  createDailyReportCard = (columnId, dailyReportDesc) ->
    today = new Date()
    $http
      method: 'post'
      url: trello.apiUrl + '/lists/' + '54c3ab771249457153f6d357' + '/cards'
      headers:
        'Content-Type': undefined
      params:
        key: trello.applicationKey
        token: storage.token
        name: '-- Daily Report ' + today.toLocaleDateString() + ' --'
        desc: dailyReportDesc
    .then (res) ->
      res.data

  postGraphToTrello = (cardId, formData) ->
    return unless cardId
    uploadUrl = trello.apiUrl + '/cards/' + cardId + '/attachments'
    today = new Date()
    $http.post uploadUrl, formData, {
        transformRequest: angular.identity,
        headers: 'Content-Type': undefined
        params:
          key: trello.applicationKey
          token: storage.token
          name: 'BurnDown Chart - ' + today.toLocaleDateString()
          mimeType: 'image/png'
    }
    .then (res) ->
      res.data

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


  getFormDataFromSvg = (svg) ->
    img = new Image()
    serializer = new XMLSerializer()
    svgStr = serializer.serializeToString(svg)
    img.src = 'data:image/svg+xml;base64,' + window.btoa(svgStr)

    canvas = document.createElement 'canvas'
    document.body.appendChild canvas
    width = 400
    height = 200
    canvas.width = width
    canvas.height = height
    canvas.getContext '2d'
    .drawImage img,0,0,width,height
    dataurl = canvas.toDataURL 'image/png'

    blob = dataURItoBlob dataurl

    fd = new FormData document.forms[0]
    fd.append 'file', blob, 'image.png'
    fd

  getFormDataFromSvg: getFormDataFromSvg
  postGraphToTrello: postGraphToTrello
  createDailyReportCard: createDailyReportCard
  createDailyDesc: createDailyDesc
  putCardAtTopPosition: putCardAtTopPosition
