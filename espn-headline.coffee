# Description:
#   Grab a headline from ESPN through querying hubot
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   espn - Displays a random headline from ESPN.com
#
# Author:
#   mike wilcox

module.exports = (robot) ->
  robot.respond /espn/i, (msg) ->
    search = escape(msg.match[1])
    msg.http('http://api.espn.com/v1/sports/news/headlines?apikey=<YOUR ESPN API KEY>')
      .get() (err, res, body) ->
        result = JSON.parse(body)

        if result.headlines.count <= 0
          msg.send "Couldn't find any headlines"
          return
        
        urls = [ ]
        for child in result.headlines
          urls.push(child.headline)
          
        rnd = Math.floor(Math.random()*urls.length)
        msg.send urls[rnd]
