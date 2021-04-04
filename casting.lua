yeild = function () os.queueEvent("fakeEvent"); os.pullEvent(); end

while true do
  for _,location in pairs(peripheral.getNames()) do
    if location:find('peripheral') then
      peripheral.wrap(location).pushItem('down',2)
    end
  end
  yeild()
end
