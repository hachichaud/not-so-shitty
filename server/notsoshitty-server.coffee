express = require 'express'

app = express()

app.get '/data/:type', (req, res) ->
  res.json require './data-' + req.param('type') + '.json'

app.listen 3333, ->
  console.log 'Not so shitty api listening 3333'
