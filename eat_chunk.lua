--early game turtle quarry concept
local tArgs={...}

local turt = {
  chest = 1
  dig = function (self) turtle.digUp(); turtle.dig(); turtle.digDown(); end,
  forward = function (self,num) if not num then num = 1 end; for i = 1,num do turtle.forward() end end,
  isEven = function (self,num) if num/2 == math.ceil(num/2) then return true else return false end end,
  
  wellMine = function (self)
    dwn = 0
    while true do
      turtle.dig()
      turtle.digDown()
      if not turtle.down() then break else dwn = dwn + 1 end
    end
    for i = 1,dwn do turtle.up() end
    turtle.select(1)
    for i = 2,16 do turtle.dropUp() end
  end,
}

for i = 1,8 do
  turt:wellMine()
  turtle.forward()
  turtle.forward()
end
