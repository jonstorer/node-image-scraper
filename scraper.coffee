request = require 'request'
cheerio = require 'cheerio'
sugar   = require 'sugar'

class Scraper
  constructor: (@params) ->

  run: (next) ->

    request { uri: @params.url }, (error, response, body) ->
      if (error && response.statusCode != 200)
        console.log('Request error.')

      $ = cheerio.load(body)

      images = $('img').map (i, el) ->
        $(el).attr('src')

      images = images.exclude (image) ->
        image.match(new RegExp(/icon/))

      next(images.unique())

module.exports = Scraper
