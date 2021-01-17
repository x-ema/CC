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
  peripherals:mount('monitor','mon')
  perihperals:mount('container_ee3_alchemicalchest','chest') --[[prototype used large alchemical chest replace with other chest name if using other]]--
  getAvailableMobs = function (self)
    for _,item in pairs(peripherals:mon
  end,
  
}
