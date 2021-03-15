id = '1828'
dmg = '0'
qty = '1'
str = {string.char(194,167).."1[Buy]",qty,id..":"..dmg,"$0.01"}
for _,x in pairs(str) do
   peripheral.call('front','setLine',_,x) 
end

read()

for i=1,4 do
   peripheral.call('front','setLine',i,'.') 
end
