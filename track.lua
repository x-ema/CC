local peripherals = {
  mount = function (self,peripheral_name)
    for _,p in pairs(peripheral.getNames()) do
      if peripheral.getType(p) == peripheral_name then return peripheral.wrap(p) break else return false break end
    end
  end
}

local track = {
  sen_pos = {x=4887,y=6,z=3572}
  glass = peripherals:mount('openperipherals_glassesbridge')
  sen = peripherals:mount('openperipherals_sensor')
  tracking = ''
  
  track = function (self)
    if self.tracking ~= '' then
      while true do
        data = self.sen.getPlayerData(name)
        print(data.position.x + self.sen_pos.x)
        print(data.position.y + self.sen_pos.y)
        print(data.position.z + self.sen_pos.z)
      end
    end
  end
}

track:track()

--[[
args = {...}
args[1] = 4887
args[2] = 6
args[3] = 3572
if not args[1] or not args[2] or not args[3] then error('usage sensor3003.lua <x> <y> <z>') end
sen = peripheral.wrap('bottom')
glass = peripheral.wrap('top')
glass = glass.getUserSurface('Sleetyy')
scale = 1

function getInventory(name)
  print(textutils.serialize(sen.getPlayerData(name).inventory))
end

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

function getPlayerData(extra_players)
  infolist = {}
  local dynmap_url = 'http://tekkit.craftersland.net:25800/up/world/world/'
  local dynmap_data = http.get(dynmap_url).readAll()
  local names = findAll(dynmap_data,'"name":"%a+"',{'"','name:'})
  for _,name in pairs(extra_players) do names[#names+1] = name end
  for _,name in pairs(names) do
    local playerdata = sen.getPlayerData(name)
    if playerdata ~= nil then infolist[#infolist+1] = playerdata end
  end
  return infolist
end

function writeToScreen(data)
  maxwidth = 10000
  glass.addBox(1,1,maxwidth,#data*10 + 10,1,0.5)
  for _,info in pairs(data) do
    glass.addText(5,_*10,info,0xFF1100)
  end
end
tab = {
    'ashtrunks14',
    'cunningham529',
    'Dev2150',
    'Discordant_Drake',
    'Markulus22',
    'N3gynka',
    'Naddybo',
    'Wickedartemis',
    'Zilexon',
    'Znk97',
    'iim_wolf',
    'mikewerf',
    'brunyman',
    'Joaspa075',
    'Vratko_1337',
    'VulcanBro',
    'king_of_riots',
  'iTzMartiin',
  'Julebakst420',
  'WAP_99',
  'TwIsTeD_cS',
  'manticclaw22',
  'CoffeShop420',
  'falconpunch1880',
  '__toab',
  'Brxxkes',
  'Baldur_7',
  'Vorb01',
  'Fr44nky',
  'masterobo222',
  'Bxdwell',
  'UwU_4_Me_Daddy',
  'fufelini',
  'Acrillx',
  'WH33LS7789',
  'F1LTHYP3ASANT',
  'Duxi_69'
}
while true do
  x = getPlayerData(tab)
  term.clear()
  writeable_data = {}
  for _,z in pairs(x) do
    str = z.username..' --- X:'..math.ceil(z.position.x+args[1])..' Y:'..math.ceil(z.position.y+args[2])..' Z:'..math.ceil(z.position.z+args[3])
    writeable_data[#writeable_data+1] = str
  end
  glass.clear()
  writeToScreen(writeable_data)
  sleep(1)
end
]]--
