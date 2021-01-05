args = {...}
if not args[1] or not args[2] or not args[3] then error('usage sensor3003.lua <x> <y> <z>')
sen = peripheral.wrap('back')

function getInventory(name)
  print(textutils.serialize(sen.getPlayerData(name).inventory))
end

--[[add regex's ability to find all matches in a string to lua]]--
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

--[[list players on dynmap, players not on dynmap will have to be searched manually]]--
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
    
while true do
  x = getPlayerData({'Sleetyy'})
  term.clear()
  for _,z in pairs(x) do
        print('Username: '..z.username..' @ X:'..z.position.x+args[1]..'Y:'..z.position.y+args[2]..'Z:'..z.position.z+args[3])
  end
  sleep(1)
end
