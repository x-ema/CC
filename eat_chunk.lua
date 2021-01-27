--early game turtle quarry concept
local tArgs={...}

local turt = {
  dig = function (self) turtle.digUp(); turtle.dig(); turtle.digDown(); end,
  forward = function (self,num) if not num then num = 1 end; for i = 1,num do turtle.forward() end end,
  isEven = function (self,num) if num/2 == math.ceil(num/2) then return true else return false end end,
  
  quarry = function (self,size_x,size_z,y_size)
    for y = 1,tonumber(size_y) do
      for x = 1,tonumber(size_x) do
        for z = 1,tonumber(size_z)-1 do
          self:dig()
          turtle.forward()
        end
        if self:isEven(x) then
          turtle.turnRight()
          turtle.forward()
          self:dig()
          turtle.turnRight()
        else
          turtle.turnLeft()
          turtle.forward()
          self:dig()
          turtle.turnLeft()
        end
      end
      turtle.down()
      turtle.down()
      turtle.down()
    end
  end,
}

turt:quarry(16,16)
