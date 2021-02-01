--[[AIO script for PK]]--
os.loadAPI('sha256')
local sen_pos = {x=4887,y=6,z=3572}
local user = '6acd7cbdda8356a0d0f6df82f0f52308786c6fbcfa1b14499e563bb34637fb79'
local omit_cl_staff = {'brunyman','DragonSlayer','iim_wolf','eytixis','mikewerf'}

local draw_inv = false
local draw_coords = false
local draw_minimap = false
local last_inv = ''
local last_track = ''


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

track = function(player)
  print('coords of '..player)
end

minimap = function()
  print('showing mini')
end

parallel.waitForAny(
  function()
    _,msg,usr = os.pullEvent('chat_command')
    if sha256.sha256(usr) == user then
      if msg:find('invsee ') then
        last_inv = msg:sub(7,#msg)
      elseif msg:find('track ') then
        last_track = msg:sub(6,#msg)
      elseif msg:find('minimap') then
        minimap()
      elseif msg == 'toggle invsee' then
        if draw_inv == true then draw_inv = false else draw_inv = true end
      elseif msg == 'toggle coords' then
        if draw_coords == true then draw_coords = false else draw_coords = true end
      elseif msg == 'toggle minimap' then
        if draw_minimap == true then draw_minimap = false else draw_minimap = true end
      end
    end
  end,
  function()
    sleep(0.25)
    if draw_inv then invsee(last_inv) end
    if draw_coords then track(last_track) end
    if draw_minimap then minimap() end
  end
)

