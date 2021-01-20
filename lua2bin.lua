--[[
pulled from https://pastebin.com/u/GopherAtl
lua2bin
 
loads a lua program, compiles it to bytecode, then outputs a new program 
that contains that bytecode, in base64, and when run, decodes it and 
launches the original program.
 
used for code obfuscation in lua.
--]]
 
local tArgs={...}
 
local function printUsage()
  print([[Usage:
lua2bin <luafile> <output>
<luafile> should be the name of the lua program to encrypt
<output> should be the name of the output file.
Note this process is NOT REVERSABLE, so output must be differnt from input!]])
  error()
end
 
if #tArgs~=2 then
  printUsage()
end
 
if not fs.exists(tArgs[1]) then
  error("Input file \""..tArgs[1].."\" does not exist!")
end
if fs.exists(tArgs[2]) then
  error("output file \""..tArgs[2].."\" already exists!")
end
 
local base64="0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-"
local base64r={}
for i=1,64 do
  base64r[base64:sub(i,i)]=i-1
end
 
local function _8to6(src)
  local out=""
  local bits=0
  local numBits=0
  for i=1,#src do
    bits=bits+bit.blshift(src:byte(i),numBits)
    numBits=numBits+8
    while numBits>=6 do
      local byte=bit.band(bits,0x3f)
      bits=bit.brshift(bits,6)
      numBits=numBits-6
      out=out..base64:sub(byte+1,byte+1)
    end
  end
  --append last bits
  if numBits>0 then
    out=out..base64:sub(bits+1,bits+1)
  end
  return out
end
 
 
local file1=[[
--file autogenrated by lua2bin, by GopherAtl.
 
--look-up table for decoding the base64
local base64r=]]
 
local file2=[[
 
 
--this function converts the encoded base64 back into binary
local function _6to8(src)
  local out=""
  local bits=0
  local numBits=0
  for i=1,#src do
    bits=bits+bit.blshift(base64r[string.char(src:byte(i))],numBits)
    numBits=numBits+6
    while numBits>=8 do
      local byte=bit.band(bits,0xff)
      out=out..string.char(byte)
      bits=bit.brshift(bits,8)
      numBits=numBits-8
    end
  end
  return out
end
 
local code64="]]
 
 
 
local file3=[["
 
 
local srcBin=_6to8(code64)
local func=loadstring(srcBin)
func(...)]]
 
 
local file=fs.open(tArgs[1],"r")
local text=file.readAll()
file.close()
 
local func=loadstring(text)
local binText=string.dump(func)
local text64=_8to6(binText)
 
file=fs.open(tArgs[2],"w")
file.write(file1)
file.write(textutils.serialize(base64r))
file.write(file2)
file.write(text64)
file.write(file3)
file.close()
