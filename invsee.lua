glass = peripheral.wrap('back')
sen = peripheral.wrap('top')
--glass.addIcon = 16x16
--glass.addIcon(x,y,id,meta)

function getInv(player)
  inventory = sen.getPlayerData(player).inventory
  if inventory ~= nil then return inventory else return false end
end

--[[
inv scructure
slot 1-9 = hotbar
last 4 slots = armor (40,39,38,37)?
]]--
function drawInv(inventory)
  if inventory == false then print('Player does not exist/is not online') end
  liney = 5
  linex = 1
  inv_margin = 20
  inv_bg = 0x404040
  inv_fg = 0x9e9e9e
  for i = 10,36 do --[[draw main body of inventory]]--
    glass.addBox(linex * inv_margin,liney * inv_margin,inv_margin,inv_margin,inv_bg,1)
    glass.addBox(linex * inv_margin,liney * inv_margin,inv_margin-2,inv_margin-2,inv_fg,1)
    glass.addIcon(linex * inv_margin,liney * inv_margin,inventory[i].id,inventory[i].dmg)
    if linex == 9 then linex = 1 liney = liney + 1 else linex = linex + 1 end
  end
  liney = 8
  linex = 1
  for i = 1,9 do --[[draw the hotbar at the bottom of gui]]--
    glass.addBox(linex * inv_margin,liney * inv_margin,inv_margin,inv_margin,inv_bg,1)
    glass.addBox(linex * inv_margin,liney * inv_margin,inv_margin-2,inv_margin-2,inv_fg,1)
    glass.addIcon(linex * inv_margin,liney * inv_margin,inventory[i].id,inventory[i].dmg)
    linex = linex + 1
  end
  linex = 1
  liney = 1
  for i = 37,40 do --[[draw armor slots to right of gui]]--
    glass.addBox(linex * inv_margin,liney * inv_margin,inv_margin,inv_margin,inv_bg,1)
    glass.addBox(linex * inv_margin,liney * inv_margin,inv_margin-2,inv_margin-2,inv_fg,1)
    glass.addIcon(linex * inv_margin,liney * inv_margin,inventory[i].id,inventory[i].dmg)
    liney = liney + 1
  end
end



while true do
  _,msg,user = os.pullEvent('chat_command')
  if msg:find('invsee') then drawInv(getInv(msg:gsub('invsee ',''))) end
  if msg == 'clear' then glass.clear() end
end
