
term.clear()
w,h = term.getSize()
local display = 'CC AUTO ALTAR'
term.setCursorPos(w/2-#display/2,h/2)
write(display)


in_side = 'WEST'
out_side = 'EAST'
altar = peripheral.wrap('top')




while true do
  item_id = altar.getStackInSlot(1).id
  if item_id ~= "" then
    waiting = true
    while waiting do
      if item_id == altar.getStackInSlot(1).id then
        altar.pushItem(out_side,1)
      else
        sleep(0.5)
      end
    end
  else
    altar.pullItem(in_side,1,1)
    sleep(0.5)
  end
end
