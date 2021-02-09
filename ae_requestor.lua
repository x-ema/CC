local direction = 'west'
local mount = function (peripheral_type) --[[mounts the first connected peripheral that matches the name of peripheral_type, essentially its a copy of modern day peripheral.find]]--
  for _,location in pairs(peripheral.getNames()) do
    if peripheral.getType(location) == peripheral_type then return peripheral.wrap(location) end
  end
  return false
end

local chest = mount('container_chest')
local ae = mount('me_interface')

term.clear()
while true do
  chest.condenseItems()
  for _,item in pairs(chest.getAllStacks()) do
    if ae.countOfItemType(item.id,item.dmg) >= item.qty then
      ae.extractItem({id=item.id,dmg=item.dmg,qty=item.qty},direction)
    elseif ae.countOfItemType(item.id,item.dmg) > 0 and ae.countOfItemType(item.id,item.dmg) < item.qty then
      ae.extractItem({id=item.id,dmg=item.dmg,qty=ae.countOfItemType(item.id,item.qty)},direction)
    end
  end
  sleep(0.00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001)
end
