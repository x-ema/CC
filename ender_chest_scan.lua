chest = peripheral.wrap('top')
for i = 0,4095 do
	chest.setFrequency(i)
	all_items = chest.getAllStacks()
	if #all_items > 0 then
		print('Freq : '..i)
		for x = 1,#all_items do
			chest.pushItem('up',x)
			print('		found '..all_items[x].name..' X'..all_items[x].qty)
		end
	end
end
