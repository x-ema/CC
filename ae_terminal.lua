--remote access term for lua using glasses
--[[START essentials methods]]--
mount = function (peripheral_type)
  for _,location in pairs(peripheral.getNames()) do
    if peripheral.getType(location) == peripheral_type then return peripheral.wrap(location) end
  end
  return false
end
yeild = function () os.queueEvent("fakeEvent"); os.pullEvent(); end
--[[END essentials methods]]--

local glass = mount('openperipheral_glassesbridge')
local ae = mount('appeng_me_tilecolorlesscable')

local display_resolution = {x=16,y=9,pix_count = x*y}

local getPages = function () return (ae.getStoredItemTypes() / (display_resolution.x * display_resolution.y)) end
local drawPage = function (page) --drawn item display will be 16x9
  page = page * display_resolution.pix_count
  local items = ae.getAvailableItems()
  for i = page - display_resolution.pix_count,page do
    glass.addIcon(x,y,items[i].id,items[i].dmg,1)
    --draw items by rows
  end
end


--[[
canHoldNewItem(), containsItemType(itemId,dmgValue), countOfItemType(itemId,dmgValue), extractItem(stack,direction), getAdvancedMethodsData(), getAvailableItems(), getFreeBytes(), getPreformattedItems(), getPriority(), getRemainingItemCount(), getRemainingItemTypes(), getStoredItemCount(), getStoredItemTypes(), getTotalBytes(), getTotalItemTypes(), getUnusedBytes(), getUnusedItemCount(), insertItem(slot,amount,direction), isFuzzyPreformatted(), isPreformatted(), listMethods(), requestCrafting(stack)
]]--
