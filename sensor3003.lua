sen = peripheral.wrap('back')

function getInventory(name)
  print(textutils.serialize(sen.getPlayerData(name).inventory))
end

--[[add regex's ability to find all matches in a string to lua]]--
function findAll(str,pattern,repl)
  results = {}
  results_tab = {}
  search_start = 1
  while true do
    start,last = str:find(pattern, search_start)
    if start ~= nil and last ~= nil then
      results_tab.insert({start,last})
      search_start = last
    else
      if repl == nil then
        for i = 1,#results_tab do
          results[#results+1] = str:sub(results[i][1],results[i][2])
        end
      else
        for i = 1,#results_tab do
          results[#results+1] = str:sub(results[i][1],results[i][2])
          for _ in repl do
            results[#results] = results[#results]:gsub(repl[_],'')
          end
        end
      end
    end
  end
end

function getPlayers()
  local dynmap_url = 'http://tekkit.craftersland.net:25800/up/world/world/'
  local dynmap_data = http.get(dynmap_url).readAll()
  local names = findAll(dynmap_data,'"name":"%a+"',{'"','name:'})
  for _,name in names do print(name) end
end

getPlayers()
