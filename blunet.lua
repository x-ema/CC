--[[
PAIRING PROCESS POC:?
1. master is 'available to pair'
2. Slave is in pairing mode
3. Slave sees master
4. Slave sends its personal key to master
5. Master saves key in keys file
6. master sends secure key to slave to verify master

7. on each transaction the master broadcasts its personal key with the message so slaves can verify the master

master can then use blunet:send() to send directly to 1 or a few slaves
master can use blunet:broadcast to send to all connected slaves
]]--

local blunet = {
  freq = 'blunet_1_pair',
  paired_dir = '/paired/',
  
  readfenv = function (self,fenv) return loadstring('return getfenv(("").gsub).'..fenv)() end,
  writefenv = function (self,fenv,val) loadstring('getfenv(("").gsub).'..fenv..' = '..val) end,
  keygen = function (self,passkey) -- blunet:keygen('password')
    key = ''
    for i = 1,#passkey do
      key = key ..((passkey:sub(i,i):byte() + os.getComputerID()) / #passkey)..'/'
    end
    return key
  end,
  
  pair = function (self,master,key)
    if master then
      
    else
      
    end
  end
}


blunet:keygen('password')





--[[
blunet = {
  pair = function (self,master)
    if master then
      key = read()
      print(getfenv(('').gsub).key)
    else
      key = '1534243'
      getfenv(('').gsub).key = '1234'
    end
  end
}
]]--
