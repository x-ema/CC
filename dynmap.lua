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

local map = {
 map_x = 12000,
 map_y = 12000,
 map_scale = 0.5,
 players={},
 addPlayer = function (self,name)
  self.players[name] = peripherals.sen.getPlayerData(name)
 end
}

peripherals:mount('openperipheral_glassesbridge','glass') --[[mount glasses bridge]]--
peripherals:mount('openperipheral_sensor','sen')--[[mount sensor]]--
