empty = peripheral.wrap('left')
full = peripheral.wrap('right')

north = 'north'
south = 'south'

for i = 1,16 do turtle.select(i) turtle.dropDown() end
turtle.select(1)
while true do
  repeat
    sleep(0.05)
  until #full.getAllStacks() > 0
  full.condenseItems()
  full.pushItem(south,1)
  turtle.place()
  repeat
    sleep(0.05)
  until turtle.detect()
  turtle.select(2)
  turtle.dig()
  turtle.dropDown()
  turtle.select(1)
  empty.pullItem(north,1)
end
