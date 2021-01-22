--[[Cell goes on the right of the pc]]--
power_mon = {
  timer_len = (1/1),
  cell = peripheral.wrap('right'),
  work = function (self,pwr)
    pwr_text = ((pwr - self.last_power) / self.timer_len)
    self.last_power = pwr
    return pwr_text
  end,
  main = function (self)
    self.last_power = self.cell.getenergyStored('right')
    term.clear()
    term.setCursorPos(1,1)
    while true do
      self:work()
      os.startTimer(timer_len)
      os.pullEvent('timer')
    end
  end,
}

power_mon:main()
