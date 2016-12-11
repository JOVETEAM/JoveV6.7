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
local function run(msg, matches)
	if matches[1] == 'bc' and is_admin1(msg) then
		local response = matches[3]
		--send_large_msg("chat#id"..matches[2], response)
		send_large_msg("channel#id"..matches[2], response)
	end
	if matches[1] == 'broadcast' then
		if is_sudo(msg) then -- Only sudo !
			local data = load_data(_config.moderation.data)
			local groups = 'groups'
			local response = matches[2]
			for k,v in pairs(data[tostring(groups)]) do
				chat_id =  v
				local chat = 'chat#id'..chat_id
				local channel = 'channel#id'..chat_id
				send_large_msg(chat, response)
				send_large_msg(channel, response)
			end
		end
	end
end
return {
  patterns = {
    "^[#!/](broadcast) (.*)$",
    "^[#!/](bc) (%d+) (.*)$",
        "^(broadcast) (.*)$",
    "^(bc) (%d+) (.*)$"
  },
  run = run
}