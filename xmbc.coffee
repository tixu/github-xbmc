# Description:
# Control an xmbc box
# Dependencies:
# None
#
# Commands 
# hubot xmbc toogle sound - toggle the sound of the xmbc box
#
# Author : Xavier Zébier

gettitle = (x, msg) -> 
    
   return body
   
    
module.exports = (robot) ->
    # waits for the string "hubot deep" to occur
   robot.respond /xbmc toggle sound/i, (msg) -> 
      params={jsonrpc: "2.0", id:"1",method: "Application.SetMute", params: {mute:"toggle"}}
      stringParams = JSON.stringify params
      msg.http('http://192.168.1.100/jsonrpc')
      .post(stringParams) (error, response, body)->
        status = JSON.parse body
        switch status.result 
          when true then msg.send "sound is on"
          when false then msg.send "sound is off" 
      

   robot.respond /xbmc active/i, (msg) -> 
      params={jsonrpc: "2.0",id:"1",method: "Player.GetActivePlayers"}
      stringParams = JSON.stringify params
      msg.http('http://192.168.1.100/jsonrpc')
      .post(stringParams) (error, response, body)->
        status = JSON.parse body
        result= status.result[0]
        params = {jsonrpc: "2.0",id:"1",method: "Player.GetItem", params : {"playerid":result["playerid"]}}
        stringParams = JSON.stringify params   
        rresponse = msg.http('http://192.168.1.100/jsonrpc')
         .post(stringParams) (error, response, body) ->
          watching = JSON.parse body
          details = watching.result["item"]
          console.log details
          msg.send  "Audience is  watching an #{details.type} called #{details.label}"
   
   robot.respond /xbmc papl/i, (msg) ->
      params={jsonrpc: "2.0",id:"1",method: "Player.GetActivePlayers"}
      stringParams = JSON.stringify params
      msg.http('http://192.168.1.100/jsonrpc')
      .post(stringParams) (error, response, body)->
        status = JSON.parse body
        result= status.result[0]
        params = {jsonrpc: "2.0",id:"1",method: "Player.PlayPause", params : {"playerid":result["playerid"]}}
        stringParams = JSON.stringify params   
        rresponse = msg.http('http://192.168.1.100/jsonrpc')
          .post(stringParams) (error, response, body) ->
           watching = JSON.parse body
           speed = watching.result["speed"]
           switch speed 
              when 1 then activity="playing"
              when 0 then activity="paused"
              else activity = "undertermined"
           msg.send  "Player is   #{activity}"
   
     	
        
   robot.respond /xbmc listtvshows/i, (msg) ->
          msg.send "about to list tvshow"
