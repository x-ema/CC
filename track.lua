local sen_pos = {x=4887,y=6,z=3572}
local glass = peripheral.call('top','getUserSurface','Sleetyy')
local tracking = 'Sleetyy'
while true do
  parallel.waitForAny(
    function()
      _,msg,usr = os.pullEvent('chat_command')
      if usr == 'Sleetyy' then tracking = msg end
      print(usr..' : '..msg)
    end,
    function()
      sleep(2)
      data = peripheral.call('bottom','getPlayerData',tracking)
      if data then
        glass.clear()
        glass.addBox(10,10,1000,25,0xFFFFFF,0.5)
        glass.addText(15,15,data.username..': x '..math.ceil(data.position.x+sen_pos.x)..' y '..math.ceil(data.position.y+sen_pos.y)..' z '..math.ceil(data.position.z+sen_pos.z),0xFF1100)
        print(data.position.x)
        print(data.position.y)
        print(data.position.z)
        print(data.username)
      else
        glass.clear()
        glass.addBox(10,10,1000,25,0xFFFFFF,0.5)
        glass.addText(15,15,'Player not available...',0xFF1100)
      end
    end
  )
end
