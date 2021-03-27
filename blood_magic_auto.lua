disc = 'Get the fuck out of my code retard'

term.clear()
w,h = term.getSize()
local display = 'CC AUTO ALTAR'
term.setCursorPos(w/2-#display/2,h/2)
write(display)


in_side = 'WEST'
out_side = 'EAST'
altar = peripheral.wrap('top')

function get_item()
  if #altar.getAllStacks() > 0 then
    return altar.getStackInSlot(1).id
  else
    return false
  end
end


while true do
  if get_item() ~= false then
    item = get_item()
    if item then
      waiting = true
      while waiting do
        if item ~= altar.getStackInSlot(1).id then
          altar.pushItem(out_side,1)
          waiting = false
          sleep(0.5)
        else
          sleep(0.5)
        end
      end
    end
  else
    altar.pullItem(in_side,1,1)
    sleep(0.5)
  end
end
