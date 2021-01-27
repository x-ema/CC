local track = {
  sen_pos = {x=4887,y=6,z=3572},
  glass = peripheral.wrap('top'),
  sen = peripheral.wrap('bottom'),
  tracking = 'Sleetyy',
  
  doTrack = function (self)
    sen_data = peripheral.call('bottom','getPlayerData',self.tracking)
    print(sen_data.username)
    print(sen_data.position.x)
    print(sen_data.position.y)
    print(sen_data.position.z)
    
      if data then
        glass.clear()
        glass.addBox(10,10,100,20,0xFFFFFF,0.5)
        glass.addText(15,15,data.username..': x'..data.position.x..' y'..data.position.y..' z'..data.position.z,0xFF1100)
      end
  end,
  
  track = function (self)
    parallel.waitForAny(
      function()
        _,msg,usr = os.pullEvent('chat_command')
        if usr == 'Sleetyy' and #msg > 1 then self.tracking = msg end
      end,
      function()
        sleep(2)
        pcall(self:doTrack())
      end
    )
  end
}

while true do track:track() end
