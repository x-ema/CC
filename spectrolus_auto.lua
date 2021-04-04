detector = 'front'
placer = 'bottom' 
breaker = 'back'
chest = peripheral.find('chest')
direction = 'EAST'

local pulse = function(side)
  rs.setOutput(side,true)
  sleep(0.1)
  rs.setOutput(side,false)
end

local move_color = function()

pulse(placer)

os.pullEvent('redstone')
