local peripherals = {
  mount = function (self,peripheral_name)
    for _,p in pairs(peripheral.getNames()) do
      if peripheral.getType(p) == peripheral_name then return peripheral.wrap(p) break else return false break end
    end
  end
}

local map = {
  auth_list = {'Sleetyy'},
  sensor_x,sensor_y,sensor_z = 0,0,0,
  map_x,map_y = 12000,12000,
  offset_x,offset_y = 10,10,
  margin = 10,
  scale = 1/100,
  colors = {
    background = 0x000000,
    foreground = 0xFFFFFF,
    text = 0xFFFFFF
  },
  opacity = 0.5,
  map_url = 'http://tekkit.craftersland.net:25800/up/world/world/',
  players = {},
  sensor = peripherals:mount('openperipheral_sensor')
  setSensorCoords = function (self,x,y,z) self.sensor_x,self.sensor_y,self.sensor_z = x,y,z end,
  
  updatePlayers = function (self)
    self.players = {},
    json_players = http.get(self.map_url).readAll():gsub('\n','')
    search_start = 1
    while true do
      start,last = json_players:find('"name":"%a+"',search_start)
      if start ~= nil and last ~= nil then
        self.players[#self.players + 1] = sensor.getPlayerData(json_players:sub(start + 8,last - 1))
        self.players[#self.players].position.x = self.players[#self.players].position.x + self.x_coord
        self.players[#self.players].position.y = self.players[#self.players].position.y + self.y_coord
        self.players[#self.players].position.z = self.players[#self.players].position.z + self.z_coord
        search_start = last
      else break
      end
    end
  end,
}








--[[
local map = {
  x_coord = 0,
  y_coord = 0,
  z_coord = 0,
  x_size = 12000,
  y_size = 12000,--drawn map is 120x120
  x_pos = 10,
  y_pos = 10,
  margin = 10,
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
  end,
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
    peripherals.glass.addBox(self.x_pos,self.y_pos,self.x_size * self.scale,self.y_size * self.scale,self.bg,self.opacity) --draw map bounding box
    for i = 1,#self.players do
      peripherals.glass.addBox((self.players[i].position.x * -1 * self.scale) + ((self.x_size * self.scale) / 2) + self.x_pos,(self.players[i].position.z * -1 * self.scale) + ((self.y_size * self.scale) / 2) + self.y_pos,1,1,self.fg,self.opacity)
    end
  end,
  
  track = function (self,username)
    player = peripherals.sen.getPlayerData(username)
    display_str = player.username..' X:'..player.position.x + self.x_coord..' Y:'..player.position.y + self.y_coord..' Z:'..player.position.z + self.z_coord
    peripherals.glass.addBox(self.scale * self.x_size + self.margin,self.scale * self.y_size + self.margin,peripherals.glass.getStringWidth(display_str) + self.margin,10,self.fg,self.opacity)
    peripherals.glass.addText(self.scale * self.x_size + self.margin,self.scale * self.y_size + self.margin,display_str,self.fg)
  end
}
--[[GLASS PLUGIN STANDARD DEFINITIONS
local commands = {
  init = function (self)
    peripherals:mount('openperipheral_glassesbridge','glass')
    peripherals:mount('openperipheral_sensor','sen')
  end,
  highlight = {
    cmd = 'highlight',
    func = function (self)
      print('hello world')
    end
  }
}
--[[GLASS PLUGIN STANDARD DEFINITIONS
while true do
  commands:init()
  map:updateCoords(4872,67,3592)
  map:getPlayerData()
  peripherals.glass.clear()
  map:draw()
  map:track('Sleetyy')
end
]]--
