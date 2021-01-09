--[[requires sensor turtle]]--
local peripherals = {
 --[[usage peripherals:mount(<periperal_type>,<var_name>)]]--
 --[[ex, peripherals:mount('monitor','mon')]]--
  mount = function (self,p_type,name) 
    for _,p in pairs(peripheral.getNames()) do
      if peripheral.getType(p) == p_type then
        self[name] = peripheral.wrap(p)
      end
    end
  end
}

elevator = {
  x_max = 1.7,
  x_min = (-3.7),
  z_max = 1.7,
  z_min = (-3.7),
  authorized_users = {
    'Sleetyy',
    'ZeeDerpMaster'
  },
  main = function (self)
    pos = sen.GetPlayerData(sen.getPlayerNames[1]).position
    if pos.x >= self.x_min and pos.x <= self.x_max and pos.z >= self.z_min and pos.z <= self.z_max then
      redstone.setOutput('bottom',true)
      turtle.dropUp()
      sleep(1)
      turtle.suckUp()
      redstone.setOutput('bottom',false)
    end
  end
}

peripherals:mount('right','sen')
