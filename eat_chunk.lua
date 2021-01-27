--early game turtle quarry concept

local turt = {
  dig = function (self) turtle.digUp() turtle.dig() turtle.digDown() end,
  forward = function (self,num) for i = 1,num do turtle.forward() end end,
  
  
}
