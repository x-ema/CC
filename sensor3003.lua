sen = peripheral.wrap('back')

function getInventory(name)
  print(textutils.serialize(sen.getPlayerData(name).inventory))
end

--[[add regex's ability to find all matches in a string to lua]]--
function findAll(str,pattern)
  str = str:gsub('\n','')
  search_start = 1
  while true do
    start,last = str:find(pattern,search_start)
    if start ~= nil and last ~= nil then
      print(str:sub(start,last))
      search_start = last
    else
      break
    end
  end
end

function getPlayers()
  local dynmap_url = 'http://tekkit.craftersland.net:25800/up/world/world/'
  local dynmap_data = http.get(dynmap_url).readAll()
  local names = findAll(dynmap_data,'"name":"%a+"')
end

getPlayers()
