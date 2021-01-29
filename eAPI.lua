--[[
--essentialsAPI, From:Slitty ;3 (aka Slit)


function centerText(line,text,color) --centerText(1,colors.white,"Hello World")
    local ox,oy = term.getCursorPos()
    local x,y = term.getSize()
    local mid = (x/2)-(string.len(text)/2)
    term.setCursorPos(mid,line)
    if not color then local color = colors.white end
    term.setTextColor(color)
    term.write(text)
    term.setTextColor(colors.white)
    term.setCursorPos(ox,oy)
end

function newln(ln)
    if not ln then ln = 1 end
    local x,y = term.getCursorPos()
    term.setCursorPos(1,y+ln)
end

function progressBar(ypos,percent,text)
    local x,y = term.getSize()
    local text = math.floor(percent*100).."% "..text
    local half = (x/2)-(string.len(text)/2)
    local percent = math.floor(percent*(x-6))
    local colorInput
    local color
    paintutils.drawLine(6,ypos,x-6,ypos,colors.red)
    paintutils.drawLine(6,ypos,percent,ypos,color)
    term.setBackgroundColor(colors.black)
    term.setCursorPos(half,ypos+1)
    write(text)
    term.setCursorPos(1,ypos+2)
end

function paintBox(xpos,ypos,xsize,ysize,color,text,center)
    for i=1,ysize do
        paintutils.drawLine(tonumber(xpos),(tonumber(ypos)+i)-1,tonumber(xpos)+tonumber(xsize),(tonumber(ypos)+i)-1,color)
    end
    if not text then local text = " " end
    if center then
        term.setCursorPos((xpos+xsize/2)-(text:len()/2),ypos+ysize/2)
        write(text)
    elseif not center then
        term.setCursorPos(xpos,ypos)
        write(text)
    end
    term.setBackgroundColor(colors.black)
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

function table_contains(table,contain)
    local found = false
    for _,val in pairs(table) do
        if val == contain then
            found = true
        end
    end
    return found
end

function button(buttons)
    for num,btn in pairs(buttons) do
        if btn["xsize"] < btn["text"]:len() then
            term.clear()
            error("Length of text ["..btn["text"]:len().."] is longer than the space available["..btn["xsize"].."]")
        end
        paintBox(btn["xpos"],btn["ypos"],btn["xsize"],btn["ysize"],btn["color"],btn["text"],btn["centerText"])
    end
    local running = true
    while running do
        local _,_,x,y=os.pullEvent("mouse_click")
        for _,btn in pairs(buttons) do
            if (x >= btn["xpos"] and x <= btn["xpos"]+btn["xsize"]) and (y >= btn["ypos"] and y <= btn["ypos"]+btn["ysize"]) then
                if btn["exit"] then
                    running = false
                    btn["func"](unpack(btn["args"]))
                else
                    btn["func"](unpack(btn["args"]))
                end
            end
        end
    end
end
btn1={
xpos=5;
ypos=2;
xsize=10;
ysize=5;
text="Say Hello!"
color=colors.red;
centerText=true;
func=print;
args={"HELLO!"};
exit=false;
}

button = function ()
  local x_size,y_size = term.getSize()
  for _,button in pairs(buttons) do
    if button.x_pos + button.x_size > x_size or button.y_pos + button.y_size > y_size then error('button '.._..' is too big for the display...') end
    if #button.text > button.x_size then error('text on button '.._..' is too long for this button') end
    if not button.color then button.color = colors.black end
    for i = button.y_pos,button.y_size do
      paintutils.drawLine(button.x_pos,i,button.x_size,i,button.color)
    end
    term.setCursorPos()
  end
end]]--
listPeripherals = function () --[[Lists all connected peripherals]]--
  for _,location in pairs(peripheral.getNames()) do
    print(location..' : '..peripheral.getType(location))
  end
end

mount = function (peripheral_type) --[[mounts the first connected peripheral that matches the name of peripheral_type, essentially its a copy of modern day peripheral.find]]--
  for _,location in pairs(peripheral.getNames()) do
    if peripheral.getType(location) == peripheral_type then return peripheral.wrap(location) end
  end
  return false
end

