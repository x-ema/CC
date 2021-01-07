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
 url = 'http://tekkit.craftersland.net:25800/up/world/world/',
 players={},
 addPlayer = function (self,name)
  self.players[name] = peripherals.sen.getPlayerData(name)
 end
 getPlayerData = Function (self)
  local users = http.get(self.url).readAll())
  local users = 
 end
}

peripherals:mount('openperipheral_glassesbridge','glass') --[[mount glasses bridge]]--
peripherals:mount('openperipheral_sensor','sen')--[[mount sensor]]--


--[[list players on dynmap, players not on dynmap will have to be searched manually]]--
function getPlayerData(extra_players)
  infolist = {}
  local dynmap_url = 
  local dynmap_data = http.get(dynmap_url).readAll()
  local names = findAll(dynmap_data,'"name":"%a+"',{'"','name:'})
  for _,name in pairs(extra_players) do names[#names+1] = name end
  for _,name in pairs(names) do
    local playerdata = sen.getPlayerData(name)
    if playerdata ~= nil then infolist[#infolist+1] = playerdata end
  end
  return infolist
end
