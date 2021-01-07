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
  x_size = 12000,
  y_size = 12000,--drawn map is 120x120
  x_pos = 10,
  y_pos = 10,
  scale = 0.01,
  bg = 0x000000,
  fg = 0xFFFFFF,
  text_color = 0xFFFFFF,
  opacity = 0.5,
  url = 'http://tekkit.craftersland.net:25800/up/world/world/',
  players={},
 
  getPlayerData = function (self)
    users_raw = http.get(self.url)
    users_raw = users_raw.readAll()
    users_raw = users_raw:gsub('\n','')
    search_start = 1
    while true do
      start,last = users_raw:find('"name":"%a+"',search_start)--"name":"Hitman335"
      if start ~= nil and last ~= nil then
        self:addPlayer(users_raw:sub(start + 8,last - 1))
        self.players[#self.players + 1] = peripherals.sen.getPlayerData(users_raw:sub(start + 8,last - 1))
      else 
        break
      end
      search_start = last
    end
  end,

  draw = function (self)
    peripherals.glass.addBox(self.x_pos,self.y_pos,self.x_size * self.scale,self.y_size * self.scale,self.bg,self.opacity) --[[draw map bounding box]]--
    for i = 1,#self.players do
      peripherals.glass.addBox(self.x_pos + math.ceil(self.players[i].position.x * self.scale),self.y_pos + math.ceil(self.players[i].position.y * self.scale),1,1,self.fg,self.opacity)
    end
  end
}

peripherals:mount('openperipheral_glassesbridge','glass') --[[mount glasses bridge]]--
peripherals:mount('openperipheral_sensor','sen')--[[mount sensor]]--
map:getPlayerData()
map:draw()




t






--[[
function findAll(str,pattern,repl)
  result = {}
  search_start = 1
  str = str:gsub('\n','')
  while true do
    start,last = str:find(pattern,search_start)
    if start ~= nil and last ~= nil then
      result[#result+1] = str:sub(start,last)
      if repl then
        for _,filt in pairs(repl) do
          result[#result] = result[#result]:gsub(filt,'')
        end
      end
      search_start = last
    else
      return result
    end
  end
end

]]--
--[[list players on dynmap, players not on dynmap will have to be searched manually]]--
--[[
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
]]--
