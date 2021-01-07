glass = peripheral.wrap('back')
sen = peripheral.wrap('top')

function drawItem(x,y,id,dmg)
  local margin = 20
  local bg = 0x404040
  local fg = 0x9e9e9e
  glass.addBox((x * margin) - 1,(y * margin) - 1,margin,margin,bg,1)
  glass.addBox((x * margin) - 1,(y * margin) - 1,margin - 2,margin - 2,bg,1)
  glass.addIcon(x * margin,y * margin,id,dmg)
end

function invsee(sen,player)
  local inventory = sen.getPlayerData(player).inventory
  if not inventory then error('Player does not exist/is not online') end
  row = 5
  column = 1
  for i = 10,36 do --[[Draw main inv]]--
    drawItem(row,column,inventory[i].id,inventory[i].dmg)
    if row == 9 then row = 1 column = column + 1 else row = row + 1 end
  end
  row = 8
  column = 1
  for i = 1,9 do --[[Draw hot bar]]--
    drawItem(row,column,inventory[i].id,inventory[i].dmg)
    row = row + 1
  end
  row = 1
  column = 1
  for i = 37,40 do --[[Draw armor slots]]--
    drawItem(row,column,inventory[i].id,inventory[i].dmg)
    column = column + 1
  end
end
  
while true do
  _,msg,user = os.pullEvent('chat_command')
  if msg:find('invsee') then sen:invsee(msg:gsub('invsee ','')) end
  if msg == 'clear' then glass.clear() end
end
