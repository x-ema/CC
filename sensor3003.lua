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

function getPlayers()
  local dynmap_url = 'http://tekkit.craftersland.net:25800/up/world/world/'
  local dynmap_data = http.get(dynmap_url).readAll()
  local names = findAll(dynmap_data,'"name":"%a+"')
  for x,y in pairs(names) do print(x) print(y) end
end

getPlayers()
