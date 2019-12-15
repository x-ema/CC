local func = io.read()
if func == "get" then
	local url = io.read()
	local name = io.read()
	_ = io.open(name,"w")
	_.write(http.get("https://raw.githubusercontent.com/x-ema/CC/master/" .. url).readAll())
	_.close()
end