sen = peripheral.wrap('back')

function getInventory(name)
  print(textutils.serialize(sen.getPlayerData(name).inventory))
end

--[[add regex's ability to find all matches in a string to lua]]--
function findAll(str,pattern)
  local results = {}
  search_start = 1
  while true do
    start,last = str:find(pattern, search_start)
    if start ~= nil and last ~= nil then
      results.insert({start,last})
      search_start = last
    else return results
    end
  end
end

function getPlayers()
  local dynmap_url = 'http://tekkit.craftersland.net:25800/up/world/world/'
  local dynmap_data = http.get(dynmap_url).readAll()
  local names = findAll(dynmap_data,'"name":"%a+"')
  for i = 1,#names do print(names[i][1]) print(names[i][2]) end
end

getPlayers()
