--[[Control an autospawner with a computer connected to monitors for a touch interface]]--

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

local spawner = {
  spawning = ''
  available = {}
  peripherals:mount('monitor','mon'),
  perihperals:mount('container_ee3_alchemicalchest','chest'), --[[prototype used large alchemical chest replace with other chest name if using other]]--
  condense = function (self) peripherals.chest.condenseItems() end,
  getAvailableMobs = function (self)
    self.available = {}
    self.condense()
    for _,item in pairs(peripherals.chest.getAllStacks()) do
      self.available[#self.available + 1] = item.captured
    end
  end,
  isAvailable = function (self,mob_name)
    for _,mob in pairs(self.available) do
      if mob == mob_name do return end
    end
    return false
  end,
  switchNet = function (self,tospawn)
    avail = self.isAvailable(tospawn)
    if avail then
      peripherals.chest.pullItem('up',1)
      peripherals.chest.pushItem('up',avail)
    end
  end,
  removeNet = function (self) peripherals.chest.pullItem('up',1) end
}
