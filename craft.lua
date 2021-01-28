--[[AE autocrafting through turtles]]--
os.loadAPI('rec')

ae = peripheral.wrap('bottom')

craft = function(id,dmg,qty)

end
ae.extractItem({id=1,dmg=0,qty=0},'up')
ae.insertItem(slot,qty,'up')
ae.containsItemType(id,dmg)
ae.countOfItemType(id,dmg)
