# CC
f=fs.open('git','w');f.write(http.get().readAll('https://raw.githubusercontent.com/x-ema/CC/master/git.lua'));f.close();print('git installed')
