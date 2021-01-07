--[[
function centerText(line,color,text,mon) --centerText(1,colors.white,"Hello World",nil)
if mon ~= nil then
local ox,oy = mon.getCursorPos()
local x,y = mon.getSize()
local mid = (x/2)-(string.len(text)/2)
mon.setCursorPos(mid,line)
mon.setTextColor(color)
mon.write(text)
mon.setTextColor(colors.white)
mon.setCursorPos(ox,oy)
else
local ox,oy = term.getCursorPos()
local x,y = term.getSize()
local mid = (x/2)-(string.len(text)/2)
term.setCursorPos(mid,line)
term.setTextColor(color)
term.write(text)
term.setTextColor(colors.white)
term.setCursorPos(ox,oy)
end
end
 
function m_print(mon,text)
local x,y = mon.getCursorPos()
mon.write(text)
mon.setCursorPos(1,y+1)
end
 
function progBar(ypos,pfull,text,barColor,mon) --pfull = percent full as a decimal ex, 80% = .8
if mon ~= nil then
local allText = math.floor(pfull*100).."% "..text
mon.setBackgroundColor(barColor)
local x,y = mon.getSize()
local pfull2 = math.floor(pfull*(x-6))
for i=3,x-3 do
mon.setCursorPos(i,ypos)
mon.write(" ")
end
if pfull < 0.6 then
mon.setBackgroundColor(colors.orange)
elseif pfull > 0.6 and pfull < 0.8 then
mon.setBackgroundColor(colors.yellow)
elseif pfull > 0.8 then
mon.setBackgroundColor(colors.green)
end
for i=3,pfull2 do
mon.setCursorPos(i,ypos)
mon.write(" ")
end
local half = (x/2)-(string.len(allText)/2)
mon.setBackgroundColor(colors.black)
mon.setCursorPos(half,ypos+1)
mon.write(allText)
else
local allText = math.floor(pfull*100).."% "..text
term.setBackgroundColor(barColor)
local x,y = term.getSize()
local pfull2 = math.floor(pfull*(x-6))
for i=3,x-3 do
term.setCursorPos(i,ypos)
term.write(" ")
end
if pfull < 0.6 then
term.setBackgroundColor(colors.orange)
elseif pfull > 0.6 and pfull < 0.8 then
term.setBackgroundColor(colors.yellow)
elseif pfull > 0.8 then
term.setBackgroundColor(colors.green)
end
for i=3,pfull2 do
term.setCursorPos(i,ypos)
term.write(" ")
end
local half = (x/2)-(string.len(allText)/2)
term.setBackgroundColor(colors.black)
term.setCursorPos(half,ypos+1)
term.write(allText)
end
end
 
function allPeripherals(ptype)
local peripherals = {}
for _,perip in pairs(peripheral.getNames()) do
if peripheral.getType(perip) == ptype then
table.insert(peripherals,perip)
end
end
if peripherals ~= nil then return peripherals else return false end
end
 
function buttonRun(buttonsData,mon)  --{{xpos,ypos,ysize,xsize,buttoncolor,textcolor,text,func,args,exitAfter},{...}}
local allButtons = {}
if mon ~=  nil then
else
for _,buttonData in pairs(buttonsData) do
local curButton = {
xmin = buttonData.xpos;
xmax = buttonData.xpos+buttonData.xsize;
ymin = buttonData.ypos;
ymax = buttonData.ypos+buttonData.ysize;
func = buttonData.func;
args = buttonData.args;
exitAfter = buttonData.exitAfter;
}
table.insert(allButtons,curButton)
local oldText = term.getTextColor()
local oldBack = term.getBackgroundColor()
term.setCursorPos(buttonData.xpos,buttonData.ypos)
term.setTextColor(buttonData.textColor)
term.setBackgroundColor(buttonData.buttonColor)
for i=1,buttonData.ysize do
term.setCursorPos(buttonData.xpos,buttonData.ypos+(i-1))
for o=1,buttonData.xsize do
term.write(" ")
end
end
local xhalf = (buttonData.xpos+(buttonData.xsize/2))-(string.len(buttonData.text)/2)
local yhalf = buttonData.ypos+(buttonData.ysize/2)
term.setCursorPos(xhalf,yhalf)
term.write(buttonData.text)
term.setTextColor(oldText)
term.setBackgroundColor(oldBack)
end
local running = true
while running do
local event,button,xpos,ypos = os.pullEvent("mouse_click")
for _,tB in pairs(allButtons) do
if (xpos >= tB.xmin and xpos <= tB.xmax) and (ypos >= tB.ymin and ypos <= tB.ymax)then
if tB.exitAfter then
if tB.func ~= nil then
tB.func(table.unpack(tB.args))
end
running = false
else
tB.func(table.unpack(tB.args))
end
end
end
--local event,side,xpos,ypos = os.pullEvent("monitor_touch") For monitors instead of terminals
end
end
end
]]--

function mount(peripheral_name)
 if peripheral_name == 'help' then error('usage "peripheral_name":mount(). ex pname = peripheral.wrap("monitor":mount())')
 for _,perip in pairs(peripheral.getNames()) do
   if peripheral.getType(perip) == peripheral_name then
    return perip
   end
 end
end
