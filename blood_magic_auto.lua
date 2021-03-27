in_side = 'WEST'
out_side = 'EAST'
altar = peripheral.wrap('top')
term.clear()
w,h = term.getSize()
local display = 'CC AUTO ALTAR'
term.setCursorPos(w/2-#display/2,h/2)
write(display)
while true do
  item = altar.getStackInSlot(1)
  if item then
    waiting = true
    while waiting do
      if item ~= altar.getStackInSlot(1) then waiting = false end
    end
    altar.pustItem(out_side,1)
  else
    altar.pullItem(in_side,1,1)
  end
end
