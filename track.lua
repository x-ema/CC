local peripherals = {
  mount = function (self,peripheral_name)
    for _,p in pairs(peripheral.getNames()) do
      if peripheral.getType(p) == peripheral_name then return peripheral.wrap(p) else return false end
    end
  end
}

local track = {
  sen_pos = {x=4887,y=6,z=3572},
  glass = peripheral.wrap('top'),
  sen = peripheral.wrap('bottom'),
  tracking = '',
  
  track = function (self)
    while true do
      timer = os.startTimer(1)
      e = {os.pullEvent()}
      if e[1] == 'chat_command' then
        if e[3] == 'Sleetyy' and #e[2] > 1 then self.tracking = e[2] end
      elseif e[1] == 'timer' and e[2] == timer then
        data = self.sen.getPlayerData(self.tracking)
        if data then
          glass.clear()
          glass.addBox(10,10,100,20,0xFFFFFF,0.5)
          glass.addText(15,15,data.username..': x'..data.position.x..' y'..data.position.y..' z'..data.position.z,0xFF1100)
        end
      end
    end
  end,
  
  
  trackkkk = function (self)
    if self.tracking ~= '' then
      while true do
        if self.tracking ~= '' then
          data = self.sen.getPlayerData(self.tracking)
          if data ~= nil then
            glass.clear()
            glass.addBox(10,10,100,20,0xFFFFFF,0.5)
            glass.addText(15,15,data.username..': x'..data.position.x..' y'..data.position.y..' z'..data.position.z,0xFF1100)
          end
          sleep(0.5)
        else
          sleep(0.000001)
        end
      end
    end
  end,
  
  cmd = function (self)
    while true do
      _,msg,usr = os.pullEvent('chat_command')
      if usr == 'Sleetyy' and #msg > 1 then self.tracking = msg end
    end
  end
}

track:track()
