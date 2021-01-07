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
      peripherals.glass.addBox(self.x_pos + math.ceil((self.players[i].position.x + (self.x_size / 2)) * self.scale),self.y_pos+ math.ceil((self.players[i].position.y + (self.y_size / 2)) * self.scale),1,1,self.fg,self.opacity)
    end
  end
}

peripherals:mount('openperipheral_glassesbridge','glass') --[[mount glasses bridge]]--
peripherals:mount('openperipheral_sensor','sen')--[[mount sensor]]--
map:getPlayerData()
map:draw()



