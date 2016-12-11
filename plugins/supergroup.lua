--[[
|##########################################################################################|
|   _______________   #   _______________   #    _______________   #P     _____________    |
|  |   ____________|  #  |    ________   \  #   |    ________   \  #O    /   _______   \   |
|  |  |____________   #  |   |________|  |  #   |   |________|  |  #U   |   /       \   |  |
|  |   ____________|  #  |    ___________/  #   |    ___________/  #Y   |   |       |   |  |
|  |  |____________   #  |   |   \   \      #   |   |              #A   |   \_______/   |  |
|  |_______________|  #  |___|    \___\     #   |___|              #     \_____________/   |
|##########################################################################################|
| Powered By:Pouya Porrahman ,CLI ANTISPAM BOT FAST,SMART =>Jove Version 6.7 Marshmallow :)|
|##########################################################################################|
]]
--Begin supergrpup.lua Jove V6.7
--Check members #Add supergroup
local function check_member_super(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local data = cb_extra.data
  local msg = cb_extra.msg
  if type(result) == 'boolean' then
      print('This is a old message!')
      return reply_msg(msg.id, '[Not supported] This is a old message!', ok_cb, false)
    end
  if success == 0 then
	send_large_msg(receiver, "🎖 <code> ابتدا من را ادمین کنید! </code> 🎖")
  end
  for k,v in pairs(result) do
    local member_id = v.peer_id
    if member_id ~= our_id then
      -- SuperGroup configuration
      data[tostring(msg.to.id)] = {
        group_type = 'SuperGroup',
		long_id = msg.to.peer_id,
		moderators = {},
        set_owner = member_id ,
        settings = {
          set_name = string.gsub(msg.to.title, '_', ' '),
		  lock_arabic = 'no',
		  lock_link = 'yes',
		  lock_bots = 'yes',
		  lock_commands = 'no',
		  lock_linkpro = 'yes',
		  lock_operator = 'yes',
		  lock_webpage = 'yes',
		  lock_inline = 'yes',
          flood = 'yes',
		  lock_spam = 'yes',
		  lock_sticker = 'no',
		  member = 'no',
      lock_fwd = 'yes',
      lock_tag = 'yes',
	  lock_emoji = 'no',
      lock_badword = 'yes',
      lock_hashtag = 'yes',
      lock_reply = 'no',
		  public = 'no',
		  lock_rtl = 'no',
		  lock_tgservice = 'no',
		  lock_contacts = 'no',
		  strict = 'no'
        }
      }
      save_data(_config.moderation.data, data)
      local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = {}
        save_data(_config.moderation.data, data)
      end
      data[tostring(groups)][tostring(msg.to.id)] = msg.to.id
      save_data(_config.moderation.data, data)
	  local text = "🎖نام گروه🎖 : <code>"..msg.to.title.."</code> \n🎖به لیست گروه های ربات افزوده شد توسط : @"..msg.from.username.." 🎖 <code>\n  🎖ورژن 6.7 ژوپیتر(مارشمالو)🎖 </code>"
      return reply_msg(msg.id, text, ok_cb, false)
    end
  end
end

--Check Members #rem supergroup
local function check_member_superrem(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local data = cb_extra.data
  local msg = cb_extra.msg
  if type(result) == 'boolean' then
      print('This is a old message!')
      return reply_msg(msg.id, '[Not supported] This is a old message!', ok_cb, false)
    end
  for k,v in pairs(result) do
    local member_id = v.id
    if member_id ~= our_id then
	  -- Group configuration removal
      data[tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)
      local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = nil
        save_data(_config.moderation.data, data)
      end
      data[tostring(groups)][tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)
	  local text = "🎖نام گروه🎖 : <code>"..msg.to.title.."</code> \n🎖ازلیست گروه های ربات حذف شد توسط : @"..msg.from.username.." 🎖 <code> 🎖ورژن 6.7 ژوپیتر(مارشمالو)🎖 </code>"
      return reply_msg(msg.id, text, ok_cb, false)
    end
  end
end

--Function to Add supergroup
local function superadd(msg)
	local data = load_data(_config.moderation.data)
	local receiver = get_receiver(msg)
    channel_get_users(receiver, check_member_super,{receiver = receiver, data = data, msg = msg})
end

--Function to remove supergroup
local function superrem(msg)
	local data = load_data(_config.moderation.data)
    local receiver = get_receiver(msg)
    channel_get_users(receiver, check_member_superrem,{receiver = receiver, data = data, msg = msg})
end

--Get and output admins and bots in supergroup
local function callback(cb_extra, success, result)
local i = 1
local chat_name = string.gsub(cb_extra.msg.to.print_name, "_", " ")
local member_type = cb_extra.member_type
local text = member_type.." for "..chat_name..":\n"
for k,v in pairsByKeys(result) do
if not v.first_name then
	name = " "
else
	vname = v.first_name:gsub("?", "")
	name = vname:gsub("_", " ")
	end
		text = text.."\n"..i.." - "..name.."["..v.peer_id.."]"
		i = i + 1
	end
    send_large_msg(cb_extra.receiver, text)
end


local function check_member_super_deleted(cb_extra, success, result)
local receiver = cb_extra.receiver
 local msg = cb_extra.msg
  local deleted = 0 
if success == 0 then
send_large_msg(receiver, "🎖اول منو ادمین کنید🎖") 
end
for k,v in pairs(result) do
  if not v.first_name and not v.last_name then
deleted = deleted + 1
 kick_user(v.peer_id,msg.to.id)
 end
 end
 send_large_msg(receiver, "🎖باموفقیت همه حذف شدند🎖\n <i>تعداد اکانت های حذف شده</i>:"..deleted) 
 end 


local function callback_clean_bots (extra, success, result)
	local msg = extra.msg
	local receiver = 'channel#id'..msg.to.id
	local channel_id = msg.to.id
	for k,v in pairs(result) do
		local bot_id = v.peer_id
		kick_user(bot_id,channel_id)
	end
end
local function callback_clean_members (extra, success, result)
  local msg = extra.msg
  local receiver = 'channel#id'..msg.to.id
  local channel_id = msg.to.id
  for k,v in pairs(result) do
  local users_id = v.peer_id
  kick_user(users_id,channel_id)
  end
end


--Get and output info about supergroup
local function callback_info(cb_extra, success, result)
local title ="<code> 🎖نام گروه🎖 </code> : ["..result.title.."]\n\n"
local admin_num = "<code> 🎖ادمین ها🎖 </code>: "..result.admins_count.."\n"
local user_num = "<code> 🎖کاربران🎖 </code>: "..result.participants_count.."\n"
local kicked_num = "<code> 🎖کاربران اخراج شده🎖 </code>: "..result.kicked_count.."\n"
local channel_id = "<code> 🎖ایدی🎖 </code>: "..result.peer_id.."\n"
local user_name = "<code> 🎖نام کاربری شما🎖 </code> : "..msg.from.username.."\n"
if result.username then
	channel_username = "Username: @"..result.username
else
	channel_username = ""
end
local text = title..admin_num..user_name..user_num..kicked_num..channel_id..channel_username
    send_large_msg(cb_extra.receiver, text)
end

--Get and output members of supergroup
local function callback_who(cb_extra, success, result)
local text = "🎖کاربران "..cb_extra.receiver
local i = 1
for k,v in pairsByKeys(result) do
if not v.print_name then
	name = " "
else
	vname = v.print_name:gsub("?", "")
	name = vname:gsub("_", " ")
end
	if v.username then
		username = " @"..v.username
	else
		username = ""
	end
	text = text.."\n"..i.." - "..name.." "..username.." [ "..v.peer_id.." ]\n"
	--text = text.."\n"..username
	i = i + 1
end
    local file = io.open("./groups/lists/supergroups/"..cb_extra.receiver..".txt", "w")
    file:write(text)
    file:flush()
    file:close()
    send_document(cb_extra.receiver,"./groups/lists/supergroups/"..cb_extra.receiver..".txt", ok_cb, false)
	post_msg(cb_extra.receiver, text, ok_cb, false)
end

--Get and output list of kicked users for supergroup
local function callback_kicked(cb_extra, success, result)
--vardump(result)
local text = "🎖افراد اخراج شده سوپر گروه "..cb_extra.receiver.." 🎖\n\n"
 	local i = 1
  	for k,v in pairsByKeys(result) do
  		if not v.print_name then
  			name = " "
  		else
  			vname = v.print_name:gsub("‮", "")
  			name = vname:gsub("_", " ")
  		end
  		if v.username then
  			name = name.." @"..v.username
  		end
  		text = text.."\n"..i.." - "..name.." [ "..v.peer_id.." ]\n"
  		i = i + 1
	end
	local file = io.open("./groups/lists/supergroups/kicked/"..cb_extra.receiver..".txt", "w")
  	file:write(text)
  	file:flush()
  	file:close()
  	send_document(cb_extra.receiver,"./groups/lists/supergroups/kicked/"..cb_extra.receiver..".txt", ok_cb, false)
 --send_large_msg(cb_extra.receiver, text)
end

--Begin supergroup locks
local function lock_group_links(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_link_lock = data[tostring(target)]['settings']['lock_link']
  if group_link_lock == 'yes' then
    return '🎖ارسال لینک از قبل <code> قفل </code> است🎖'
  else
    data[tostring(target)]['settings']['lock_link'] = 'yes'
    save_data(_config.moderation.data, data)
    return '🎖تغییر وضعیت لینک ها🎖 <code>\n  حذف لینک \n</code>    تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end

local function unlock_group_links(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_link_lock = data[tostring(target)]['settings']['lock_link']
  if group_link_lock == 'no' then
    return '🎖ارسال لینک از قبل <code> آزاد </code> است🎖'
  else
    data[tostring(target)]['settings']['lock_link'] = 'no'
    save_data(_config.moderation.data, data)
    return '🎖تغییر وضعیت لینک ها🎖 <code>\n  حذف نشدن لینک \n</code>   	تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end

local function lock_group_commands(msg, data, target)
  if not is_owner(msg) then
    return 
  end
  local group_commands_lock = data[tostring(target)]['settings']['lock_commands']
  if group_commands_lock == 'yes' then
   return reply_msg(msg.id, '🎖دستورات از قبل <code> قفل </code> است🎖', ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_commands'] = 'yes'
    save_data(_config.moderation.data, data)
    return '🎖تغییر وضعیت دستورات🎖 <code>\n  حذف دستورات \n</code>   	تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end

local function unlock_group_commands(msg, data, target)
  if not is_owner(msg) then
    return
  end
  local group_commands_lock = data[tostring(target)]['settings']['lock_commands']
  if group_commands_lock == 'no' then
    return reply_msg(msg.id, '🎖دستورات از قبل <code> آزاد </code> است🎖', ok_cb, false)
	else
    data[tostring(target)]['settings']['lock_commands'] = 'no'
    save_data(_config.moderation.data, data)
    return '🎖تغییر وضعیت دستورات🎖 <code>\n  حذف نشدن دستورات \n</code>   	تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end

local function lock_group_webpage(msg, data, target)
  if not is_owner(msg) then
    return
  end
local group_webpage_lock = data[tostring(target)]['settings']['lock_webpage']
  if group_webpage_lock == 'yes' then
   return reply_msg(msg.id, '🎖صفحات اینترنتی از قبل <code> قفل </code> است🎖', ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_webpage'] = 'yes'
    save_data(_config.moderation.data, data)
    return '🎖تغییر وضعیت صفحات اینترنتی🎖 <code>\n  حذف صفحات اینترنتی \n</code>   	تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end

local function unlock_group_webpage(msg, data, target)
  if not is_owner(msg) then
    return
  end
  local group_webpage_lock = data[tostring(target)]['settings']['lock_webpage']
  if group_webpage_lock == 'no' then
    return reply_msg(msg.id, '🎖صفحات اینترنتی از قبل <code> آزاد </code> است🎖', ok_cb, false)
	else
    data[tostring(target)]['settings']['lock_webpage'] = 'no'
    save_data(_config.moderation.data, data)
    return '🎖تغییر وضعیت صفحات اینترنتی🎖 <code>\n  حذف نشدن صفحات اینترنتی \n</code>   	تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end

local function lock_group_linkpro(msg, data, target)
  if not is_owner(msg) then
    return
  end
local group_linkpro_lock = data[tostring(target)]['settings']['lock_linkpro']
  if group_linkpro_lock == 'yes' then
   return reply_msg(msg.id, '🎖لینک پیشرفته از قبل <code> قفل </code> است🎖', ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_linkpro'] = 'yes'
    save_data(_config.moderation.data, data)
    return '🎖تغییر وضعیت لینک پیشرفته🎖 <code>\n  حذف لینک پیشرفته \n</code>   	تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end

local function unlock_group_linkpro(msg, data, target)
  if not is_owner(msg) then
    return
  end
  local group_linkpro_lock = data[tostring(target)]['settings']['lock_linkpro']
  if group_linkpro_lock == 'no' then
    return reply_msg(msg.id, '🎖لینک پیشرفته از قبل <code> آزاد </code> است🎖', ok_cb, false)
	else
    data[tostring(target)]['settings']['lock_linkpro'] = 'no'
    save_data(_config.moderation.data, data)
    return '🎖تغییر وضعیت لینک پیشرفته🎖 <code>\n  حذف نشدن لینک پیشرفته \n</code>   	تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end

local function lock_group_operator(msg, data, target)
  if not is_owner(msg) then
    return
  end
local group_operator_lock = data[tostring(target)]['settings']['lock_operator']
  if group_operator_lock == 'yes' then
    return reply_msg(msg.id, '🎖تبلیغات اپراتور از قبل <code> قفل </code> است🎖', ok_cb, false)
  else
   data[tostring(target)]['settings']['lock_operator'] = 'yes'
    save_data(_config.moderation.data, data)
    return '🎖تغییر وضعیت تبلیغات اپراتور🎖 <code>\n  حذف تبلیغات اپراتور \n</code>   	تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end

local function unlock_group_operator(msg, data, target)
  if not is_owner(msg) then
    return
  end
  local group_operator_lock = data[tostring(target)]['settings']['lock_operator']
  if group_operator_lock == 'no' then
    return reply_msg(msg.id, '🎖تبلیغات اپراتور از قبل <code> آزاد </code> است🎖', ok_cb, false)
	else
    data[tostring(target)]['settings']['lock_operator'] = 'no'
    save_data(_config.moderation.data, data)
    return '🎖تغییر وضعیت تبلیغات اپراتور🎖 <code>\n  حذف نشدن تبلیغات اپراتور \n</code>   	تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end

local function lock_group_bots(msg, data, target)
  if not is_owner(msg) then
    return
  end
  local group_bots_lock = data[tostring(target)]['settings']['lock_bots']
  if group_bots_lock == 'yes' then
   return reply_msg(msg.id, '🎖ورود ربات از قبل <code> قفل </code> است🎖', ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_bots'] = 'yes'
    save_data(_config.moderation.data, data)
	return '🎖تغییر وضعیت ورود ربات🎖 <code>\n  حذف ربات \n</code>   	تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end

local function unlock_group_bots(msg, data, target)
  if not is_owner(msg) then
    return
  end
  local group_bots_lock = data[tostring(target)]['settings']['lock_bots']
  if group_bots_lock == 'no' then
    return reply_msg(msg.id, '🎖ورود ربات از قبل <code> آزاد </code> است🎖', ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_bots'] = 'no'
    save_data(_config.moderation.data, data)
	return '🎖تغییر وضعیت ورود ربات🎖 <code>\n  حذف نشدن ربات \n</code>   	تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end

local function lock_group_inline(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_inline_lock = data[tostring(target)]['settings']['lock_inline']
  if group_inline_lock == 'yes' then
   return reply_msg(msg.id,"🎖اینلاین از قبل <code> قفل </code> است", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_inline'] = 'yes'
    save_data(_config.moderation.data, data)
   return '🎖تغییر وضعیت اینلاین🎖 <code>\n  حذف اینلاین \n</code>   	تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end

local function unlock_group_inline(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_inline_lock = data[tostring(target)]['settings']['lock_inline']
  if group_inline_lock == '🔓' then
   return reply_msg(msg.id,"🎖اینلاین از قبل <code> آزاد </code> است", ok_cb, false)
  else
    data[tostring(target)]['settings']['lock_inline'] = '🔓'
    save_data(_config.moderation.data, data)
   return '🎖تغییر وضعیت اینلاین🎖 <code>\n  حذف نشدن اینلاین \n</code>   	تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end

local function lock_group_spam(msg, data, target)
  if not is_momod(msg) then
    return
  end
  if not is_owner(msg) then
    return "تنها برای مدیران"
  end
  local group_spam_lock = data[tostring(target)]['settings']['lock_spam']
  if group_spam_lock == 'yes' then
    return '🎖 ارسال اسپم از قبل <code> قفل </code> است🎖'
  else
    data[tostring(target)]['settings']['lock_spam'] = 'yes'
    save_data(_config.moderation.data, data)
    return '🎖تغییر وضعیت اسپم🎖  <code>\n  قفل اسپم \n</code>    تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end

local function unlock_group_spam(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_spam_lock = data[tostring(target)]['settings']['lock_spam']
  if group_spam_lock == 'no' then
    return '🎖 ارسال اسپم از قبل <code> آزاد </code> است🎖'
  else
    data[tostring(target)]['settings']['lock_spam'] = 'no'
    save_data(_config.moderation.data, data)
    return '🎖تغییر وضعیت اسپم🎖  <code>\n  آزادشدن اسپم \n</code>    تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end


local function lock_group_emoji(msg, data, target)
  if not is_momod(msg) then
    return
  end
  if not is_owner(msg) then
    return "تنها برای مدیران"
  end
  local group_emoji_lock = data[tostring(target)]['settings']['lock_emoji']
  if group_emoji_lock == 'yes' then
    return '🎖 ارسال شکلک از قبل <code> قفل </code> است🎖'
  else
    data[tostring(target)]['settings']['lock_emoji'] = 'yes'
    save_data(_config.moderation.data, data)
    return '🎖تغییر وضعیت شکلک🎖  <code>\n  حذف شکلک \n</code>    تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end

local function unlock_group_emoji(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_emoji_lock = data[tostring(target)]['settings']['lock_emoji']
  if group_emoji_lock == 'no' then
    return '🎖 ارسال شکلک از قبل <code> آزاد </code> است🎖'
  else
    data[tostring(target)]['settings']['lock_emoji'] = 'no'
    save_data(_config.moderation.data, data)
    return '🎖تغییر وضعیت شکلک🎖  <code>\n  حذف نشدن شکلک </code> \n تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end


local function lock_group_badword(msg, data, target)
  if not is_momod(msg) then
    return
  end
  if not is_owner(msg) then
    return "Owners only!"
  end
  local group_badword_lock = data[tostring(target)]['settings']['lock_badword']
  if group_badword_lock == 'yes' then
    return '🎖 ارسال کلمات زشت از قبل <code> قفل </code> است🎖'
  else
    data[tostring(target)]['settings']['lock_badword'] = 'yes'
    save_data(_config.moderation.data, data)
    return '🎖تغییر وضعیت کلمات زشت🎖  <code>\n  حذف کلمات زشت \n</code>    تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end

local function unlock_group_badword(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_badword_lock = data[tostring(target)]['settings']['lock_badword']
  if group_badword_lock == 'no' then
    return '🎖 ارسال کلمات زشت از قبل <code> آزاد </code> است🎖'
  else
    data[tostring(target)]['settings']['lock_badword'] = 'no'
    save_data(_config.moderation.data, data)
    return '🎖تغییر وضعیت کلمات زشت🎖  <code>\n  حذف شدن کلمات زشت \n</code>    تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end

local function lock_group_flood(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_flood_lock = data[tostring(target)]['settings']['flood']
  if group_flood_lock == 'yes' then
    return '🎖حساسیت از قبل <code> قفل </code> است🎖'
  else
    data[tostring(target)]['settings']['flood'] = 'yes'
    save_data(_config.moderation.data, data)
    return '🎖تغییر وضعیت حساسیت🎖  <code>\n  فعال بودن حساسیت \n</code>    تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end

local function unlock_group_flood(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_flood_lock = data[tostring(target)]['settings']['flood']
  if group_flood_lock == 'no' then
    return '🎖حساسیت از قبل <code> آزاد </code> است🎖'
  else
    data[tostring(target)]['settings']['flood'] = 'no'
    save_data(_config.moderation.data, data)
    return '🎖تغییر وضعیت حساسیت🎖  <code>\n  غیرفعال بودن حساسیت \n</code>    تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end

local function lock_group_arabic(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_arabic_lock = data[tostring(target)]['settings']['lock_arabic']
  if group_arabic_lock == 'yes' then
    return '🎖تایپ عربی/فارسی از قبل <code> قفل </code> است🎖'
  else
    data[tostring(target)]['settings']['lock_arabic'] = 'yes'
    save_data(_config.moderation.data, data)
    return '🎖تغییر وضعیت عربی/فارسی🎖  <code>\n  حذف عربی/فارسی \n</code>    تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end

local function unlock_group_arabic(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_arabic_lock = data[tostring(target)]['settings']['lock_arabic']
  if group_arabic_lock == 'no' then
    return '🎖تایپ عربی/فارسی از قبل <code> آزاد </code> است🎖'
  else
    data[tostring(target)]['settings']['lock_arabic'] = 'no'
    save_data(_config.moderation.data, data)
    return '🎖تغییر وضعیت عربی/فارسی🎖  <code>\n  حذف نشدن عربی/فارسی \n</code>    تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end

local function lock_group_tag(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_tag_lock = data[tostring(target)]['settings']['lock_tag']
  if group_tag_lock == 'yes' then
    return '🎖ارسال تگ از قبل <code> قفل </code> است🎖'
  else
    data[tostring(target)]['settings']['lock_tag'] = 'yes'
    save_data(_config.moderation.data, data)
    return '🎖تغییر وضعیت ارسال تگ🎖  <code>\n  حذف تگ \n</code>    تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end

local function unlock_group_tag(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_tag_lock = data[tostring(target)]['settings']['lock_tag']
  if group_tag_lock == 'no' then
    return '🎖ارسال تگ از قبل <code> آزاد </code> است🎖'
  else
    data[tostring(target)]['settings']['lock_tag'] = 'no'
    save_data(_config.moderation.data, data)
    return '🎖تغییر وضعیت ارسال تگ🎖  <code>\n  حذف نشدن تگ \n</code>    تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end

local function lock_group_hashtag(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_hashtag_lock = data[tostring(target)]['settings']['lock_hashtag']
  if group_hashtag_lock == 'yes' then
    return '🎖ارسال هش تگ از قبل <code> قفل </code> است🎖'
  else
    data[tostring(target)]['settings']['lock_hashtag'] = 'yes'
    save_data(_config.moderation.data, data)
    return '🎖تغییر وضعیت ارسال هش تگ🎖  <code>\n  حذف هش تگ \n</code>    تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end

local function unlock_group_hashtag(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_hashtag_lock = data[tostring(target)]['settings']['lock_hashtag']
  if group_hashtag_lock == 'no' then
    return '🎖ارسال هش تگ از قبل <code> آزاد </code> است🎖'
  else
    data[tostring(target)]['settings']['lock_hashtag'] = 'no'
    save_data(_config.moderation.data, data)
    return '🎖تغییر وضعیت ارسال هش تگ🎖  <code>\n  حذف نشدن هش تگ \n</code>    تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end


local function lock_group_fwd(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_fwd_lock = data[tostring(target)]['settings']['lock_fwd']
  if group_fwd_lock == 'yes' then
    return '🎖فروارد از قبل <code> قفل </code> است🎖'
  else
    data[tostring(target)]['settings']['lock_fwd'] = 'yes'
    save_data(_config.moderation.data, data)
    return '🎖تغییر وضعیت فروارد🎖  <code>\n  حذف فروارد \n</code>    تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end

local function unlock_group_fwd(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_fwd_lock = data[tostring(target)]['settings']['lock_fwd']
  if group_fwd_lock == 'no' then
    return '🎖فروارد از قبل <code> آزاد </code> است🎖'
  else
    data[tostring(target)]['settings']['lock_fwd'] = 'no'
    save_data(_config.moderation.data, data)
    return '🎖تغییر وضعیت فروارد🎖  <code>\n  حذف نشدن فروارد \n</code>    تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end

local function lock_group_membermod(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_member_lock = data[tostring(target)]['settings']['lock_member']
  if group_member_lock == 'yes' then
    return '🎖اعضای سوپرگروه از قبل <code> قفل </code> است🎖'
  else
    data[tostring(target)]['settings']['lock_member'] = 'yes'
    save_data(_config.moderation.data, data)
  end
    return '🎖تغییر وضعیت اعضای گروه🎖  <code>\n  حذف اعضای گروه \n</code>    تغییرات توسط @'..(msg.from.username or msg.from.first_name)
end

local function unlock_group_membermod(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_member_lock = data[tostring(target)]['settings']['lock_member']
  if group_member_lock == 'no' then
    return '🎖اعضای سوپرگروه از قبل <code> آزاد </code> است🎖'
  else
    data[tostring(target)]['settings']['lock_member'] = 'no'
    save_data(_config.moderation.data, data)
    return '🎖تغییر وضعیت اعضای گروه🎖  <code>\n  حذف نشدن اعضای گروه \n</code>    تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end

local function lock_group_rtl(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_rtl_lock = data[tostring(target)]['settings']['lock_rtl']
  if group_rtl_lock == 'yes' then
    return '🎖راستچین از قبل <code> قفل </code> است🎖'
  else
    data[tostring(target)]['settings']['lock_rtl'] = 'yes'
    save_data(_config.moderation.data, data)
    return '🎖تغییر وضعیت راستچین🎖  <code>\n  حذف راستچین \n</code>    تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end

local function unlock_group_rtl(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_rtl_lock = data[tostring(target)]['settings']['lock_rtl']
  if group_rtl_lock == 'no' then
    return '🎖راستچین از قبل <code> آزاد </code> است🎖'
  else
    data[tostring(target)]['settings']['lock_rtl'] = 'no'
    save_data(_config.moderation.data, data)
    return '🎖تغییر وضعیت راستچین🎖  <code>\n  حذف نشدن راستچین \n</code>    تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end

local function lock_group_tgservice(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_tgservice_lock = data[tostring(target)]['settings']['lock_tgservice']
  if group_tgservice_lock == 'yes' then
    return '🎖پاک کردن ورود خروج از قبل <code> قفل </code> است🎖'
  else
    data[tostring(target)]['settings']['lock_tgservice'] = 'yes'
    save_data(_config.moderation.data, data)
    return '🎖تغییر وضعیت پاک کردن ورود و خروج🎖  <code>\n  حذف ورود و خروج \n</code>    تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end

local function unlock_group_tgservice(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_tgservice_lock = data[tostring(target)]['settings']['lock_tgservice']
  if group_tgservice_lock == 'no' then
    return '🎖پاک کردن ورود خروج از قبل <code> آزاد </code> است🎖'
  else
    data[tostring(target)]['settings']['lock_tgservice'] = 'no'
    save_data(_config.moderation.data, data)
    return '🎖تغییر وضعیت پاک کردن ورود و خروج🎖  <code>\n  حذف نشدن ورود و خروج </code> \n تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end

local function lock_group_sticker(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_sticker_lock = data[tostring(target)]['settings']['lock_sticker']
  if group_sticker_lock == 'yes' then
    return '🎖استیکر از قبل <code> قفل </code> است🎖'
  else
    data[tostring(target)]['settings']['lock_sticker'] = 'yes'
    save_data(_config.moderation.data, data)
    return '🎖تغییر وضعیت استیکر🎖 <code>\n  حذف استیکر  \n</code> تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end

local function unlock_group_sticker(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_sticker_lock = data[tostring(target)]['settings']['lock_sticker']
  if group_sticker_lock == 'no' then
    return '🎖استیکر از قبل <code> آزاد </code> است🎖'
  else
    data[tostring(target)]['settings']['lock_sticker'] = 'no'
    save_data(_config.moderation.data, data)
    return '🎖تغییر وضعیت استیکر🎖  <code>\n  حذف نشدن استیکر \n</code>   تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end


local function lock_group_reply(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_reply_lock = data[tostring(target)]['settings']['lock_reply']
  if group_reply_lock == 'yes' then
    return '🎖ریپلای از قبل <code> قفل </code> است🎖'
  else
    data[tostring(target)]['settings']['lock_reply'] = 'yes'
    save_data(_config.moderation.data, data)
    return '🎖تغییر وضعیت ریپلای🎖  <code>\n  حذف ریپلای \n</code>    تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end

local function unlock_group_reply(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_reply_lock = data[tostring(target)]['settings']['lock_reply']
  if group_reply_lock == 'no' then
    return '🎖ریپلای از قبل <code> آزاد </code> است🎖'
  else
    data[tostring(target)]['settings']['lock_reply'] = 'no'
    save_data(_config.moderation.data, data)
    return '🎖تغییر وضعیت ریپلای🎖  <code>\n  حذف نشدن ریپلای \n</code>    تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end

local function lock_group_contacts(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_contacts_lock = data[tostring(target)]['settings']['lock_contacts']
  if group_contacts_lock == 'yes' then
    return '🎖ارسال مخاطب از قبل <code> قفل </code> است🎖'
  else
    data[tostring(target)]['settings']['lock_contacts'] = 'yes'
    save_data(_config.moderation.data, data)
    return '🎖تغییر وضعیت ارسال مخاطب🎖  <code>\n  حذف مخاطب \n</code>    تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end

local function unlock_group_contacts(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_contacts_lock = data[tostring(target)]['settings']['lock_contacts']
  if group_contacts_lock == 'no' then
    return '🎖ارسال مخاطب از قبل <code> آزاد </code> است🎖'
  else
    data[tostring(target)]['settings']['lock_contacts'] = 'no'
    save_data(_config.moderation.data, data)
    return '🎖تغییر وضعیت ارسال مخاطب🎖  <code>\n  حذف نشدن مخاطب \n</code>    تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end

local function enable_strict_rules(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_strict_lock = data[tostring(target)]['settings']['strict']
  if group_strict_lock == 'yes' then
    return '🎖تنظیمات سختیگرانه از قبل <code> قفل </code> است🎖'
  else
    data[tostring(target)]['settings']['strict'] = 'yes'
    save_data(_config.moderation.data, data)
    return '🎖تغییر وضعیت تنظیمات سختگیرانه🎖  <code>\n  حذف کاربر \n</code>    تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end

local function disable_strict_rules(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_strict_lock = data[tostring(target)]['settings']['strict']
  if group_strict_lock == 'no' then
    return '🎖تنظیمات سختیگرانه از قبل <code> آزاد </code> است🎖'
  else
    data[tostring(target)]['settings']['strict'] = 'no'
    save_data(_config.moderation.data, data)
    return '🎖تغییر وضعیت تنظیمات سختگیرانه🎖  <code>\n  حذف نشدن کاربر \n</code>    تغییرات توسط @'..(msg.from.username or msg.from.first_name)
  end
end
--End supergroup locks

--'Set supergroup rules' function
local function set_rulesmod(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local data_cat = 'rules'
  data[tostring(target)][data_cat] = rules
  save_data(_config.moderation.data, data)
  return '<code> 🎖قوانین جدید ثبت شد🎖 </code>'
end

--'Get supergroup rules' function
local function get_rules(msg, data)
  local data_cat = 'rules'
  if not data[tostring(msg.to.id)][data_cat] then
    return '<code> 🎖هیچ قانونی موجودنیست🎖 </code>'
  end
  local rules = data[tostring(msg.to.id)][data_cat]
  local group_name = data[tostring(msg.to.id)]['settings']['set_name']
  local rules = group_name..' قوانین🎖:\n\n'..rules:gsub("/n", " ")
  return rules
end

--Set supergroup to public or not public function
local function set_public_membermod(msg, data, target)
  if not is_momod(msg) then
    return "🎖تنها برای مدیران🎖"
  end
  local group_public_lock = data[tostring(target)]['settings']['public']
  local long_id = data[tostring(target)]['long_id']
  if not long_id then
	data[tostring(target)]['long_id'] = msg.to.peer_id
	save_data(_config.moderation.data, data)
  end
  if group_public_lock == 'yes' then
    return '🎖گروه از قبل عمومی است🎖'
  else
    data[tostring(target)]['settings']['public'] = 'yes'
    save_data(_config.moderation.data, data)
  end
  return '🎖گروه حالا عمومی است🎖'
end

local function unset_public_membermod(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_public_lock = data[tostring(target)]['settings']['public']
  local long_id = data[tostring(target)]['long_id']
  if not long_id then
	data[tostring(target)]['long_id'] = msg.to.peer_id
	save_data(_config.moderation.data, data)
  end
  if group_public_lock == 'no' then
    return '🎖گروه عمومی نیست🎖'
  else
    data[tostring(target)]['settings']['public'] = 'no'
	data[tostring(target)]['long_id'] = msg.to.long_id
    save_data(_config.moderation.data, data)
    return '🎖سوپر گروه حالا عمومی نیست🎖'
  end
end

--Show supergroup settings; function
function show_supergroup_settingsmod(msg, target)
 	if not is_momod(msg) then
    	return
  	end
	local data = load_data(_config.moderation.data)
    if data[tostring(target)] then
     	if data[tostring(target)]['settings']['flood_msg_max'] then
        	NUM_MSG_MAX = tonumber(data[tostring(target)]['settings']['flood_msg_max'])
        	print('custom'..NUM_MSG_MAX)
      	else
        	NUM_MSG_MAX = 5
      	end
    end
	local bots_protection = "yes"
    if data[tostring(msg.to.id)]['settings']['lock_bots'] then
     bots_protection = data[tostring(msg.to.id)]['settings']['lock_bots']
    end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_webpage'] then
			data[tostring(target)]['settings']['lock_webpage'] = 'no'
		end
    end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_linkpro'] then
			data[tostring(target)]['settings']['lock_linkpro'] = 'no'
		end
    end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_operator'] then
			data[tostring(target)]['settings']['lock_operator'] = 'no'
		end
    end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_commands'] then
			data[tostring(target)]['settings']['lock_commands'] = 'no'
		end
	end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_inline'] then
			data[tostring(target)]['settings']['lock_inline'] = 'no'
		end
	end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['public'] then
			data[tostring(target)]['settings']['public'] = 'no'
		end
	end
        if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_fwd'] then
			data[tostring(target)]['settings']['lock_fwd'] = 'no'
		end
	end
        if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_tag'] then
			data[tostring(target)]['settings']['lock_tag'] = 'no'
		end
	end
        if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_hashtag'] then
			data[tostring(target)]['settings']['lock_hashtag'] = 'no'
		end
	end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_rtl'] then
			data[tostring(target)]['settings']['lock_rtl'] = 'no'
		end
        end
      if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_tgservice'] then
			data[tostring(target)]['settings']['lock_tgservice'] = 'no'
		end
	end
      if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_contacts'] then
			data[tostring(target)]['settings']['lock_contacts'] = 'no'
		end
	end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_badword'] then
			data[tostring(target)]['settings']['lock_badword'] = 'no'
		end
	end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_emoji'] then
			data[tostring(target)]['settings']['lock_emoji'] = 'no'
		end
	end
      if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_reply'] then
			data[tostring(target)]['settings']['lock_reply'] = 'no'
		end
	end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_member'] then
			data[tostring(target)]['settings']['lock_member'] = 'no'
		end
	end
  local settings = data[tostring(target)]['settings']
  local text = "🎖تنظیمات اصلی سوپر گروه [ <code> "..msg.to.title.." </code> ]🎖 :\n⚓️قفل ها⚓️\n"
  .."🎖#قفل ریپلای : "..settings.lock_reply.."\n"
  .."🎖#قفل ربات : "..bots_protection.."\n"
  .."🎖#قفل دستورات : "..settings.lock_commands.."\n"
  .."🎖#قفل صفحات اینترنتی : "..settings.lock_webpage.."\n"
  .."🎖#قفل لینک پیشرفته : "..settings.lock_linkpro.."\n"
  .."🎖#قفل اپراتور : "..settings.lock_operator.."\n"
  .."🎖#قفل اینلاین : "..settings.lock_inline.."\n"
  .."🎖#قفل مخاطب : "..settings.lock_contacts.."\n"
  .."🎖#قفل لینک : "..settings.lock_link.."\n"
  .."🎖#قفل فروارد : "..settings.lock_fwd.."\n"
.."🎖#قفل هش تگ : "..settings.lock_hashtag.."\n"
.."🎖#قفل تگ : "..settings.lock_tag.."\n"
.."🎖#قفل استیکر : "..settings.lock_sticker.."\n"
.."🎖#قفل حساسیت : "..settings.flood.."\n"
.."🎖#قفل اسپم : "..settings.lock_spam.."\n"
.."🎖#قفل کلمات زشت : "..settings.lock_badword.."\n"
.."🎖#قفل شکلک : "..settings.lock_emoji.."\n"
.."🎖#قفل اعضا : "..settings.lock_member.."\n"
.."🎖#قفل راستچین : "..settings.lock_rtl.."\n"
.."🎖#قفل حذف ورود و خروج : "..settings.lock_tgservice.."\n"
.."🎖#قفل عربی : "..settings.lock_arabic.."\n\n"
.."⚓️اطلاعات بیشتر⚓️\n"
.."🎖#مقدار حساسیت : "..NUM_MSG_MAX.."\n"
.."🎖#عمومی بودن گروه: "..settings.public.."\n"
.."🎖#تنظیمات سختیگرانه: "..settings.strict.."\n"
.."🎖#نوع گروه : سوپرگروه\n"
.."🎖#نام ربات: ژوپتیر(Jove)\n"
.."🎖#ورژن ربات: 6.7\n"
.."🎖#کانال: @JoveCH\n\n"
.."⚓️مشخصات درخواست کننده⚓️\n"
.."🎖#نام کامل : "..msg.from.first_name.." "..(msg.from.last_name or '').."\n"
.."🎖#نام کاربری : @"..(msg.from.username or '')
   local text = string.gsub(text,'yes','|فعال 🔐|')
   local text = string.gsub(text,'no','|غیرفعال🔓|')
  return text
  end

local function promote_admin(receiver, member_username, user_id)
  local data = load_data(_config.moderation.data)
  local group = string.gsub(receiver, 'channel#id', '')
  local member_tag_username = string.gsub(member_username, '@', '(at)')
  if not data[group] then
    return
  end
  if data[group]['moderators'][tostring(user_id)] then
    return send_large_msg(receiver, member_username..' از قبل یک مدیر است.')
  end
  data[group]['moderators'][tostring(user_id)] = member_tag_username
  save_data(_config.moderation.data, data)
end

local function demote_admin(receiver, member_username, user_id)
  local data = load_data(_config.moderation.data)
  local group = string.gsub(receiver, 'channel#id', '')
  if not data[group] then
    return
  end
  if not data[group]['moderators'][tostring(user_id)] then
    return send_large_msg(receiver, member_tag_username..' یک مدیر نیست.')
  end
  data[group]['moderators'][tostring(user_id)] = nil
  save_data(_config.moderation.data, data)
end

local function promote2(receiver, member_username, user_id)
  local data = load_data(_config.moderation.data)
  local group = string.gsub(receiver, 'channel#id', '')
  local member_tag_username = string.gsub(member_username, '@', '(at)')
  if not data[group] then
    return send_large_msg(receiver, '🎖سوپرگروه اضافه نشده است🎖')
  end
  if data[group]['moderators'][tostring(user_id)] then
    return send_large_msg(receiver, member_username..' ازقبل یک مدیر است.')
  end
  data[group]['moderators'][tostring(user_id)] = member_tag_username
  save_data(_config.moderation.data, data)
  send_large_msg(receiver, member_username..' ارتقا داده شد.')
end

local function demote2(receiver, member_username, user_id)
  local data = load_data(_config.moderation.data)
  local group = string.gsub(receiver, 'channel#id', '')
  if not data[group] then
    return send_large_msg(receiver, '🎖گروه اضافه نشده است🎖')
  end
  if not data[group]['moderators'][tostring(user_id)] then
    return send_large_msg(receiver, member_tag_username..' یک مدیرنیست.')
  end
  data[group]['moderators'][tostring(user_id)] = nil
  save_data(_config.moderation.data, data)
  send_large_msg(receiver, member_username..' عزل شد.')
end

local function modlist(msg)
  local data = load_data(_config.moderation.data)
  local groups = "groups"
  if not data[tostring(groups)][tostring(msg.to.id)] then
    return '🎖گروه اضافه نشده است🎖'
  end
  -- determine if table is empty
  if next(data[tostring(msg.to.id)]['moderators']) == nil then
    return '🎖<code> هیچ مدیری در این گروه نیست </code>🎖'
  end
  local i = 1
  local message = '\n<code> 🎖لیست مدیران ' .. string.gsub(msg.to.print_name, '_', ' ') .. '🎖\n'
  for k,v in pairs(data[tostring(msg.to.id)]['moderators']) do
    message = message ..i..' - '..v..' [' ..k.. '] \n'
    i = i + 1
  end
  return message
end

-- Start by reply actions
function get_message_callback(extra, success, result)
	local get_cmd = extra.get_cmd
	local msg = extra.msg
	local data = load_data(_config.moderation.data)
	local print_name = user_print_name(msg.from):gsub("?", "")
	local name_log = print_name:gsub("_", " ")
    if type(result) == 'boolean' then
  		print('This is a old message!')
  		return
  	end
  	if get_cmd == "id" and not result.action then
		local channel = 'channel#id'..result.to.peer_id
		--savelog(msg.to.id, name_log.." ["..msg.from.id.."] obtained id for: ["..result.from.peer_id.."]")
		id1 = send_large_msg(channel, result.from.peer_id)
	elseif get_cmd == 'id' and result.action then
		local action = result.action.type
		if action == 'chat_add_user' or action == 'chat_del_user' or action == 'chat_rename' or action == 'chat_change_photo' then
			if result.action.user then
				user_id = result.action.user.peer_id
			else
				user_id = result.peer_id
			end
			local channel = 'channel#id'..result.to.peer_id
			--savelog(msg.to.id, name_log.." ["..msg.from.id.."] obtained id by service msg for: ["..user_id.."]")
			id1 = send_large_msg(channel, user_id)
		end
        elseif get_cmd == "idfrom" then
		local channel = 'channel#id'..result.to.peer_id
		--savelog(msg.to.id, name_log.." ["..msg.from.id.."] obtained id for msg fwd from: ["..result.fwd_from.peer_id.."]")
		id2 = send_large_msg(channel, result.fwd_from.peer_id)
        elseif get_cmd == 'channel_block' and not result.action then
		local member_id = result.from.peer_id
		local channel_id = result.to.peer_id
    if member_id == msg.from.id then
      return send_large_msg("channel#id"..channel_id, "Leave using kickme command")
    end
    if is_momod2(member_id, channel_id) and not is_admin2(msg.from.id) then
			   return send_large_msg("channel#id"..channel_id, "🎖شما نمیتوانید مقامات بالاتر را اخراج کنید🎖")
    end
    if is_admin2(member_id) then
         return send_large_msg("channel#id"..channel_id, "You can't kick other admins")
    end
		----savelog(msg.to.id, name_log.." ["..msg.from.id.."] kicked: ["..user_id.."] by reply")
		kick_user(member_id, channel_id)
	elseif get_cmd == 'channel_block' and result.action and result.action.type == 'chat_add_user' then
		local user_id = result.action.user.peer_id
		local channel_id = result.to.peer_id
    if member_id == msg.from.id then
      return send_large_msg("channel#id"..channel_id, "Leave using kickme command")
    end
    if is_momod2(member_id, channel_id) and not is_admin2(msg.from.id) then
			   return send_large_msg("channel#id"..channel_id, "🎖شما نمیتوانید مقامات بالاتر را اخراج کنید🎖")
    end
    if is_admin2(member_id) then
         return send_large_msg("channel#id"..channel_id, "🎖شما نمیتوانید مقامات بالاتر را اخراج کنید🎖")
    end
		--savelog(msg.to.id, name_log.." ["..msg.from.id.."] kicked: ["..user_id.."] by reply to sev. msg.")
		kick_user(user_id, channel_id)
	elseif get_cmd == "del" then
		delete_msg(result.id, ok_cb, false)
		--savelog(msg.to.id, name_log.." ["..msg.from.id.."] deleted a message by reply")
	elseif get_cmd == "setadmin" then
		local user_id = result.from.peer_id
		local channel_id = "channel#id"..result.to.peer_id
		channel_set_admin(channel_id, "user#id"..user_id, ok_cb, false)
		if result.from.username then
			text = "🎖 @"..result.from.username.." به عنوان یک ادمین منصوب شد🎖"
		else
			text = "🎖[ "..user_id.." ]به عنوان یک ادمین منصوب شد🎖"
		end
		--savelog(msg.to.id, name_log.." ["..msg.from.id.."] set: ["..user_id.."] as admin by reply")
		send_large_msg(channel_id, text)
	elseif get_cmd == "demoteadmin" then
		local user_id = result.from.peer_id
		local channel_id = "channel#id"..result.to.peer_id
		if is_admin2(result.from.peer_id) then
			return send_large_msg(channel_id, "🎖شما نمیتوانید مقامات بالاتر را اخراج کنید🎖")
		end
		channel_demote(channel_id, "user#id"..user_id, ok_cb, false)
		if result.from.username then
			text = "🎖 @"..result.from.username.." از ادمینی  عزل شد🎖"
		else
			text = "🎖[ "..user_id.." ] از ادمینی عزل شد🎖"
		end
		--savelog(msg.to.id, name_log.." ["..msg.from.id.."] demoted: ["..user_id.."] from admin by reply")
		send_large_msg(channel_id, text)
	elseif get_cmd == "setowner" then
		local group_owner = data[tostring(result.to.peer_id)]['set_owner']
		if group_owner then
		local channel_id = 'channel#id'..result.to.peer_id
			if not is_admin2(tonumber(group_owner)) and not is_support(tonumber(group_owner)) then
				local user = "user#id"..group_owner
				channel_demote(channel_id, user, ok_cb, false)
			end
			local user_id = "user#id"..result.from.peer_id
			channel_set_admin(channel_id, user_id, ok_cb, false)
			data[tostring(result.to.peer_id)]['set_owner'] = tostring(result.from.peer_id)
			save_data(_config.moderation.data, data)
			--savelog(msg.to.id, name_log.." ["..msg.from.id.."] set: ["..result.from.peer_id.."] as owner by reply")
			if result.from.username then
				text = "🎖 @"..result.from.username.." <code>[ "..result.from.peer_id.." ]</code> به عنوان مالک گروه منصوب شد🎖"
			else
				text = "🎖 @"..result.from.username.." <code>[ "..result.from.peer_id.." ]</code> به عنوان مالک گروه منصوب شد🎖"
			end
			send_large_msg(channel_id, text)
		end
	elseif get_cmd == "promote" then
		local receiver = result.to.peer_id
		local full_name = (result.from.first_name or '')..' '..(result.from.last_name or '')
		local member_name = full_name:gsub("?", "")
		local member_username = member_name:gsub("_", " ")
		if result.from.username then
			member_username = '@'.. result.from.username
		end
		local member_id = result.from.peer_id
		if result.to.peer_type == 'channel' then
		--savelog(msg.to.id, name_log.." ["..msg.from.id.."] promoted mod: @"..member_username.."["..result.from.peer_id.."] by reply")
		promote2("channel#id"..result.to.peer_id, member_username, member_id)
	    --channel_set_mod(channel_id, user, ok_cb, false)
		end
	elseif get_cmd == "demote" then
		local full_name = (result.from.first_name or '')..' '..(result.from.last_name or '')
		local member_name = full_name:gsub("?", "")
		local member_username = member_name:gsub("_", " ")
    if result.from.username then
		member_username = '@'.. result.from.username
    end
		local member_id = result.from.peer_id
		--local user = "user#id"..result.peer_id
		--savelog(msg.to.id, name_log.." ["..msg.from.id.."] demoted mod: @"..member_username.."["..user_id.."] by reply")
		demote2("channel#id"..result.to.peer_id, member_username, member_id)
		--channel_demote(channel_id, user, ok_cb, false)
	elseif get_cmd == 'mute_user' then
		if result.service then
			local action = result.action.type
			if action == 'chat_add_user' or action == 'chat_del_user' or action == 'chat_rename' or action == 'chat_change_photo' then
				if result.action.user then
					user_id = result.action.user.peer_id
				end
			end
			if action == 'chat_add_user_link' then
				if result.from then
					user_id = result.from.peer_id
				end
			end
		else
			user_id = result.from.peer_id
		end
		local receiver = extra.receiver
		local chat_id = msg.to.id
		print(user_id)
		print(chat_id)
		if is_muted_user(chat_id, user_id) then
			unmute_user(chat_id, user_id)
			send_large_msg(receiver, "🎖 <code>["..user_id.."]</code> ازلیست ساکت شدگان حذف شد🎖")
		elseif is_admin1(msg) then
			mute_user(chat_id, user_id)
			send_large_msg(receiver, "🎖 <code>["..user_id.."]</code> به لیست ساکت شدگان افزوده شد🎖")
		end
	end
end
-- End by reply actions

--By ID actions
local function cb_user_info(extra, success, result)
	local receiver = extra.receiver
	local user_id = result.peer_id
	local get_cmd = extra.get_cmd
	local data = load_data(_config.moderation.data)
	--[[if get_cmd == "setadmin" then
		local user_id = "user#id"..result.peer_id
		channel_set_admin(receiver, user_id, ok_cb, false)
		if result.username then
			text = "@"..result.username.." has been set as an admin"
		else
			text = "[ "..result.peer_id.." ] has been set as an admin"
		end
			send_large_msg(receiver, text)]]
	if get_cmd == "demoteadmin" then
		if is_admin2(result.peer_id) then
			return send_large_msg(receiver, "🎖شما نمیتوانید مقامات بالاتر را عزل کنید🎖")
		end
		local user_id = "user#id"..result.peer_id
		channel_demote(receiver, user_id, ok_cb, false)
		if result.username then
			text = "🎖 @"..result.username.." از ادمینی عزل  شد🎖"
			send_large_msg(receiver, text)
		else
			text = "🎖 [ "..result.peer_id.." ] از ادمینی عزل شد🎖"
			send_large_msg(receiver, text)
		end
	elseif get_cmd == "promote" then
		if result.username then
			member_username = "@"..result.username
		else
			member_username = string.gsub(result.print_name, '_', ' ')
		end
		promote2(receiver, member_username, user_id)
	elseif get_cmd == "demote" then
		if result.username then
			member_username = "@"..result.username
		else
			member_username = string.gsub(result.print_name, '_', ' ')
		end
		demote2(receiver, member_username, user_id)
	end
end

-- Begin resolve username actions
local function callbackres(extra, success, result)
  local member_id = result.peer_id
  local member_username = "@"..result.username
  local get_cmd = extra.get_cmd
	if get_cmd == "res" then
		local user = result.peer_id
		local name = string.gsub(result.print_name, "_", " ")
		local channel = 'channel#id'..extra.channelid
		send_large_msg(channel, user..'\n'..name)
		return user
	elseif get_cmd == "id" then
		local user = result.peer_id
		local channel = 'channel#id'..extra.channelid
		send_large_msg(channel, user)
		return user
  elseif get_cmd == "invite" then
    local receiver = extra.channel
    local user_id = "user#id"..result.peer_id
    channel_invite(receiver, user_id, ok_cb, false)
	--[[elseif get_cmd == "channel_block" then
		local user_id = result.peer_id
		local channel_id = extra.channelid
    local sender = extra.sender
    if member_id == sender then
      return send_large_msg("channel#id"..channel_id, "Leave using kickme command")
    end
		if is_momod2(member_id, channel_id) and not is_admin2(sender) then
			   return send_large_msg("channel#id"..channel_id, "You can't kick mods/owner/admins")
    end
    if is_admin2(member_id) then
         return send_large_msg("channel#id"..channel_id, "You can't kick other admins")
    end
		kick_user(user_id, channel_id)
	elseif get_cmd == "setadmin" then
		local user_id = "user#id"..result.peer_id
		local channel_id = extra.channel
		channel_set_admin(channel_id, user_id, ok_cb, false)
		if result.username then
			text = "@"..result.username.." has been set as an admin"
			send_large_msg(channel_id, text)
		else
			text = "@"..result.peer_id.." has been set as an admin"
			send_large_msg(channel_id, text)
		end]]
	elseif get_cmd == "setowner" then
		local receiver = extra.channel
		local channel = string.gsub(receiver, 'channel#id', '')
		local from_id = extra.from_id
		local group_owner = data[tostring(channel)]['set_owner']
		if group_owner then
			local user = "user#id"..group_owner
			if not is_admin2(group_owner) and not is_support(group_owner) then
				channel_demote(receiver, user, ok_cb, false)
			end
			local user_id = "user#id"..result.peer_id
			channel_set_admin(receiver, user_id, ok_cb, false)
			data[tostring(channel)]['set_owner'] = tostring(result.peer_id)
			save_data(_config.moderation.data, data)
			--savelog(channel, name_log.." ["..from_id.."] set ["..result.peer_id.."] as owner by username")
		if result.username then
			text = member_username.." <code> [ "..result.peer_id.." ][ "..result.username.." ] </code> به عنوان مالک گروه منصوب شد🎖"
		else
			text = "🎖 <code> [ "..result.peer_id.." ] </code> به عنوان مالک گروه منصوب شد🎖"
		end
		send_large_msg(receiver, text)
  end
	elseif get_cmd == "promote" then
		local receiver = extra.channel
		local user_id = result.peer_id
		--local user = "user#id"..result.peer_id
		promote2(receiver, member_username, user_id)
		--channel_set_mod(receiver, user, ok_cb, false)
	elseif get_cmd == "demote" then
		local receiver = extra.channel
		local user_id = result.peer_id
		local user = "user#id"..result.peer_id
		demote2(receiver, member_username, user_id)
	elseif get_cmd == "demoteadmin" then
		local user_id = "user#id"..result.peer_id
		local channel_id = extra.channel
		if is_admin2(result.peer_id) then
			return send_large_msg(channel_id, "🎖شما نمیتوانید مقامات بالاتر را عزل کنید🎖")
		end
		channel_demote(channel_id, user_id, ok_cb, false)
		if result.username then
			text = "🎖 @"..result.username.." از ادمینی عزل شد🎖"
			send_large_msg(channel_id, text)
		else
			text = "🎖 @"..result.peer_id.." از ادمینی عزل شد🎖"
			send_large_msg(channel_id, text)
		end
		local receiver = extra.channel
		local user_id = result.peer_id
		demote_admin(receiver, member_username, user_id)
	elseif get_cmd == 'mute_user' then
		local user_id = result.peer_id
		local receiver = extra.receiver
		local chat_id = string.gsub(receiver, 'channel#id', '')
		if is_muted_user(chat_id, user_id) then
			unmute_user(chat_id, user_id)
			send_large_msg(receiver, "🎖 <code>["..user_id.."]</code> از لیست ساکت شدگان خارج شد🎖")
		elseif is_owner(extra.msg) then
			mute_user(chat_id, user_id)
			send_large_msg(receiver, "🎖 <code>["..user_id.."]</code> به لیست ساکت شدگان افزوده شد🎖")
		end
	end
end
--End resolve username actions

--Begin non-channel_invite username actions
local function in_channel_cb(cb_extra, success, result)
  local get_cmd = cb_extra.get_cmd
  local receiver = cb_extra.receiver
  local msg = cb_extra.msg
  local data = load_data(_config.moderation.data)
  local print_name = user_print_name(cb_extra.msg.from):gsub("?", "")
  local name_log = print_name:gsub("_", " ")
  local member = cb_extra.username
  local memberid = cb_extra.user_id
  if member then
    text = 'No user @'..member..' in this SuperGroup.'
  else
    text = 'No user ['..memberid..'] in this SuperGroup.'
  end
if get_cmd == "channel_block" then
  for k,v in pairs(result) do
    vusername = v.username
    vpeer_id = tostring(v.peer_id)
    if vusername == member or vpeer_id == memberid then
     local user_id = v.peer_id
     local channel_id = cb_extra.msg.to.id
     local sender = cb_extra.msg.from.id
      if user_id == sender then
        return send_large_msg("channel#id"..channel_id, "Leave using kickme command")
      end
      if is_momod2(user_id, channel_id) and not is_admin2(sender) then
        return send_large_msg("channel#id"..channel_id, "🎖شما نمیتوانید مقامات بالاتر را اخراج کنید🎖")
      end
      if is_admin2(user_id) then
        return send_large_msg("channel#id"..channel_id, "🎖شما نمیتوانید مقامات بالاتر را اخراج کنید🎖")
      end
      if v.username then
        text = ""
        --savelog(msg.to.id, name_log.." ["..msg.from.id.."] kicked: @"..v.username.." ["..v.peer_id.."]")
      else
        text = ""
        --savelog(msg.to.id, name_log.." ["..msg.from.id.."] kicked: ["..v.peer_id.."]")
      end
      kick_user(user_id, channel_id)
      return
    end
  end
elseif get_cmd == "setadmin" then
   for k,v in pairs(result) do
    vusername = v.username
    vpeer_id = tostring(v.peer_id)
    if vusername == member or vpeer_id == memberid then
      local user_id = "user#id"..v.peer_id
      local channel_id = "channel#id"..cb_extra.msg.to.id
      channel_set_admin(channel_id, user_id, ok_cb, false)
      if v.username then
        text = "🎖 @"..v.username.." ["..v.peer_id.."] از ادمینی عزل شد🎖"
        --savelog(msg.to.id, name_log.." ["..msg.from.id.."] set admin @"..v.username.." ["..v.peer_id.."]")
      else
        text = "🎖 ["..v.peer_id.."] از ادمینی عزل شد🎖"
        --savelog(msg.to.id, name_log.." ["..msg.from.id.."] set admin "..v.peer_id)
      end
	  if v.username then
		member_username = "@"..v.username
	  else
		member_username = string.gsub(v.print_name, '_', ' ')
	  end
		local receiver = channel_id
		local user_id = v.peer_id
		promote_admin(receiver, member_username, user_id)

    end
    send_large_msg(channel_id, text)
    return
 end
 elseif get_cmd == 'setowner' then
	for k,v in pairs(result) do
		vusername = v.username
		vpeer_id = tostring(v.peer_id)
		if vusername == member or vpeer_id == memberid then
			local channel = string.gsub(receiver, 'channel#id', '')
			local from_id = cb_extra.msg.from.id
			local group_owner = data[tostring(channel)]['set_owner']
			if group_owner then
				if not is_admin2(tonumber(group_owner)) and not is_support(tonumber(group_owner)) then
					local user = "user#id"..group_owner
					channel_demote(receiver, user, ok_cb, false)
				end
					local user_id = "user#id"..v.peer_id
					channel_set_admin(receiver, user_id, ok_cb, false)
					data[tostring(channel)]['set_owner'] = tostring(v.peer_id)
					save_data(_config.moderation.data, data)
					--savelog(channel, name_log.."["..from_id.."] set ["..v.peer_id.."] as owner by username")
				if result.username then
					text = member_username.." <code>["..v.peer_id.."]["..v.username.."]</code> به عنوان مالک منصوب شد🎖"
				else
					text = "🎖 <code> ["..v.peer_id.."] </code> به عنوان مالک منصوب شد🎖"
				end
			end
		elseif memberid and vusername ~= member and vpeer_id ~= memberid then
			local channel = string.gsub(receiver, 'channel#id', '')
			local from_id = cb_extra.msg.from.id
			local group_owner = data[tostring(channel)]['set_owner']
			if group_owner then
				if not is_admin2(tonumber(group_owner)) and not is_support(tonumber(group_owner)) then
					local user = "user#id"..group_owner
					channel_demote(receiver, user, ok_cb, false)
				end
				data[tostring(channel)]['set_owner'] = tostring(memberid)
				save_data(_config.moderation.data, data)
				--savelog(channel, name_log.."["..from_id.."] set ["..memberid.."] as owner by username")
				text = "🎖 <code> ["..memberid.."]["..member.."] </code> به عنوان مالک منصوب شد🎖"
			end
		end
	end
 end
send_large_msg(receiver, text)
end
--End non-channel_invite username actions

--'Set supergroup photo' function
local function set_supergroup_photo(msg, success, result)
  local data = load_data(_config.moderation.data)
  if not data[tostring(msg.to.id)] then
      return
  end
  local receiver = get_receiver(msg)
  if success then
    local file = 'data/photos/channel_photo_'..msg.to.id..'.jpg'
    print('File downloaded to:', result)
    os.rename(result, file)
    print('File moved to:', file)
    channel_set_photo(receiver, file, ok_cb, false)
    data[tostring(msg.to.id)]['settings']['set_photo'] = file
    save_data(_config.moderation.data, data)
    send_large_msg(receiver, 'Photo saved!', ok_cb, false)
  else
    print('Error downloading: '..msg.id)
    send_large_msg(receiver, 'Failed, please try again!', ok_cb, false)
  end
end

--Run function
local function run(msg, matches)

local bot_id = 152133506
local rlm = 143124135

if matches[1]:lower() == 'join' and matches[2] and is_admin(msg) then
        channel_invite('channel#id'..matches[2], 'user#id'..msg.from.id, ok_cb, false)
      end
if matches[1]:lower() == 'leave' and matches[2] and is_sudo(msg) then
                          leave_channel('channel#id'..matches[2], ok_cb, false)
                          apileavechat(msg, '-100'..matches[2])
                      return 'Done\nI Exited the Group : '..matches[2]
                  elseif matches[1]:lower() == 'leave' and not matches[2] and is_admin(msg) then
                    leave_channel('channel#id'..msg.to.id, ok_cb, false)
                    apileavechat(msg, '-100'..msg.to.id)
                  end 
				  
if matches[1]:lower() == 'setexpire' then
    if not is_sudo(msg) then return end
    local time = os.time()
    local buytime = tonumber(os.time())
    local timeexpire = tonumber(buytime) + (tonumber(matches[2]) * 86400)
    redis:hset('expiretime',get_receiver(msg),timeexpire)
    return reply_msg(msg.id, "🎖گروه برای <code> "..matches[2].." </code> روز شارژ شد🎖", ok_cb, false)
  end
  if matches[1]:lower() == 'expire' then
    local expiretime = redis:hget ('expiretime', get_receiver(msg))
    if not expiretime then return 'Unlimited' else
      local now = tonumber(os.time())
      return (math.floor((tonumber(expiretime) - tonumber(now)) / 86400) + 1) .. " روز"
    end
  end

  if matches[1]:lower() == '1m' and matches[2] then
    if not is_sudo(msg) then return end
    local time = os.time()
    local buytime = tonumber(os.time())
    local timeexpire = tonumber(buytime) + (tonumber(1 * 30) * 86400)
    redis:hset('expiretime','channel#id'..matches[2],timeexpire)
    send_large_msg('channel#id'..matches[2], 'گروه برای <code>30</code> روز شارژ شد🎖', ok_cb, false)
    return reply_msg(msg.id, 'Done', ok_cb, false)
  end

  if matches[1]:lower() == '3m' and matches[2] then
    if not is_sudo(msg) then return end
    local time = os.time()
    local buytime = tonumber(os.time())
    local timeexpire = tonumber(buytime) + (tonumber(3 * 30) * 86400)
    redis:hset('expiretime','channel#id'..matches[2],timeexpire)
    send_large_msg('channel#id'..matches[2], ' گروه برای <code>90</code> روز شارژ شد🎖', ok_cb, false)
    return reply_msg(msg.id, 'Done', ok_cb, false)
  end
  if matches[1]:lower() == 'unlimite' and matches[2] then
    if not is_sudo(msg) then return end
    local time = os.time()
    local buytime = tonumber(os.time())
    local timeexpire = tonumber(buytime) + (tonumber(2 * 99999999999) * 86400)
    redis:hset('expiretime','channel#id'..matches[2],timeexpire)
    send_large_msg('channel#id'..matches[2], ' گروه به صورت <code> نامحدود </code> شارژ شد🎖', ok_cb, false)
    return reply_msg(msg.id, 'Done', ok_cb, false)
  end


	if msg.to.type == 'chat' then
		if matches[1] == 'تبدیل به سوپرگروه' then
			if not is_admin1(msg) then
				return
			end
			local receiver = get_receiver(msg)
			chat_upgrade(receiver, ok_cb, false)
		end
	elseif msg.to.type == 'channel'then
		if matches[1] == 'تبدیل به سوپرگروه' then
			if not is_admin1(msg) then
				return
			end
			return "Already a SuperGroup"
		end
	end
	if msg.to.type == 'channel' then
	local support_id = msg.from.id
	local receiver = get_receiver(msg)
	local print_name = user_print_name(msg.from):gsub("?", "")
	local name_log = print_name:gsub("_", " ")
	local data = load_data(_config.moderation.data)
	local creed = "channel#id"..1066944384
    local text_rem = '🎖گروه جدید حذف شد🎖\n <i>🎖مشخصات گروه</i> :\n🎖#ایدی گروه: <code>'..msg.to.id..'</code> \n🎖#اسم گروه : <b>'..msg.to.title..'</b> \n🎖مشخصات حذف کننده\n🎖#ایدی کاربر : <code>'..msg.from.id..'</code> \n🎖#نام کاربری: '..(msg.from.username or '')..'\n🎖شما میتوانید با استفاده از دستور /leave'..msg.to.id..' ربات را خارج کنید🎖 \n🎖شما میتوانید با دستور /join'..msg.to.id..' درآن عضو شوید🎖 \n🎖و برای شارژبرای یکماه آن از دستور /1m '..msg.to.id..'استفاده کنید\nانجام شد !'
	local text_add = '🎖گروه جدید اضافه شد🎖\n <i>🎖مشخصات گروه</i> :\n🎖#ایدی گروه: <code>'..msg.to.id..'</code> \n🎖#اسم گروه : <b>'..msg.to.title..'</b> \n🎖مشخصات اضافه کننده\n🎖#ایدی کاربر : <code>'..msg.from.id..'</code> \n🎖#نام کاربری: '..(msg.from.username or '')..'\n🎖شما میتوانید با استفاده از دستور /leave'..msg.to.id..' ربات را خارج کنید🎖 \n🎖شما میتوانید با دستور /join'..msg.to.id..' درآن عضو شوید🎖 \n🎖و برای شارژبرای یکماه آن از دستور /1m '..msg.to.id..'استفاده کنید\nانجام شد !'
		if matches[1] == 'اضافه' and not matches[2] then
			if not is_admin1(msg) and not is_support(support_id) then
				return
			end
			if is_super_group(msg) then
				return reply_msg(msg.id, '🎖سوپرگروه پیش از این <code>اضافه شده</code> است🎖', ok_cb, false)
			end
			print("🎖سوپرگروه "..msg.to.print_name.."("..msg.to.id..") اضافه شده است🎖")
            send_msg(creed, text_add, ok_cb, false)
			superadd(msg)
			set_mutes(msg.to.id)
			channel_set_admin(receiver, 'user#id'..msg.from.id, ok_cb, false)
		end

		if matches[1] == 'حذف گروه' and is_admin1(msg) and not matches[2] then
			if not is_super_group(msg) then
				return reply_msg(msg.id, '🎖سوپرگروه اضافه نشده است🎖', ok_cb, false)
			end
			print("🎖سوپرگروه "..msg.to.print_name.."("..msg.to.id..") حذف شد🎖")
			superrem(msg)
			send_msg(creed, text_rem, ok_cb, false)
			rem_mutes(msg.to.id)
		end

		if not data[tostring(msg.to.id)] then
			return
		end
		if matches[1] == "مشخصات گروه" then
			if not is_owner(msg) then
				return
			end
			--savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested SuperGroup info")
			channel_info(receiver, callback_info, {receiver = receiver, msg = msg})
		end

		if matches[1] == "ادمین ها" then
			if not is_owner(msg) and not is_support(msg.from.id) then
				return
			end
			member_type = 'Admins'
			--savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested SuperGroup Admins list")
			admins = channel_get_admins(receiver,callback, {receiver = receiver, msg = msg, member_type = member_type})
		end

		if matches[1] == "مالک" then
			local group_owner = data[tostring(msg.to.id)]['set_owner']
			if not group_owner then
				return "🎖هیچ مالکی پیدا نشد.برای تعیین مالک به یکی از مدیران ربات اطلاع دهید=> @JoveTGBot 🎖"
			end
			--savelog(msg.to.id, name_log.." ["..msg.from.id.."] used /owner")
			return "🎖مالک سوپرگروه=> ["..group_owner..']'
		end

		if matches[1] == "لیست مدیران" then
			--savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested group modlist")
			return modlist(msg)
			-- channel_get_admins(receiver,callback, {receiver = receiver})
		end

		if matches[1] == "ربات ها" and is_momod(msg) then
			member_type = 'Bots'
			--savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested SuperGroup bots list")
			channel_get_bots(receiver, callback, {receiver = receiver, msg = msg, member_type = member_type})
		end

		if matches[1] == "افراد" and not matches[2] and is_momod(msg) then
			local user_id = msg.from.peer_id
			--savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested SuperGroup users list")
			channel_get_users(receiver, callback_who, {receiver = receiver})
		end

		if matches[1] == "اخراج شده ها" and is_momod(msg) then
			--savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested Kicked users list")
			channel_get_kicked(receiver, callback_kicked, {receiver = receiver})
		end

		if matches[1] == 'دیلیت' and is_momod(msg) then
			if type(msg.reply_id) ~= "nil" then
				local cbreply_extra = {
					get_cmd = 'del',
					msg = msg
				}
				delete_msg(msg.id, ok_cb, false)
				get_message(msg.reply_id, get_message_callback, cbreply_extra)
			end
		end

		if matches[1] == 'بلاک' and is_momod(msg) then
			if type(msg.reply_id) ~= "nil" then
				local cbreply_extra = {
					get_cmd = 'channel_block',
					msg = msg
				}
				get_message(msg.reply_id, get_message_callback, cbreply_extra)
			elseif matches[1] == 'بلاک' and matches[2] and string.match(matches[2], '^%d+$') then
				--[[local user_id = matches[2]
				local channel_id = msg.to.id
				if is_momod2(user_id, channel_id) and not is_admin2(user_id) then
					return send_large_msg(receiver, "You can't kick mods/owner/admins")
				end
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] kicked: [ user#id"..user_id.." ]")
				kick_user(user_id, channel_id)]]
				local get_cmd = 'channel_block'
				local msg = msg
				local user_id = matches[2]
				channel_get_users (receiver, in_channel_cb, {get_cmd=get_cmd, receiver=receiver, msg=msg, user_id=user_id})
			elseif matches[1] == "بلاک" and matches[2] and not string.match(matches[2], '^%d+$') then
			--[[local cbres_extra = {
					channelid = msg.to.id,
					get_cmd = 'channel_block',
					sender = msg.from.id
				}
			    local username = matches[2]
				local username = string.gsub(matches[2], '@', '')
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] kicked: @"..username)
				resolve_username(username, callbackres, cbres_extra)]]
			local get_cmd = 'channel_block'
			local msg = msg
			local username = matches[2]
			local username = string.gsub(matches[2], '@', '')
			channel_get_users (receiver, in_channel_cb, {get_cmd=get_cmd, receiver=receiver, msg=msg, username=username})
			end
		end

		if matches[1] == 'ایدی' then
			if type(msg.reply_id) ~= "nil" and is_momod(msg) and not matches[2] then
				local cbreply_extra = {
					get_cmd = 'id',
					msg = msg
				}
				get_message(msg.reply_id, get_message_callback, cbreply_extra)
			elseif type(msg.reply_id) ~= "nil" and matches[2] == "از" and is_momod(msg) then
				local cbreply_extra = {
					get_cmd = 'idfrom',
					msg = msg
				}
				get_message(msg.reply_id, get_message_callback, cbreply_extra)
			elseif msg.text:match("@[%a%d]") then
				local cbres_extra = {
					channelid = msg.to.id,
					get_cmd = 'id'
				}
				local username = matches[2]
				local username = username:gsub("@","")
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested ID for: @"..username)
				resolve_username(username,  callbackres, cbres_extra)
			else
				return "🎖#ایدی گروه: \n<code> "..msg.to.id.." \n</code> 🎖#اسم گروه: \n<code> "..msg.to.title.." \n</code> 🎖#نام شما: \n<code>"..(msg.from.first_name or '')..""..(msg.from.first_namr or '').." \n</code> 🎖#ایدی شما:  \n<code> "..msg.from.id.." \n</code>🎖#نام کاربری شما: \n@"..(msg.from.username or '')..""
				end
		end

		if matches[1] == 'اخراجم کن' then
			if msg.to.type == 'channel' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] left via kickme")
				channel_kick("channel#id"..msg.to.id, "user#id"..msg.from.id, ok_cb, false)
			end
		end

		if matches[1] == 'لینک جدید' and is_momod(msg)then
			local function callback_link (extra , success, result)
			local receiver = get_receiver(msg)
				if success == 0 then
					send_large_msg(receiver, '<code> 🎖خطا!انجام نشد🎖 </code> \n🎖دلیل:ربات سازنده نیست\n🎖راه حل:بااستفاده از دستور <code> تنظیم لینک </code> لینک خود را تنظیم کنید')
					data[tostring(msg.to.id)]['settings']['set_link'] = nil
					save_data(_config.moderation.data, data)
				else
					send_large_msg(receiver, "Created a new link")
					data[tostring(msg.to.id)]['settings']['set_link'] = result
					save_data(_config.moderation.data, data)
				end
			end
			--savelog(msg.to.id, name_log.." ["..msg.from.id.."] attempted to create a new SuperGroup link")
			export_channel_link(receiver, callback_link, false)
		end

		if matches[1] == 'تنظیم لینک' and is_owner(msg) then
			data[tostring(msg.to.id)]['settings']['set_link'] = 'waiting'
			save_data(_config.moderation.data, data)
			return 'Please send the new group link now'
		end

		if msg.text then
			if msg.text:match("^([https?://w]*.?telegram.me/joinchat/%S+)$") and data[tostring(msg.to.id)]['settings']['set_link'] == 'waiting' and is_owner(msg) then
				data[tostring(msg.to.id)]['settings']['set_link'] = msg.text
				save_data(_config.moderation.data, data)
				return "🎖لینک جدید ثبت شد🎖"
			end
		end

		if matches[1] == 'لینک' then
			if not is_momod(msg) then
				return
			end
			local group_link = data[tostring(msg.to.id)]['settings']['set_link']
			if not group_link then
				return "🎖با دستور  <code> تنظیم لینک </code> لینک خود را ثبت کنید🎖"
			end
			--savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested group link ["..group_link.."]")
			return "<i> 🎖لینک گروه🎖 </i> \n"..group_link
		end

		if matches[1] == "دعوت" and is_sudo(msg) then
			local cbres_extra = {
				channel = get_receiver(msg),
				get_cmd = "invite"
			}
			local username = matches[2]
			local username = username:gsub("@","")
			--savelog(msg.to.id, name_log.." ["..msg.from.id.."] invited @"..username)
			resolve_username(username,  callbackres, cbres_extra)
		end

		if matches[1] == 'اطلاعات' and is_owner(msg) then
			local cbres_extra = {
				channelid = msg.to.id,
				get_cmd = 'res'
			}
			local username = matches[2]
			local username = username:gsub("@","")
			--savelog(msg.to.id, name_log.." ["..msg.from.id.."] resolved username: @"..username)
			resolve_username(username,  callbackres, cbres_extra)
		end

		if matches[1] == 'اخراج' and is_momod(msg) then
			local receiver = channel..matches[3]
			local user = "user#id"..matches[2]
			chaannel_kick(receiver, user, ok_cb, false)
		end

			if matches[1] == 'تنظیم ادمین' then
				if not is_support(msg.from.id) and not is_owner(msg) then
					return
				end
			if type(msg.reply_id) ~= "nil" then
				local cbreply_extra = {
					get_cmd = 'setadmin',
					msg = msg
				}
				setadmin = get_message(msg.reply_id, get_message_callback, cbreply_extra)
			elseif matches[1] == 'تنظیم ادمین' and matches[2] and string.match(matches[2], '^%d+$') then
			--[[]	local receiver = get_receiver(msg)
				local user_id = "user#id"..matches[2]
				local get_cmd = 'setadmin'
				user_info(user_id, cb_user_info, {receiver = receiver, get_cmd = get_cmd})]]
				local get_cmd = 'setadmin'
				local msg = msg
				local user_id = matches[2]
				channel_get_users (receiver, in_channel_cb, {get_cmd=get_cmd, receiver=receiver, msg=msg, user_id=user_id})
			elseif matches[1] == 'تنظیم ادمین' and matches[2] and not string.match(matches[2], '^%d+$') then
				--[[local cbres_extra = {
					channel = get_receiver(msg),
					get_cmd = 'setadmin'
				}
				local username = matches[2]
				local username = string.gsub(matches[2], '@', '')
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] set admin @"..username)
				resolve_username(username, callbackres, cbres_extra)]]
				local get_cmd = 'setadmin'
				local msg = msg
				local username = matches[2]
				local username = string.gsub(matches[2], '@', '')
				channel_get_users (receiver, in_channel_cb, {get_cmd=get_cmd, receiver=receiver, msg=msg, username=username})
			end
		end

		if matches[1] == 'عزل ادمین' then
			if not is_support(msg.from.id) and not is_owner(msg) then
				return
			end
			if type(msg.reply_id) ~= "nil" then
				local cbreply_extra = {
					get_cmd = 'demoteadmin',
					msg = msg
				}
				demoteadmin = get_message(msg.reply_id, get_message_callback, cbreply_extra)
			elseif matches[1] == 'عزل ادمین' and matches[2] and string.match(matches[2], '^%d+$') then
				local receiver = get_receiver(msg)
				local user_id = "user#id"..matches[2]
				local get_cmd = 'demoteadmin'
				user_info(user_id, cb_user_info, {receiver = receiver, get_cmd = get_cmd})
			elseif matches[1] == 'عزل ادمین' and matches[2] and not string.match(matches[2], '^%d+$') then
				local cbres_extra = {
					channel = get_receiver(msg),
					get_cmd = 'demoteadmin'
				}
				local username = matches[2]
				local username = string.gsub(matches[2], '@', '')
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] demoted admin @"..username)
				resolve_username(username, callbackres, cbres_extra)
			end
		end

		if matches[1] == 'تنظیم مالک' and is_owner(msg) then
			if type(msg.reply_id) ~= "nil" then
				local cbreply_extra = {
					get_cmd = 'setowner',
					msg = msg
				}
				setowner = get_message(msg.reply_id, get_message_callback, cbreply_extra)
			elseif matches[1] == 'تنظیم مالک' and matches[2] and string.match(matches[2], '^%d+$') then
		local group_owner = data[tostring(msg.to.id)]['set_owner']
				if group_owner then
					local receiver = get_receiver(msg)
					local user_id = "user#id"..group_owner
					if not is_admin2(group_owner) and not is_support(group_owner) then
						channel_demote(receiver, user_id, ok_cb, false)
					end
					local user = "user#id"..matches[2]
					channel_set_admin(receiver, user, ok_cb, false)
					data[tostring(msg.to.id)]['set_owner'] = tostring(matches[2])
					save_data(_config.moderation.data, data)
					--savelog(msg.to.id, name_log.." ["..msg.from.id.."] set ["..matches[2].."] as owner")
					local text = "🎖<code>[ "..matches[2].." ]</code> به عنوان مالک منصوب شد🎖"
					return text
				end
				local	get_cmd = 'setowner'
				local	msg = msg
				local user_id = matches[2]
				channel_get_users (receiver, in_channel_cb, {get_cmd=get_cmd, receiver=receiver, msg=msg, user_id=user_id})
			elseif matches[1] == 'تنظیم مالک' and matches[2] and not string.match(matches[2], '^%d+$') then
				local	get_cmd = 'setowner'
				local	msg = msg
				local username = matches[2]
				local username = string.gsub(matches[2], '@', '')
				channel_get_users (receiver, in_channel_cb, {get_cmd=get_cmd, receiver=receiver, msg=msg, username=username})
			end
		end

		if matches[1] == 'ارتقا' then
		  if not is_momod(msg) then
				return
			end
			if not is_owner(msg) then
				return "🎖تنها مالک میتوانید ارتقا دهد🎖"
			end
			if type(msg.reply_id) ~= "nil" then
				local cbreply_extra = {
					get_cmd = 'promote',
					msg = msg
				}
				promote = get_message(msg.reply_id, get_message_callback, cbreply_extra)
			elseif matches[1] == 'ارتقا' and matches[2] and string.match(matches[2], '^%d+$') then
				local receiver = get_receiver(msg)
				local user_id = "user#id"..matches[2]
				local get_cmd = 'promote'
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] promoted user#id"..matches[2])
				user_info(user_id, cb_user_info, {receiver = receiver, get_cmd = get_cmd})
			elseif matches[1] == 'ارتقا' and matches[2] and not string.match(matches[2], '^%d+$') then
				local cbres_extra = {
					channel = get_receiver(msg),
					get_cmd = 'promote',
				}
				local username = matches[2]
				local username = string.gsub(matches[2], '@', '')
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] promoted @"..username)
				return resolve_username(username, callbackres, cbres_extra)
			end
		end

		if matches[1] == 'mp' and is_sudo(msg) then
			channel = get_receiver(msg)
			user_id = 'user#id'..matches[2]
			channel_set_mod(channel, user_id, ok_cb, false)
			return "ok"
		end
		if matches[1] == 'md' and is_sudo(msg) then
			channel = get_receiver(msg)
			user_id = 'user#id'..matches[2]
			channel_demote(channel, user_id, ok_cb, false)
			return "ok"
		end

		if matches[1] == 'عزل' then
			if not is_momod(msg) then
				return
			end
			if not is_owner(msg) then
				return "🎖تنها مالک میتواند عزل کند🎖"
			end
			if type(msg.reply_id) ~= "nil" then
				local cbreply_extra = {
					get_cmd = 'demote',
					msg = msg
				}
				demote = get_message(msg.reply_id, get_message_callback, cbreply_extra)
			elseif matches[1] == 'عزل' and matches[2] and string.match(matches[2], '^%d+$') then
				local receiver = get_receiver(msg)
				local user_id = "user#id"..matches[2]
				local get_cmd = 'demote'
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] demoted user#id"..matches[2])
				user_info(user_id, cb_user_info, {receiver = receiver, get_cmd = get_cmd})
			elseif matches[1] == 'عزل' and matches[2] and not string.match(matches[2], '^%d+$') then
				local cbres_extra = {
					channel = get_receiver(msg),
					get_cmd = 'demote'
				}
				local username = matches[2]
				local username = string.gsub(matches[2], '@', '')
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] demoted @"..username)
				return resolve_username(username, callbackres, cbres_extra)
			end
		end

		if matches[1] == "تنظیم نام" and is_momod(msg) then
			local receiver = get_receiver(msg)
			local set_name = string.gsub(matches[2], '_', '')
			--savelog(msg.to.id, name_log.." ["..msg.from.id.."] renamed SuperGroup to: "..matches[2])
			rename_channel(receiver, set_name, ok_cb, false)
		end

		if msg.service and msg.action.type == 'chat_rename' then
			--savelog(msg.to.id, name_log.." ["..msg.from.id.."] renamed SuperGroup to: "..msg.to.title)
			data[tostring(msg.to.id)]['settings']['set_name'] = msg.to.title
			save_data(_config.moderation.data, data)
		end

		if matches[1] == "تنظیم درباره" and is_momod(msg) then
			local receiver = get_receiver(msg)
			local about_text = matches[2]
			local data_cat = 'description'
			local target = msg.to.id
			data[tostring(target)][data_cat] = about_text
			save_data(_config.moderation.data, data)
			--savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup description to: "..about_text)
			channel_set_about(receiver, about_text, ok_cb, false)
			return "<code> 🎖توضیحات ثبت شد🎖 </code> \n\nچت را بسته  وازنو باز کنید تا تغییرات را ببینید"
		end

		if matches[1] == "تنظیم نام کاربری" and is_admin1(msg) then
			local function ok_username_cb (extra, success, result)
				local receiver = extra.receiver
				if success == 1 then
					send_large_msg(receiver, "🎖نام کاربری گروه تنظیم شد🎖\n\nچت را بسته و از نو باز کنید تا تغییرات را ببینید")
				elseif success == 0 then
					send_large_msg(receiver, "🎖ناتوان در تنظیم نام کاربری🎖\nشاید نام کاربری از قبل پر شده باشد\n\nیادداشت: برای نام کاربری میتوانید از a-z, 0-9 و آندرلاین(_) استفاده کنید.\nحداقل کارکترها 5کارکتر است.")
				end
			end
			local username = string.gsub(matches[2], '@', '')
			channel_set_username(receiver, username, ok_username_cb, {receiver=receiver})
		end

		if matches[1] == 'تنظیم قوانین' and is_momod(msg) then
			rules = matches[2]
			local target = msg.to.id
			--savelog(msg.to.id, name_log.." ["..msg.from.id.."] has changed group rules to ["..matches[2].."]")
			return set_rulesmod(msg, data, target)
		end

		if msg.media then
			if msg.media.type == 'photo' and data[tostring(msg.to.id)]['settings']['set_photo'] == 'waiting' and is_momod(msg) then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] set new SuperGroup photo")
				load_photo(msg.id, set_supergroup_photo, msg)
				return
			end
		end
		if matches[1] == 'تنظیم عکس' and is_momod(msg) then
			data[tostring(msg.to.id)]['settings']['set_photo'] = 'waiting'
			save_data(_config.moderation.data, data)
			--savelog(msg.to.id, name_log.." ["..msg.from.id.."] started setting new SuperGroup photo")
			return '🎖عکس گروه را ارسال کنید🎖'
		end

		if matches[1] == 'پاک کردن' then
			if not is_momod(msg) then
				return
			end
			if is_momod(msg) then
			if matches[2] == 'بن' and is_momod(msg) then 
        local hash = 'banned'
        local data_cat = 'banlist'
           data[tostring(msg.to.id)][data_cat] = nil
           save_data(_config.moderation.data, data)
           send_large_msg(get_receiver(msg), "🎖لیست بن پاک شد")
           redis:del(hash)
     end
			if matches[2] == 'گولبال بن' and is_sudo(msg) then 
        local hash = 'gbanned'
        local data_cat = 'gbanlist'
           data[tostring(msg.to.id)][data_cat] = nil
           save_data(_config.moderation.data, data)
           send_large_msg(get_receiver(msg), "🎖لیست گولبال بن پاک شد🎖")
           redis:del(hash)
     end
	 
			if matches[2] == 'مدیران' then
				if next(data[tostring(msg.to.id)]['moderators']) == nil then
					return '🎖هیچ مدیری در این گروه نیست🎖'
				end
				for k,v in pairs(data[tostring(msg.to.id)]['moderators']) do
					data[tostring(msg.to.id)]['moderators'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] cleaned modlist")
				return '🎖لیست مدیران پاک شد🎖'
			end
			if matches[2] == 'قوانین' then
				local data_cat = 'rules'
				if data[tostring(msg.to.id)][data_cat] == nil then
					return "🎖قوانین تنظیم نشده است🎖"
				end
				data[tostring(msg.to.id)][data_cat] = nil
				save_data(_config.moderation.data, data)
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] cleaned rules")
				return '🎖قوانین پاک شد'
			end
			if matches[2] == 'درباره' then
				local receiver = get_receiver(msg)
				local about_text = ' '
				local data_cat = 'description'
				if data[tostring(msg.to.id)][data_cat] == nil then
					return '🎖درباره تنظیم نشده است🎖'
				end
				data[tostring(msg.to.id)][data_cat] = nil
				save_data(_config.moderation.data, data)
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] cleaned about")
				channel_set_about(receiver, about_text, ok_cb, false)
				return "🎖درباره پاک شد🎖"
			end
			if matches[2] == 'ساکت شدگان' then
				chat_id = msg.to.id
				local hash =  'mute_user:'..chat_id
					redis:del(hash)
				return "Mutelist Cleaned"
			end
			if matches[2] == 'نام کاربری' and is_admin1(msg) then
				local function ok_username_cb (extra, success, result)
					local receiver = extra.receiver
					if success == 1 then
						send_large_msg(receiver, "🎖نام کاربری حذف شد🎖")
					elseif success == 0 then
						send_large_msg(receiver, "🎖ناتوان در پاک کردن نام کاربری🎖")
					end
				end
				local username = ""
				channel_set_username(receiver, username, ok_username_cb, {receiver=receiver})
			end
			if matches[2] == "ربات ها" and is_momod(msg) then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] kicked all SuperGroup bots")
				channel_get_bots(receiver, callback_clean_bots, {msg = msg})
			end
		end
            if matches[2] == "اعضا" and is_sudo(msg) then
                --savelog(msg.to.id, name_log.." ["..msg.from.id.."] kicked all SuperGroup members")
                channel_get_users(receiver, callback_clean_members, {msg = msg})
         end
            if matches[2] == "دیلیت شده ها" and is_momod(msg) then
                --savelog(msg.to.id, name_log.." ["..msg.from.id.."] kicked all SuperGroup Deleted Accounts !")
                channel_get_users(receiver, check_member_super_deleted,{receiver = receiver, msg = msg})
         end
		end


		if matches[1] == 'قفل' and is_momod(msg) then
			local target = msg.to.id
			if matches[2] == 'لینک' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked link posting ")
				return lock_group_links(msg, data, target)
			end
			if matches[2] == 'دستورات' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked commands ")
				return lock_group_commands(msg, data, target)
			end
			if matches[2] == 'صفحات اینترنتی' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] lock webpage ")
				return lock_group_webpage(msg, data, target)
			end
			if matches[2] == 'لینک پیشرفته' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] lock linkpro ")
				return lock_group_linkpro(msg, data, target)
			end
			if matches[2] == 'ربات ها' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked adding bots ")
				return lock_group_bots(msg, data, target)
			end
			if matches[2] == 'اپراتور' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] lock operator ")
				return lock_group_operator(msg, data, target)
			end
			if matches[2] == 'اینلاین' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked inline posting")
				return lock_group_inline(msg, data, target)
			end
			if matches[2] == 'اسپم' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked spam ")
				return lock_group_spam(msg, data, target)
			end
			if matches[2] == 'حساسیت' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked flood ")
				return lock_group_flood(msg, data, target)
			end
			if matches[2] == 'فارسی' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked arabic ")
				return lock_group_arabic(msg, data, target)
			end
                         if matches[2] == 'تگ' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked tag ")
				return lock_group_tag(msg, data, target)
			end
                         if matches[2] == 'فروارد' then
                                 --savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked fwd ")
                                 return lock_group_fwd(msg, data, target)
                         end
                         if matches[2] == 'هش تگ' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked hashtag ")
				return lock_group_hashtag(msg, data, target)
			end
                         if matches[2] == 'ریپلای' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked reply ")
				return lock_group_reply(msg, data, target)
			end
			if matches[2] == 'اعضا' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked member ")
				return lock_group_membermod(msg, data, target)
			end
			if matches[2]:lower() == 'راستچین' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked rtl chars. in names")
				return lock_group_rtl(msg, data, target)
			end
			if matches[2] == 'حذف ورود و خروج' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked Tgservice Actions")
				return lock_group_tgservice(msg, data, target)
			end

			if matches[2] == 'استیکر' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked sticker posting")
				return lock_group_sticker(msg, data, target)
			end
			if matches[2] == 'کلمات زشت' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked badword Actions")
				return lock_group_badword(msg, data, target)
			end

			if matches[2] == 'شکلک' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked emoji posting")
				return lock_group_emoji(msg, data, target)
			end
			if matches[2] == 'مخاطب' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked contact posting")
				return lock_group_contacts(msg, data, target)
			end
			if matches[2] == 'سختگیرانه' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked enabled strict settings")
				return enable_strict_rules(msg, data, target)
			end
			
		end

		if matches[1] == 'بازکردن' and is_momod(msg) then
			local target = msg.to.id
			if matches[2] == 'لینک' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked link posting")
				return unlock_group_links(msg, data, target)
			end
			if matches[2] == 'دستورات' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked commands")
				return unlock_group_commands(msg, data, target)
			end
			if matches[2] == 'صفحات اینترنتی' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlock webpage")
				return unlock_group_webpage(msg, data, target)
			end
			if matches[2] == 'لینک پیشرفته' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlock linkpro")
				return unlock_group_linkpro(msg, data, target)
			end
			if matches[2] == 'اپراتور' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlock operator")
				return unlock_group_operator(msg, data, target)
			end
			if matches[2] == 'ربات ها' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked adding bots")
				return unlock_group_bots(msg, data, target)
			end
			if matches[2] == 'اینلاین' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked inline posting")
				return unlock_group_inline(msg, data, target)
			end
			if matches[2] == 'کلمات زشت' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked badword posting")
				return unlock_group_badword(msg, data, target)
			end
			if matches[2] == 'شکلک' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked emoji posting")
				return unlock_group_emoji(msg, data, target)
			end
			if matches[2] == 'اسپم' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked spam")
				return unlock_group_spam(msg, data, target)
			end
			if matches[2] == 'حساسیت' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked flood")
				return unlock_group_flood(msg, data, target)
			end
			if matches[2] == 'فارسی' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked Arabic")
				return unlock_group_arabic(msg, data, target)
			end
                        if matches[2] == 'هش تگ' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked hashtag")
				return unlock_group_hashtag(msg, data, target)
			end
                        if matches[2] == 'ریپلای' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked reply")
				return unlock_group_reply(msg, data, target)
			end
			if matches[2] == 'تگ' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked tag")
				return unlock_group_tag(msg, data, target)
			end
      if matches[2] == 'فروارد' then
        --savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked fwd")
        return unlock_group_fwd(msg, data, target)
      end
			if matches[2] == 'اعضا' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked member ")
				return unlock_group_membermod(msg, data, target)
			end
			if matches[2]:lower() == 'راستچین' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked RTL chars. in names")
				return unlock_group_rtl(msg, data, target)
			end
				if matches[2] == 'حذف ورود و خروج' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked tgservice actions")
				return unlock_group_tgservice(msg, data, target)
			end
			if matches[2] == 'استیکر' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked sticker posting")
				return unlock_group_sticker(msg, data, target)
			end
			if matches[2] == 'مخاطب' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked contact posting")
				return unlock_group_contacts(msg, data, target)
			end
			if matches[2] == 'سختگیرانه' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked disabled strict settings")
				return disable_strict_rules(msg, data, target)
			end
		end

		if matches[1] == 'تنظیم حساسیت' then
			if not is_momod(msg) then
				return
			end
			if tonumber(matches[2]) < 4 or tonumber(matches[2]) > 25 then
				return "🎖عدد انتخابی باید بین[4-25]باشد🎖"
			end
			local flood_max = matches[2]
			data[tostring(msg.to.id)]['settings']['flood_msg_max'] = flood_max
			save_data(_config.moderation.data, data)
			--savelog(msg.to.id, name_log.." ["..msg.from.id.."] set flood to ["..matches[2].."]")
			return '🎖حساسیت تنظیم شد بر روی: '..matches[2]
		end
		if matches[1] == 'عمومی' and is_momod(msg) then
			local target = msg.to.id
			if matches[2] == 'بله' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] set group to: public")
				return set_public_membermod(msg, data, target)
			end
			if matches[2] == 'خیر' then
				--savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: not public")
				return unset_public_membermod(msg, data, target)
			end
		end

		if matches[1] == 'ممنوعیت' and is_momod(msg) then
			local chat_id = msg.to.id
			if matches[2] == 'صدا' then
			local msg_type = 'Audio'
				if not is_muted(chat_id, msg_type..': yes') then
					--savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: mute "..msg_type)
					mute(chat_id, msg_type)
					return "<code> 🎖صداها پاک خواهند شد🎖 </code>"
				else
					return "<code> 🎖صداها از قبل پاک میشدند🎖 </code>"
				end
			end
			if matches[2] == 'عکس' then
			local msg_type = 'Photo'
				if not is_muted(chat_id, msg_type..': yes') then
					--savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: mute "..msg_type)
					mute(chat_id, msg_type)
					return "<code> 🎖تصاویر پاک خواهند شد🎖 </code>"
				else
					return "<code> 🎖تصاویر از قبل پاک میشدند🎖 </code>"
				end
			end
			if matches[2] == 'فیلم' then
			local msg_type = 'Video'
				if not is_muted(chat_id, msg_type..': yes') then
					--savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: mute "..msg_type)
					mute(chat_id, msg_type)
					return "<code> 🎖فیلم ها پاک خواهند شد🎖 </code>"
				else
					return "<code> 🎖فیلم ها از قبل پاک میشدند🎖 </code>"
				end
			end
			if matches[2] == 'گیف' then
			local msg_type = 'Gifs'
				if not is_muted(chat_id, msg_type..': yes') then
					--savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: mute "..msg_type)
					mute(chat_id, msg_type)
					return "<code> 🎖گیف ها پاک خواهند شد🎖 </code>"
				else
					return "<code> 🎖گیف ها از قبل پاک میشدند🎖 </code>"
				end
			end
			if matches[2] == 'فایل' then
			local msg_type = 'Documents'
				if not is_muted(chat_id, msg_type..': yes') then
					--savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: mute "..msg_type)
					mute(chat_id, msg_type)
					return "<code> 🎖فایل ها پاک خواهند شد🎖 </code>"
				else
					return "<code> 🎖فایل هااز قبل پاک میشدند🎖 </code>"
				end
			end
			if matches[2] == 'متن' then
			local msg_type = 'Text'
				if not is_muted(chat_id, msg_type..': yes') then
					--savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: mute "..msg_type)
					mute(chat_id, msg_type)
					return "<code> 🎖متن ها پاک خواهند شد🎖 </code>"
				else
					return "<code> 🎖متن هااز قبل پاک میشدند🎖 </code>"
					end
			end
			if matches[2] == 'همه' then
			local msg_type = 'All'
				if not is_muted(chat_id, msg_type..': yes') then
					--savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: mute "..msg_type)
					mute(chat_id, msg_type)
					return "<code> 🎖همه چیز پاک خواهد شد🎖 </code>"
				else
					return "<code> 🎖همه چیز از قبل پاک میشد🎖 </code>"
				end
			end
		end
		if matches[1] == '-ممنوعیت' and is_momod(msg) then
			local chat_id = msg.to.id
			if matches[2] == 'صدا' then
			local msg_type = 'Audio'
				if is_muted(chat_id, msg_type..': yes') then
					--savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: unmute "..msg_type)
					unmute(chat_id, msg_type)
					return "<code> 🎖صداها پاک نخواهند شد🎖 </code>"
				else
					return "<code> 🎖صداها از قبل پاک نمیشدند🎖 </code>"
				end
			end
			if matches[2] == 'عکس' then
			local msg_type = 'Photo'
				if is_muted(chat_id, msg_type..': yes') then
					--savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: unmute "..msg_type)
					unmute(chat_id, msg_type)
					return "<code> 🎖تصاویر پاک نخواهند شد🎖 </code>"
				else
					return "<code> 🎖تصاویر از قبل پاک نمیشدند🎖 </code>"
				end
			end
			if matches[2] == 'فیلم' then
			local msg_type = 'Video'
				if is_muted(chat_id, msg_type..': yes') then
					--savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: unmute "..msg_type)
					unmute(chat_id, msg_type)
					return "<code> 🎖فیلم ها پاک نخواهند شد🎖 </code>"
				else
					return "<code> 🎖فیلم هااز قبل پاک نمیشدند🎖 </code>"
				end
			end
			if matches[2] == 'گیف' then
			local msg_type = 'Gifs'
				if is_muted(chat_id, msg_type..': yes') then
					--savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: unmute "..msg_type)
					unmute(chat_id, msg_type)
					return "<code> 🎖گیف ها پاک نخواهند شد🎖 </code>"
				else
					return "<code> 🎖گیف هااز قبل پاک نمیشدند🎖 </code>"
				end
			end
			if matches[2] == 'فایل' then
			local msg_type = 'Documents'
				if is_muted(chat_id, msg_type..': yes') then
					--savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: unmute "..msg_type)
					unmute(chat_id, msg_type)
					return "<code> 🎖فایل ها پاک نخواهند شد🎖 </code>"
				else
					return "<code> 🎖فایل از قبل پاک نمیشدند🎖 </code>"
				end
			end
			if matches[2] == 'متن' then
			local msg_type = 'Text'
				if is_muted(chat_id, msg_type..': yes') then
					--savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: unmute message")
					unmute(chat_id, msg_type)
					return "<code> 🎖متن ها پاک نخواهند شد🎖 </code>"
				else
					return "<code> 🎖متن هااز قبل پاک نمیشدند🎖 </code>"
				end
			end
			if matches[2] == 'همه' then
			local msg_type = 'All'
				if is_muted(chat_id, msg_type..': yes') then
					--savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: unmute "..msg_type)
					unmute(chat_id, msg_type)
					return "<code> 🎖همه چیز پاک نخواهد شد🎖 </code>"
				else
					return "<code> 🎖همه چیز از قبل پاک نمیشد🎖 </code>"
				end
			end
		end


		if matches[1] == "ساکت کردن" and is_momod(msg) then
			local chat_id = msg.to.id
			local hash = "mute_user"..chat_id
			local user_id = ""
			if type(msg.reply_id) ~= "nil" then
				local receiver = get_receiver(msg)
				local get_cmd = "mute_user"
				muteuser = get_message(msg.reply_id, get_message_callback, {receiver = receiver, get_cmd = get_cmd, msg = msg})
			elseif matches[1] == "ساکت کردن" and matches[2] and string.match(matches[2], '^%d+$') then
				local user_id = matches[2]
				if is_muted_user(chat_id, user_id) then
					unmute_user(chat_id, user_id)
					--savelog(msg.to.id, name_log.." ["..msg.from.id.."] removed ["..user_id.."] from the muted users list")
					return "🎖["..user_id.."] از لیست کاربران خفه شد پاک شد🎖"
				elseif is_owner(msg) then
					mute_user(chat_id, user_id)
					--savelog(msg.to.id, name_log.." ["..msg.from.id.."] added ["..user_id.."] to the muted users list")
					return "🎖["..user_id.."] به لیست کاربران خفه شد اضافه شد🎖"
				end
			elseif matches[1] == "ساکت کردن" and matches[2] and not string.match(matches[2], '^%d+$') then
				local receiver = get_receiver(msg)
				local get_cmd = "mute_user"
				local username = matches[2]
				local username = string.gsub(matches[2], '@', '')
				resolve_username(username, callbackres, {receiver = receiver, get_cmd = get_cmd, msg=msg})
			end
		end

		if matches[1] == "لیست ممنوعیت" and is_momod(msg) then
			local chat_id = msg.to.id
			if not has_mutes(chat_id) then
				set_mutes(chat_id)
				return mutes_list(chat_id)
			end
			--savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested SuperGroup muteslist")
			return mutes_list(chat_id)
		end
		if matches[1] == "لیست ساکت شدگان" and is_momod(msg) then
			local chat_id = msg.to.id
			--savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested SuperGroup mutelist")
			return muted_user_list(chat_id)
		end

		if matches[1] == 'تنظیمات' and is_momod(msg) then
			local target = msg.to.id
			--savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested SuperGroup settings ")
			return show_supergroup_settingsmod(msg, target)
		end

		if matches[1] == 'قوانین' then
			--savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested group rules")
			return get_rules(msg, data)
		end

		if matches[1] == 'help' and not is_owner(msg) then
			text = "It's Special for Owners and Admins . if you want to see my Commands Please send the /help to my Private"
			reply_msg(msg.id, text, ok_cb, false)
		elseif matches[1] == 'help' and is_owner(msg) then
			local name_log = user_print_name(msg.from)
			--savelog(msg.to.id, name_log.." ["..msg.from.id.."] Used /superhelp")
			return super_help()
		end

		if matches[1] == 'peer_id' and is_admin1(msg)then
			text = msg.to.peer_id
			reply_msg(msg.id, text, ok_cb, false)
			post_large_msg(receiver, text)
		end

		if matches[1] == 'msg.to.id' and is_admin1(msg) then
			text = msg.to.id
			reply_msg(msg.id, text, ok_cb, false)
			post_large_msg(receiver, text)
		end

		--Admin Join Service Message
		if msg.service then
		local action = msg.action.type
			if action == 'chat_add_user_link' then
				if is_owner2(msg.from.id) then
					local receiver = get_receiver(msg)
					local user = "user#id"..msg.from.id
					--savelog(msg.to.id, name_log.." Admin ["..msg.from.id.."] joined the SuperGroup via link")
					channel_set_admin(receiver, user, ok_cb, false)
				end
				if is_support(msg.from.id) and not is_owner2(msg.from.id) then
					local receiver = get_receiver(msg)
					local user = "user#id"..msg.from.id
					--savelog(msg.to.id, name_log.." Support member ["..msg.from.id.."] joined the SuperGroup")
					channel_set_mod(receiver, user, ok_cb, false)
				end
			end
			if action == 'chat_add_user' then
				if is_owner2(msg.action.user.id) then
					local receiver = get_receiver(msg)
					local user = "user#id"..msg.action.user.id
					--savelog(msg.to.id, name_log.." Admin ["..msg.action.user.id.."] added to the SuperGroup by [ "..msg.from.id.." ]")
					channel_set_admin(receiver, user, ok_cb, false)
				end
				if is_support(msg.action.user.id) and not is_owner2(msg.action.user.id) then
					local receiver = get_receiver(msg)
					local user = "user#id"..msg.action.user.id
					--savelog(msg.to.id, name_log.." Support member ["..msg.action.user.id.."] added to the SuperGroup by [ "..msg.from.id.." ]")
					channel_set_mod(receiver, user, ok_cb, false)
				end
			end
		end
		if matches[1] == 'msg.to.peer_id' and is_sudo(msg) then
			post_large_msg(receiver, msg.to.peer_id)
		end
	end
end

local function pre_process(msg)
  if not msg.text and msg.media then
    msg.text = '['..msg.media.type..']'
  end
  return msg
end

return {
  patterns = {
	"^(اضافه)$",
	"^(حذف گروه)$",
	"^(انتقال) (.*)$",
	"^(مشخصات گروه)$",
	"^(ادمین ها)$",
	"^(مالک)$",
	"^(لیست مدیران)$",
	"^(ربات ها)$",
	"^(افراد)$",
	"^(اخراج شده ها)$",
    "^(بلاک) (.*)",
	"^(بلاک)",
    "^(اخراج) (.*)",
	"^(اخراج)",
	"^(تبدیل به سوپرگروه)$",
	"^(ایدی) (.*)$",
	"^(ایدی)$",
	"^(لینک جدید)$",
	"^(تنظیم لینک)$",
	"^(لینک)$",
	"^(اطلاعات) (.*)$",
	"^(تنظیم ادمین) (.*)$",
	"^(تنظیم ادمین)",
	"^(عزل ادمین) (.*)$",
	"^(عزل ادمین)",
	"^(تنظیم مالک) (.*)$",
	"^(تنظیم مالک)$",
	"^(ارتقا) (.*)$",
	"^(ارتقا)",
	"^(عزل) (.*)$",
	"^(عزل)",
	"^(تنظیم نام) (.*)$",
	"^(تنظیم درباره) (.*)$",
	"^(تنظیم قوانین) (.*)$",
	"^(تنظیم عکس)$",
	"^(تنظیم نام کاربری) (.*)$",
	"^(دیلیت)$",
	"^(قفل) (.*)$",
	"^(بازکردن) (.*)$",
	"^(ممنوعیت) ([^%s]+)$",
	"^(-ممنوعیت) ([^%s]+)$",
	"^(ساکت کردن)$",
	"^(ساکت کردن) (.*)$",
	"^(عمومی) (.*)$",
	"^(تنظیمات)$",
	"^(قوانین)$",
	"^(تنظیم حساسیت) (%d+)$",
	"^(پاک کردن) (.*)$",
	"^(لیست ممنوعیت)$",
	"^(لیست ساکت شدگان)$",
    "[#!/](mp) (.*)",
	"[#!/](md) (.*)",
	"^([Uu]nlimite)(%d+)(.*)$",
    "^([Uu]nlimite)(%d+) (.*)$",
  "^([Uu]nlimite)(%d+)$",
  	"^[/!#]([Uu]nlimite)(%d+)(.*)$",
    "^[/!#]([Uu]nlimite)(%d+) (.*)$",
  "^[/!#]([Uu]nlimite)(%d+)$",
  "^([Ll]eave)(%d+) (.*)$",
  "^([Ll]eave)(%d+)(.*)$",
  "^([Ll]eave)(%d+)$",
"^([Ll]eave)$",
  "^[/!#]([Ll]eave)(%d+) (.*)$",
  "^[/!#]([Ll]eave)(%d+)(.*)$",
  "^[/!#]([Ll]eave)(%d+)$",
"^[/!#]([Ll]eave)$",
  "^([Jj]oin)(%d+)$",
     "^(3[Mm])(%d+)(.*)$",
    "^(3[Mm])(%d+) (.*)$",
  "^(3[Mm])(%d+)$",
  "^(1[Mm])(%d+)(.*)$",
  "^(1[Mm])(%d+) (.*)$",
  "^(1[Mm])(%d+)$",
  "^([Jj]oin)(%d+)$",
    "^[/!#]([Jj]oin)(%d+)$",
     "^[/!#](3[Mm])(%d+)(.*)$",
    "^[/!#](3[Mm])(%d+) (.*)$",
  "^[/!#](3[Mm])(%d+)$",
  "^[/!#](1[Mm])(%d+)(.*)$",
  "^[/!#](1[Mm])(%d+) (.*)$",
  "^[/!#](1[Mm])(%d+)$",
  "^[/!#]([Jj]oin)(%d+)$",
	 "^([https?://w]*.?telegram.me/joinchat/%S+)$",
	--"msg.to.peer_id",
	"%[(document)%]",
	"%[(photo)%]",
	"%[(video)%]",
	"%[(audio)%]",
	"%[(contact)%]",
	"^!!tgservice (.+)$",
  },
  run = run,
  pre_process = pre_process
}
--End supergrpup.lua
--By @vVv_ERPO_vVv POUYA POORRAHMAN V6.7