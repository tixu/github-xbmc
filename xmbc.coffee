# Configures the plugin
module.exports = (robot) ->
    # waits for the string "hubot deep" to occur
   robot.respond /xbmc toggle sound/i, (msg) -> 
      params={jsonrpc: "2.0", id:"1",method: "Application.SetMute", params: {mute:"toggle"}}
      stringParams = JSON.stringify params
      msg.http('http://192.168.1.100/jsonrpc')
      .post(stringParams) (error, response, body)->
        status = JSON.parse body
        console.log(status)
        switch status.result 
          when true then msg.send "sound is on"
          when false then msg.send "sound is off" 
   robot.respond /xbmc active/i, (msg) -> 
      params={jsonrpc: "2.0", id:"1",method: "Player.GetActivePlayers"}
      stringParams = JSON.stringify params
      msg.http('http://192.168.1.100/jsonrpc')
      .post(stringParams) (error, response, body)->
        status = JSON.parse body
        console.log(status)
        msg.send body 
        
