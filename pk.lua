--[[AIO script for PK]]--
local sen_pos = {x=4887,y=6,z=3572}
local user = '6acd7cbdda8356a0d0f6df82f0f52308786c6fbcfa1b14499e563bb34637fb79'
local omit_cl_staff = {'brunyman','DragonSlayer','iim_wolf','eytixis','mikewerf'}

local draw_inv = false
local draw_coords = false
local draw_minimap = false


mount = function (peripheral_type) --[[mounts the first connected peripheral that matches the name of peripheral_type, essentially its a copy of modern day peripheral.find]]--
  for _,location in pairs(peripheral.getNames()) do
    if peripheral.getType(location) == peripheral_type then return peripheral.wrap(location) end
  end
  return false
end

glass = mount('openperipheral_glassesbridge')
sen = mount('openperipheral_sensor')
for _,usr in pairs(peripheral.call('top','getUsers')) do
  if sha256.sha256(usr) == usr then glass = glass.getUserSurace(usr) end
end

if not glass then error(user..' not found') end

invsee = function(player)
  print('invsee '..player)
end

coords = function(player)
  print('coords of '..player)
end

minimap = function()
  print('showing mini')
end

parallel.waitForAny(
  function()
    _,msg,usr = os.pullEvent('chat_command')
    if sha256.sha256(usr) == user then
      if x:find('invsee ') then
        invsee(x:sub(7,#x))
      elseif x:find('track ') then
        track(x:sub(6,#x))
      elseif x:find('minimap') then
        minimap()
      end
    end
  end
)

