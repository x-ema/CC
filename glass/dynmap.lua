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
  x_coord = 0,
  y_coord = 0,
  z_coord = 0,
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
  updateCoords = function (self,x,y,z)
    self.x_coord = x
    self.y_coord = y
    self.z_coord = z
  end
  getPlayerData = function (self)
    self.players = {}
    users_raw = http.get(self.url)
    users_raw = users_raw.readAll()
    users_raw = users_raw:gsub('\n','')
    search_start = 1
    while true do
      start,last = users_raw:find('"name":"%a+"',search_start)--"name":"Hitman335"
      if start ~= nil and last ~= nil then
        self.players[#self.players + 1] = peripherals.sen.getPlayerData(users_raw:sub(start + 8,last - 1))
        self.players[#self.players].position.x = self.players[#self.players].position.x + self.x_coord
        self.players[#self.players].position.y = self.players[#self.players].position.y + self.y_coord
        self.players[#self.players].position.z = self.players[#self.players].position.z + self.z_coord
      else 
        break
      end
      search_start = last
    end
  end,

  draw = function (self)
    peripherals.glass.addBox(self.x_pos,self.y_pos,self.x_size * self.scale,self.y_size * self.scale,self.bg,self.opacity) --[[draw map bounding box]]--
    for i = 1,#self.players do
      peripherals.glass.addBox((self.players[i].position.x * self.scale) + ((self.x_size * self.scale) / 2) + self.x_pos,(self.players[i].position.z * self.scale) + ((self.y_size * self.scale) / 2) + self.y_pos,1,1,self.fg,self.opacity)
    end
  end
}

peripherals:mount('openperipheral_glassesbridge','glass') --[[mount glasses bridge]]--
peripherals:mount('openperipheral_sensor','sen')--[[mount sensor]]--
map:updateCoords(4872,67,3592)
map:getPlayerData()
map:draw()


--[[
drawn map size = 120x120
scaler is 1/100th size
'small coords' would be 
-59, -36 + size of map to make it not negative
61, 84
ex coords -4873 -3596
]]--

