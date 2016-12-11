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
local hash = 'bot:forward'
local num = redis:get(hash)
if matches[1]:lower() == 'msgid' and msg.reply_id and is_sudo(msg) then
return msg.reply_id
end
if matches[1]:lower() == 'forward' and is_owner(msg) then
num = matches[2]
      fwd_msg(get_receiver(msg), num, ok_cb, false)
end
if matches[1]:lower() == 'setversion' and is_sudo(msg) then
num = matches[2]
redis:set(hash, num)
return 'Done :)'
end 
if matches[1] == 'forward' and is_owner(msg) then
local msg_id = msg.reply_id
fwd_msg(get_receiver(msg),msg_id,ok_cb,true)
end
if matches[1] == "replyme" and is_owner(msg) then 
    if msg.to.type == "user" then 
       return 
       end
    if not is_owner(msg) then 
       return 
       end
    if msg.reply_id then 
       receiver = get_receiver(msg)
       Reply = msg.reply_id
       text = matches[2]
       get_message(msg.reply_id,reply_here,{receiver=receiver,text=text, Reply=Reply})
       else
       text = matches[2]
    reply_msg(msg.id, text, ok_cb, false)
  end 
  end
  if matches[1] == "reply" and is_owner(msg) then
if msg.reply_id then
reply_msg(msg.reply_id, matches[2], ok_cb, false)
end
end
if matches[1]:lower() == 'version' then
fwd_msg(get_receiver(msg), num, ok_cb, false)
end
end
return {
  patterns = {
"^[#!/]([Mm]sgid)$",
"^[#!/]([Ff]orward) (.*)$",
"^[#!/]([Ff]orward)$",
"^[#!/]([Dd]el) (.*)$",
"^[#/]([Rr]eplyme) (.*)$",
"^[#/]([Rr]eply) (.*)$",
"^[#!/]([Ss]etversion) (.*)$",
"^[#!/]([Vv]ersion)$",
"^([Mm]sgid)$",
"^([Ff]orward) (.*)$",
"^([Ff]orward)$",
"^([Dd]el) (.*)$",
"^([Rr]eplyme) (.*)$",
"^([Rr]eply) (.*)$",
"^([Ss]etversion) (.*)$",
"^([Vv]ersion)$",
  },
  run = run
  }