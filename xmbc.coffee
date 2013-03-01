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
   param2s = {jsonrpc: "2.0",id:"1",method: "Player.GetItem", params : {"playerid":x["playerid"]}}
   stringParams = JSON.stringify param2s   
   console.log param2s  
   msg.http('http://192.168.1.100/jsonrpc')
   .post(stringParams) (error, response, body) ->
    console.log error
    console.log body
	
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
      params={jsonrpc: "2.0",id:"1",method: "Player.GetActivePlayers"}
      stringParams = JSON.stringify params
      msg.http('http://192.168.1.100/jsonrpc')
      .post(stringParams) (error, response, body)->
        status = JSON.parse body
        console.log status
        result= status.result[0]
        console.log result["playerid"];
        gettitle   result,msg
        msg.send status.result.playerid 
        
 
