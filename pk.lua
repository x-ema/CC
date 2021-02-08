--[[AIO script for PK]]--
os.loadAPI('sha256')
local sen_pos = {x=4887,y=6,z=3572}
local user = '6acd7cbdda8356a0d0f6df82f0f52308786c6fbcfa1b14499e563bb34637fb79'
local omit_cl_staff = {'brunyman','DragonSlayer','iim_wolf','eytixis','mikewerf'}
local refresh_rate = (1/60)
local mount = function (peripheral_type)
  for _,location in pairs(peripheral.getNames()) do
    if peripheral.getType(location) == peripheral_type then return peripheral.wrap(location) end
  end
  return false
end

local sen = mount('openperipheral_sensor')
local glass = mount('openperipheral_glassesbridge')
for _,usr in pairs(glass.getUsers()) do if sha256.sha256(usr) == usr then glass = glass.getUserSurace(usr) end end
if not glass then os.reboot() end

local invsee = {
  enabled = false,
  player = ''
}
local track = {
  enabled = false,
  player = ''
}

while true do
  
  parallel.waitForAny(
    function() --listener for chat commands
      _,msg,usr = os.pullEvent('chat_command')
      if sha256.sha256(usr) == user then
        if msg:find('toggle invsee') then --terrible cmd find if then statement
          if invsee.enabled then invsee.enabled = false else invsee.enabled = true end
        elseif msg:find('toggle tracker') then
          if track.enabled then track.enabled = false else track.enabled = true end
        elseif msg:find('track ') then
          track.player = msg:sub(6,#msg)
        elseif msg:find('invsee ') then
          invsee.player = msg:sub(7,#msg)
        end
      end
    end,
    function() --tracker function
      sleep(refresh_rate)
      for _,usr in pairs(glass.getUsers()) do if sha256.sha256(usr) == usr then glass = glass.getUserSurace(usr) end end
      glass.clear()
      if track.enabled and track.player ~= '' then
        local data = sen.getPlayerData(track.player)
        if data then
          glass.clear()
          glass.addBox(10,10,300,18,0x000000,0.5)
          glass.addText(15,15,data.username..': x '..math.ceil(data.position.x+sen_pos.x)..' y '..math.ceil(data.position.y+sen_pos.y)..' z '..math.ceil(data.position.z+sen_pos.z),0xFF1100)
        else
          glass.clear()
          glass.addBox(10,10,300,18,0x000000,0.5)
          glass.addText(15,15,'Player not available...',0xFF1100)
        end
      end
    end,
    function() --invsee function
      sleep(refresh_rate)
      if invsee.enabled and invsee.player ~= '' then
        print('Saw the inventory of '..invsee.player)
      end
    end
  )
end

--1. start script with checking for user, if not the user present then exit for safety else grab their surface and continue
--2. start the event loop
      --wait x secs for data, if not data then refresh displays
      
