local cli_args = {...}
if #cli_args == 3 then
  f = fs.open(cli_args[3],'w')
  f.write(http.get('https://raw.githubusercontent.com/'..cli_args[1]..'/'..cli_args[2]..'/master/'..cli_args[3]).readAll())
  f.close()
else
  error('usage: git <username> <branch> <filename>')
end
