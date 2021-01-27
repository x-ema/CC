--early game turtle quarry concept
local tArgs={...}

local turt = {
  dig = function (self) turtle.digUp(); turtle.dig(); turtle.digDown(); end,
  forward = function (self,num) if not num then num = 1 end; for i = 1,num do turtle.forward() end end,
  
  quarry = function (self,size_x,size_z)
    for x = 1,tonumber(size_x) do
      for z = 1,tonumber(size_z)-1 do
        self:dig()
        turtle.forward()
      end
      turtle.turnLeft()
      turtle.forward()
      turtle.turnLeft()
    end
  end,
}

turt:quarry(16,16)
