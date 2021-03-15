local items = {
    {id=1,dmg=0} --stone
}
 
local spawnItem = function (id,dmg)
    turtle.place(string.char(194,167).."1[Buy]\n"..id.."\n"..dmg.."\n$0.01")
end
 
for _,item in pairs(items) do
    spawnItem(item.id,item.dmg)
    print('Press any key to continue...')
    read()
    turtle.dig()
end
