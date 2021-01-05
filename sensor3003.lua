sen = peripheral.wrap('back')

function getInventory(name)
  print(textutils.serialize(sen.getPlayerData(name).inventory))
end

function getPlayers()
  local dynmap_url = 'http://tekkit.craftersland.net:25800/up/world/world/'
  local dynmap_data = json.decode(http.get(dynmap_url).readAll())
  local names = dynmap_data:gmatch('"name":"%a+"')
  print(names)
end

getPlayers()
