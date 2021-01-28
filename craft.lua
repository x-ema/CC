--[[AE autocrafting through turtles]]--
os.loadAPI('rec')

local ae = peripheral.wrap('bottom')


local craft = function(name,qty) --working
  local tslots = {1,2,3,5,6,7,9,10,11}
  turtle.select(1)
  if rec[name] then
    for i = #rec[name],1,-1 do
      ae.extractItem({id = rec[name][i][1],dmg = rec[name][i][2],qty = qty},'up')
      turtle.transferTo(tslots[i])
    end
    turtle.select(4)
    turtle.craft()
    ae.extractItem(4,turtle.getItemCount(4),'up')
  end
end


--[[
ae.extractItem({id=1,dmg=0,qty=0},'up')
ae.insertItem(slot,qty,'up')
ae.containsItemType(id,dmg)
ae.countOfItemType(id,dmg)
]]--
