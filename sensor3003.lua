dynmap_url = 'http://tekkit.craftersland.net:25800/up/world/world/'
sen = peripheral.wrap('back')
sen.getPlayerData(name)

function getInventory(name)
  print(textutils.serialize(sen.getPlayerData(name).inventory))
end
