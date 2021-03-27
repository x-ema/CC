disc = 'Get the fuck out of my code retard'

term.clear()
w,h = term.getSize()
local display = 'CC AUTO ALTAR'
term.setCursorPos(w/2-#display/2,h/2)
write(display)


in_side = 'WEST'
out_side = 'EAST'
altar = peripheral.wrap('top')

function is_item()
  if altar.getAllStacks() == {} then
    return false
  else
    return true
  end
end


while true do
  if is_item() then
    item = altar.getStackInSlot(1).id
    waiting = true
    while waiting do
      if item ~= altar.getStackInSlot(1).id then
        altar.pushItem(out_slot,1)
      else
        sleep(0.5)
      end
    end
  else
    altar.pullItem(in_slot,1,1)
    sleep(0.5)
  end
  sleep(0.5)
end
