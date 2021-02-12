listPeripherals = function () --[[Lists all connected peripherals]]--
  for _,location in pairs(peripheral.getNames()) do
    print(location..' : '..peripheral.getType(location))
  end
end

mount = function (peripheral_type) --[[mounts the first connected peripheral that matches the name of peripheral_type, essentially its a copy of modern day peripheral.find]]--
  for _,location in pairs(peripheral.getNames()) do
    if peripheral.getType(location) == peripheral_type then return peripheral.wrap(location) end
  end
  return false
end

yeild = function () os.queueEvent("fakeEvent"); os.pullEvent(); end

