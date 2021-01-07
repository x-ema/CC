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
]]--
function help()
 print('mount - mount a peripheral by name instead of side')
 print('contains - check to see if a table contains a value')
end

function mount(peripheral_name)
 if peripheral_name == 'help' then print('usage "peripheral_name":mount(). ex pname = peripheral.wrap("monitor":mount())') end
 for _,perip in pairs(peripheral.getNames()) do
   if peripheral.getType(perip) == peripheral_name then
    return perip
   end
 end
end

function contains(table,search)
 if table == 'help' then print('usage <table>:contains(<value>)') end
 for _,val in pairs(table) do
  if val == search then return true end
 end
 return false
end
