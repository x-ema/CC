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
  freq = 'blunet_pair',
  paired_dir = '/paired/',
  
  readfenv = function (self,fenv) return loadstring('return getfenv(("").gsub).'..fenv)() end,
  writefenv = function (self,fenv,val) loadstring('getfenv(("").gsub).'..fenv..' = "'..val..'"')() end,
  appendfenv = function (self,table,val) loadstring('getfenv(("").gsub).'..pair_freq..'[#getfenv(("").gsub).'..pair_freq..' + 1] = "'..val..'"')() end,

  keygen = function (self,passkey) -- blunet:keygen('password')
    key = ''
    for i = 1,#passkey do
      key = key ..((passkey:sub(i,i):byte() + os.getComputerID()) / #passkey)..'/'
    end
    return key
  end,
  
  pair = function (self,master,key,time)
    if master then
      if not time then time = 5 end
      blunet:writefenv('',) --write to master blunet pair table makes a table that contains the key
                         --slaves will grab the master key and append their key to the table master will then grab the slave keys and save them
      io.write('blunet: pairing')
      for i=1,time do io.write('.') end io.write('\n')
      print('blunet: paired with x devices')
      
      
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
