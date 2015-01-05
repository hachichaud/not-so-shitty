express = require 'express'
serveStatic = require 'serve-static'
httpProxy = require 'http-proxy'


proxy = httpProxy.createProxyServer {}
app = express()

app.use '/api', (req, res) ->
  proxy.proxyRequest req, res,
    target:
      host: 'localhost'
      port: 3333

app.use '/', serveStatic 'www'

server = app.listen 8000, ->
  host = server.address().address
  port = server.address().port

  console.log 'App listening at http://%s:%s', host, port
