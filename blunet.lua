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

if not fs.exists('sha256') then error('required lib sha256 not found') end
os.loadAPI('sha256') --requires sha256 lib by MaHuJa


local blunet = { --only supports one way connections atm (master to slaves)
  pair_freq = nil,
  dir = 'paired',
  key = '',
  identifier = 0,
  
  setPairFreq = function (self,pair_freq) self.pair_freq = getfenv(('').gsub)[pair_freq] end,
  getPaired = function (self) return fs.list(dir) end,
  returnKey = function (self,key_str) return sha256.sha256(key_str) end,
  keygen = function (self,key_str) self.key = sha256.sha256(key_str) end,
  append = function (self,table,val) table[#table + 1] = val end,
  saveKey = function (self,key) if fs.exists(self.dir + key) then return true else f = fs.open(self.dir..'/'..key,'w') f.write(key) f.close() return true end end,
  readKeys = function (self) if #fs.list(self.dir) > 0 then return fs.list(self.dir)[1] else error('No devices paired') end end,
  setDir = function (self,new_dir) if not fs.exists(new_dir) then fs.makeDir(new_dir) else self.dir = new_dir end end,
  
  
  pair = function (self,master,timeout)
    key = self.key
    if not self.pair_freq then error('You must specify a pair_Freq before pairing, use blunet:setPairFreq("<freq>") to pair.') end
    if not self.key then error('You must specify a key for this PC before pairing, use blunet:keygen("<key>") to set a key') end
    if master then
      pair_freq.key = {key} --solved 1 pairer at a time by using a user defined pair_freq which will hopefully never be the same
      term.clear()
      term.setCursorPos(1,1)
      print('Press any key to stop pairing...')
      os.pullEvent('key')
      for i = 2,#pair_freq do self:saveKey(pair_freq[i]) end
      print('Paired with '..tostring(#pair_freq - 1)..' devices')
    else
      if self.pair_freq == {} then error('No masters pairing on this freq') end
      saveKey(self.pair_freq[1])
      self:append(self.pair_Freq,self.key)
    end
  end,
  broadcast = function (self,data)
    if not data then error('Usage blunet:broadcast(<data>') end
    if not self.key then error('You must specify a key for this PC before pairing, use blunet:keygen("<key>") to set a key') end
    math.randomseed(os.time())
    getfenv(('').gsub)[self.key] = {key = self.key, data = data, id = math.random(1,1000000)}
    --sends data to the 'global' channel and sends a unique identifier to allow for multiple of the same message
  end,
  
  send = function (self,key,data)
    if not key or data then error('Usage blunet:send(<key>,<data>)') end
    math.randomseed(os.time())
    getfenv(('').gsub)[key] = {key = key, data = data, id = math.random(1,1000000)}
    --sends data to a specific key or slave, also a unique id  to allow for multile of the same message
  end,
  
  receive = function (self) --issue: accidently running this on a master node could cause problems since it will have to sift through however many paired slaves it has. will either just receive data incorrectly or crash not sure yet
    key = self:readKeys()
    global = getfenv(('').gsub)[key]
    loc = getfenv(('').gsub)[self.key]
    repeat
      if global then
        if global.key == key and self.identifier ~= global.id then
          self.identifier = global.id
          return global.data
        end
      elseif loc then
        if loc.key == self.key and self.identifier ~= global.id then
          self.identifier = global.id
          return loc.data
        end
      end
      --check device specific channel and the 'global' channel and compare the unique identifier to make sure it isnt reading a duplicate message
    until data ~= nil
  end
 }

--concept code not yet bugtested
  
  print(blunet:returnKey('password'))
