--[[
Requires:
1 mining turtle
2 ender chests (one for full lava buckets one for the return of obby and empty buckets)
1 water source
1 activator if you want it to run all the time
]]--
local obby_mined = 0
local w,h = term.getSize()
for i = 1,16 do turtle.select(i) turtle.dropDown() end turtle.select(1)
while true do
  turtle.suckUp()
  turtle.place()
  turtle.select(2)
  turtle.dig()
  turtle.dropDown()
  turtle.select(1)
  turtle.dropDown()
  obby_mined = obby_mined + 1
  term.clear()
  local printstr = obby_mined..' obsidian mined.'
  cursor.setPos((w/2) - (#printstr/2),h/2)
end
