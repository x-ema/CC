local filename = io.read()
local toname = io.read()
f = fs.open(toname,"w")
f.write(http.get("https://raw.githubusercontent.com/x-ema/CC/master/" .. filename).readAll())