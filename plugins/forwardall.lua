--[[
|###########################################################################################|
|   _______________   #E   _______________   #    _______________   #P     _____________    |
|  |   ____________|  #R  |    ________   \  #   |    ________   \  #O    /   _______   \   |
|  |  |____________   #F  |   |________|  |  #   |   |________|  |  #U   |   /       \   |  |
|  |   ____________|  #A  |    ___________/  #   |    ___________/  #Y   |   |       |   |  |
|  |  |____________   #N  |   |   \   \      #   |   |              #A   |   \_______/   |  |
|  |_______________|  #   |___|    \___\     #   |___|              #     \_____________/   |
|###########################################################################################|
| Powered By:Pouya Porrahman ,Edited By:Erfan Kiya.ERPO Team ,Jove Version 6.0 Marshmallow :|
|###########################################################################################|
]]
function run(msg, matches)
if matches[1] == 'forwardall' and msg.reply_id then
      local data = load_data(_config.moderation.data)
      local groups = 'groups'
local i = 0
      for k,v in pairs(data[tostring(groups)]) do
        chat_id =  v
        local channel = 'channel#id'..chat_id
fwd_msg(channel, msg.reply_id,ok_cb, false)
i = i +1
end
send_large_msg(get_receiver(msg), ">مطلب شما به گروه "..i.." ارسال گردید")
end
if matches[1]:lower() == 'msgid' and msg.reply_id then
 return msg.reply_id
end
if matches[1] == "forwardall" and matches[2] then
local text = matches[2]
  local data = load_data(_config.moderation.data)
      local groups = 'groups'
local i = 0
      for k,v in pairs(data[tostring(groups)]) do
        chat_id =  v
        local channel = 'channel#id'..chat_id
i = i +1
fwd_msg(channel, text, ok_cb, false)
end
send_large_msg(get_receiver(msg), ">مطلب شما به گروه "..i.." ارسال گردید")
end
end
return {
  patterns = {
    "^[#/!](forwardall)$",
"^[#!/](msgid)$",
"^[#/!](forwardall) (.*)$",
    "^(forwardall)$",
"^(msgid)$",
"^(forwardall) (.*)$"
  },
  run = run
}
