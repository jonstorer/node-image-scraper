express = require 'express'
http    = require 'http'
path    = require 'path'

Scraper = require './scraper'

app = express()

app.configure ->
  app.set 'port', process.env.PORT || 3000
  app.use express.favicon()
  app.use express.logger('dev')
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(path.join(__dirname, 'public'), 'index.html')

app.configure 'development', ->
  app.use(express.errorHandler())

app.post '/api/v1/scrape', (request, response, next) ->
  scraper = new Scraper(request.body)
  scraper.run (images) ->
    response.send images

http.createServer(app).listen app.get('port'), ->
  console.log("Express server listening on port " + app.get('port'))
