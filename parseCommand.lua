_,msg,user = os.pullEvent('chat_command')

function split(str)
  words = {}
  for word in str:gmatch('%S+') do words[#words+1] = word end
  return words
end

cmd = msg:split()
