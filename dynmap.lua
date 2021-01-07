--[[Functions]]--
function mount(peripheral_name)
 if peripheral_name == 'help' then print('usage "peripheral_name":mount(). ex pname = peripheral.wrap("monitor":mount())') end
 for _,perip in pairs(peripheral.getNames()) do
   if peripheral.getType(perip) == peripheral_name then
    return perip
   end
 end
end
--[[Main]]--
sensor = '
