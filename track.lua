local sen_pos = {x=4887,y=6,z=3572}
local glass = peripheral.wrap('top')
local tracking = 'Sleetyy'

parallel.waitForAny(
  function()
    _,msg,usr = os.pullEvent('chat_command')
    if usr == 'Sleetyy' then tracking = usr end
    print(usr..' : '..msg)
  end,
  function()
    sleep(2)
    data = peripheral.call('bottom','getPlayerData',tracking)
    print(data.position.x)
    print(data.position.y)
    print(data.position.z)
    print(data.username)
  end
)
