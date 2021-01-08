ochest = peripheral.wrap("top")


while true do
	for i=1,4096 do
		oChest.setFrequency(i)
		if #oChest ~= 0 then
			print("Located " .. i)
			oChest.condenseItems()
			for ii=1,#oChest.getAllStacks() do
				oChest.pushItem("south",ii)
			end
		end
	end
end
