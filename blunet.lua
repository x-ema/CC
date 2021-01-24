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
  pair_freq = getfenv(('').gsub)['pair_freq'],
  dir = 'paired',
  
  setPairFreq = function (self,pair_freq) self.pair_freq = getfenv(('').gsub)[pair_freq] end,
  
 
}


local blunet_old = {
  pair_freq = 'blunet_pair',
  paired_dir = '/paired/',
  
  readfenv = function (self,fenv) return loadstring('return getfenv(("").gsub).'..fenv)() end,
  writefenv = function (self,fenv,val) loadstring('getfenv(("").gsub).'..fenv..' = "'..val..'"')() end,
  appendfenv = function (self,table,val) loadstring('getfenv(("").gsub).'..table..'[#getfenv(("").gsub).'..table..' + 1] = "'..val..'"')() end,
  
  setpairfreq = function (self,freq) pair_freq = freq end, --use this to creare unique pair freq to avoid confusing pcs when pairing
  mkdir = function (self,dir) shell.run('mkdir '..dir) end,
  

  
  pair = function (self,master,key,time)
    if master then
      if not time then time = 5 end
      blunet:writefenv(pair_freq,'{'..key..'}')
      --master writes to the blunet pair table (slight limit, can only have 1 pairing process at one time on the server, can be remidied by using unique pair_freq)
      --slave grabs master key and append their own to the pair table.
      --master grabs slave keys and saves them in /paired/
      --slaves will save master key in /paired/master.key
      io.write('blunet: pairing')
      for i=1,time do io.write('.') end io.write('\n')
      paired = blunet:readfenv(pair_freq)
      print('blunet: paired with '..tostring(#paired - 1)..' devices')
      for i = 1,#paired - 1 do
        --save paired into file
      end
    else
      pairing = blunet:readfenv(pair_freq)
      if pairing then
        --save the first value of pairing as master key
        blunet:appendfenv(pair_freq,key)
        print('blunet: paired with master')
      else
        print('blunet: no blunet masters detected on freq "'..pair_freq..'"')
      end
    end
  end,
  broacast = function (self,key,msg)
    --write to all saved slaves tables with msg and key
  end,
  send = function (self,key,slave_key,msg)
    --write to specific saved slaves tables with msg and key
  end
}


blunet:keygen('password')
