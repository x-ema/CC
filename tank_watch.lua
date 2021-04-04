local dir = 'EAST'
tank = peripheral.wrap('back')
while true do
  local before = tank.getTankInfo(dir)[1].contents.amount
  sleep(15)
  local after = tank.getTankInfo(dir)[1].contents.amount
  local speed = (before-after)/15
  term.clear()
  term.setCursorPos(1,1)
  print(speed..' mb/s')
end
