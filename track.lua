os.loadAPI('sha256')

local sen_pos = {x=4887,y=6,z=3572}
local tracking = ''
local user = '6acd7cbdda8356a0d0f6df82f0f52308786c6fbcfa1b14499e563bb34637fb79'

valid = function (usr) if sha256.sha256(usr) == user then return true else return false end end

for _,usr in pairs(peripheral.call('top','getUsers')) do
  if valid(usr) then glass = peripheral.call('top','getUserSurface',usr) end
end
if not glass then error(user..' not found') end

while true do
  parallel.waitForAny(
    function()
      _,msg,usr = os.pullEvent('chat_command')
      if sha256.sha256(usr) == user then tracking = msg end
    end,
    function()
      sleep(2)
      data = peripheral.call('bottom','getPlayerData',tracking)
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
  )
end
