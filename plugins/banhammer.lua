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
local function pre_process(msg)
  local data = load_data(_config.moderation.data)
     if data[tostring(msg.to.id)] then
       if data[tostring(msg.to.id)]['settings'] then
         if data[tostring(msg.to.id)]['settings']['lock_bots'] then
           bots_protection = data[tostring(msg.to.id)]['settings']['lock_bots']
          end
        end
      end
   if msg.from.username ~= nil and bots_protection == "yes" then
        local user_id = msg.from.id
        local chat_id = msg.to.id
            if string.sub(msg.from.username, (string.len(msg.from.username)-2), string.len(msg.from.username)):lower() == "bot" and not is_momod2(user_id, chat_id) then
                kick_user(user_id, chat_id)
				 kick_user(user_id, chat_id)
				  kick_user(user_id, chat_id)
    end
  end
  -- SERVICE MESSAGE
  if msg.action and msg.action.type then
    local action = msg.action.type
    -- Check if banned user joins chat by link
    if action == 'chat_add_user_link' then
      local user_id = msg.from.id
      print('Checking invited user '..user_id)
      local banned = is_banned(user_id, msg.to.id)
      if banned or is_gbanned(user_id) then -- Check it with redis
      print('User is banned!')
      local print_name = user_print_name(msg.from):gsub("‮", "")
	  local name = print_name:gsub("_", "")
      savelog(msg.to.id, name.." ["..msg.from.id.."] is banned and kicked ! ")-- Save to logs
      kick_user(user_id, msg.to.id)
	  kick_user(user_id, msg.to.id)
      end
    end
    -- Check if banned user joins chat
    if action == 'chat_add_user' then
      local user_id = msg.action.user.id
      print('Checking invited user '..user_id)
      local banned = is_banned(user_id, msg.to.id)
      if banned and not is_momod2(msg.from.id, msg.to.id) or is_gbanned(user_id) and not is_admin2(msg.from.id) then -- Check it with redis
        print('User is banned!')
      local print_name = user_print_name(msg.from):gsub("‮", "")
	  local name = print_name:gsub("_", "")
        savelog(msg.to.id, name.." ["..msg.from.id.."] added a banned user >"..msg.action.user.id)-- Save to logs
        kick_user(user_id, msg.to.id)
        local banhash = 'addedbanuser:'..msg.to.id..':'..msg.from.id
        redis:incr(banhash)
        local banhash = 'addedbanuser:'..msg.to.id..':'..msg.from.id
        local banaddredis = redis:get(banhash)
        if banaddredis then
          if tonumber(banaddredis) >= 4 and not is_owner(msg) then
            kick_user(msg.from.id, msg.to.id)-- Kick user who adds ban ppl more than 3 times
          end
          if tonumber(banaddredis) >=  8 and not is_owner(msg) then
            ban_user(msg.from.id, msg.to.id)-- Kick user who adds ban ppl more than 7 times
            local banhash = 'addedbanuser:'..msg.to.id..':'..msg.from.id
            redis:set(banhash, 0)-- Reset the Counter
          end
        end
      end
     if data[tostring(msg.to.id)] then
       if data[tostring(msg.to.id)]['settings'] then
         if data[tostring(msg.to.id)]['settings']['lock_bots'] then
           bots_protection = data[tostring(msg.to.id)]['settings']['lock_bots']
          end
        end
      end
    if msg.action.user.username ~= nil then
      if string.sub(msg.action.user.username:lower(), -3) == 'bot' and not is_momod(msg) and bots_protection == "yes" then --- Will kick bots added by normal users
          local print_name = user_print_name(msg.from):gsub("‮", "")
		  local name = print_name:gsub("_", "")
          savelog(msg.to.id, name.." ["..msg.from.id.."] added a bot > @".. msg.action.user.username)-- Save to logs
          kick_user(msg.action.user.id, msg.to.id)
		  kick_user(msg.action.user.id, msg.to.id)
      end
   end
 end
    -- No further checks
  return msg
  end
  -- banned user is talking !
  if msg.to.type == 'chat' or msg.to.type == 'channel' then
    local group = msg.to.id
    local texttext = 'groups'
    --if not data[tostring(texttext)][tostring(msg.to.id)] and not is_realm(msg) then -- Check if this group is one of my groups or not
    --chat_del_user('chat#id'..msg.to.id,'user#id'..our_id,ok_cb,false)
    --return
    --end
    local user_id = msg.from.id
    local chat_id = msg.to.id
    local banned = is_banned(user_id, chat_id)
    if banned or is_gbanned(user_id) then -- Check it with redis
      print('Banned user talking!')
      local print_name = user_print_name(msg.from):gsub("‮", "")
	  local name = print_name:gsub("_", "")
      savelog(msg.to.id, name.." ["..msg.from.id.."] banned user is talking !")-- Save to logs
      kick_user(user_id, chat_id)
	   kick_user(user_id, chat_id)
      msg.text = ''
    end
  end
  return msg
end

local function banall_by_reply(extra, success, result)
	if result.to.peer_type == 'chat' or result.to.peer_type == 'channel' then
		local chat = 'chat#id'..result.to.peer_id
		local channel = 'channel#id'..result.to.peer_id
	if tonumber(result.from.peer_id) == tonumber(our_id) then -- Ignore bot
			return
	end
	if is_admin2(result.from.peer_id) then -- Ignore admins
		return
	end
		banall_user(result.from.peer_id)
		send_large_msg(chat, "User "..result.from.peer_id.." Golobally Banned")
		send_large_msg(channel, "🎖<i> کاربر از تمامی گروه های </i> [ @JoveTG ] <i> محروم شد </i>🎖\n><i> ایدی کاربر: </i> [<b>"..result.from.peer_id.."</b>]")
	else
		return
	end
end

local function unbanall_by_reply(extra, success, result)
	if result.to.peer_type == 'chat' or result.to.peer_type == 'channel' then
	local user_id = result.from.peer_id
		local chat = 'chat#id'..result.to.peer_id
		local channel = 'channel#id'..result.to.peer_id
	if tonumber(result.from.peer_id) == tonumber(our_id) then -- Ignore bot
			return
	end
	if is_admin2(result.from.peer_id) then -- Ignore admins
		return
	end
     if not is_gbanned(result.from.peer_id) then
       return '🎖<i> کاربر مورد نظر در لیست مسدودیت دائمی ربات </i> [ @JoveTG ] <i> قرار ندارد </i>\n><i> شناسه کاربری: </i> [<b>'..result.from.peer_id..'</b>]'
      end
	  if is_gbanned(result.from.peer_id) then
		unbanall_user(result.from.peer_id)
		send_large_msg(chat, "User "..result.from.peer_id.." Golobally un-Banned")
		send_large_msg(channel, "🎖<i> کاربر مورد نظر در لیست مسدودیت دائمی ربات </i> [ @JoveTG ] <i> قرار ندارد </i>🎖\n><i> شناسه کاربری: </i> [<b>"..result.from.peer_id.."</b>]")
	end
	end
end

local function unban_by_reply(extra, success, result)
	if result.to.peer_type == 'chat' or result.to.peer_type == 'channel' then
		local chat = 'chat#id'..result.to.peer_id
		local channel = 'channel#id'..result.to.peer_id
	if tonumber(result.from.peer_id) == tonumber(our_id) then -- Ignore bot
			return
	end
	if is_admin2(result.from.peer_id) then -- Ignore admins
		return
	end
		send_large_msg(chat, "User "..result.from.peer_id.." un-Banned")
		send_large_msg(channel, "🎖<i> دسترسی کاربر برای ورود به گروه بازگردانده شد </i>🎖\n><i> شناسه کاربری: </i> [<b>"..result.from.peer_id.."</b>]")
		local hash =  'banned:'..result.to.peer_id
		redis:srem(hash, result.from.peer_id)
	else
		return
	end
end

local function kick_ban_res(extra, success, result)
      local chat_id = extra.chat_id
	  local chat_type = extra.chat_type
	  if chat_type == "chat" then
		receiver = 'chat#id'..chat_id
	  else
		receiver = 'channel#id'..chat_id
	  end
	  if success == 0 then
		return send_large_msg(receiver, "<i> 🎖این کاربر با این یوزرنیم یافت نشد </i>")
	  end
      local member_id = result.peer_id
      local user_id = member_id
      local member = result.username
	  local from_id = extra.from_id
      local get_cmd = extra.get_cmd
       if get_cmd == "kick" then
         if member_id == from_id then
            send_large_msg(receiver, "<i> 🎖شما مجاز به اخراج کردن خود از گروه نیستید </i>")
			return
         end
         if is_momod2(member_id, chat_id) and not is_admin2(sender) then
            send_large_msg(receiver, "<i> 🎖شما نمیتوانید دسترسی  مدیران/مالک گروه/ادمین ها را برای ورود به این گروه مسدود کنید </i>")
			return
         end
		 kick_user(member_id, chat_id)
      elseif get_cmd == 'ban' then
        if is_momod2(member_id, chat_id) and not is_admin2(sender) then
			send_large_msg(receiver, "<i> 🎖شما نمیتوانید دسترسی  مدیران/مالک گروه/ادمین ها را برای ورود به این گروه مسدود کنید </i>")
			return
        end
        send_large_msg(receiver, '🎖<i> دسترسی کاربر برای ورود به گروه مسدود شد </i> \n><i> یوزرنیم: </i> [@'..member..']\n><i> شناسه کاربری: </i> [<b>'..member_id..'</b>]')
		ban_user(member_id, chat_id)
      elseif get_cmd == 'unban' then
        send_large_msg(receiver, '🎖<i> دسترسی کاربر برای ورود به گروه بازگردانده شد </i> \n><i> یوزرنیم: </i> [@'..member..']\n><i> شناسه کاربری: </i> [<b>'..member_id..'</b>]')
        local hash =  'banned:'..chat_id
        redis:srem(hash, member_id)
        return '<i> دسترسی کاربر برای ورود به گروه بازگردانده شد </i> \n<i> شناسه کاربری: </i>: ['..user_id..' ]'
      elseif get_cmd == 'banall' then
        send_large_msg(receiver, '🎖<i> دسترسی کاربر برای ورود به تمامی گروه های ربات </i> [ @JoveTG ] <i> مسدود شد </i>\n><i> یوزرنیم: </i> [@'..member..']\n><i> شناسه کاربری: </i> [<b>'..member_id..'</b>]')
		banall_user(member_id)
		kick_user(member_id, msg.to.id)
      elseif get_cmd == 'unbanall' then
        send_large_msg(receiver, '🎖<i> دسترسی کاربر برای ورود به تمامی گروه های ربات </i> [ @JoveTG ] <i> بازگردانده شد </i> \n><i> یوزرنیم: </i> [@'..member..']\n><i> شناسه کاربری: </i> [<b>'..member_id..'</b>]')
	    unbanall_user(member_id)
    end
end

local function run(msg, matches)
local support_id = msg.from.id
 if matches[1]:lower() == 'id' and msg.to.type == "chat" or msg.to.type == "user" then
    if msg.to.type == "user" then
      return 
    end
    if type(msg.reply_id) ~= "nil" then
      local print_name = user_print_name(msg.from):gsub("‮", "")
	  local name = print_name:gsub("_", "")
        savelog(msg.to.id, name.." ["..msg.from.id.."] used /id ")
        id = get_message(msg.reply_id,get_message_callback_id, false)
    elseif matches[1]:lower() == 'id' then
      local name = user_print_name(msg.from)
      savelog(msg.to.id, name.." ["..msg.from.id.."] used /id ")
return
end
  end
  if matches[1]:lower() == 'kickme' and msg.to.type == "chat" then-- /kickme
  local receiver = get_receiver(msg)
    if msg.to.type == 'chat' then
      local print_name = user_print_name(msg.from):gsub("‮", "")
	  local name = print_name:gsub("_", "")
      savelog(msg.to.id, name.." ["..msg.from.id.."] left using kickme ")-- Save to logs
      chat_del_user("chat#id"..msg.to.id, "user#id"..msg.from.id, ok_cb, false)
    end
  end

  if not is_owner(msg) then -- Ignore normal users
    return
  end

  if matches[1]:lower() == "banlist" then -- Ban list !
    local chat_id = msg.to.id
    if matches[2] and is_admin1(msg) then
      chat_id = matches[2]
    end
    return ban_list(chat_id)
  end
  if matches[1]:lower() == 'clean' then 
      if not is_owner(msg) then
        return 
      end
if matches[2] == 'globalbanlist' then 
local hash = 'globalbanlist'
send_large_msg(get_receiver(msg), "<i>🎖 لیست افراد قطع دسترسی شده به تمامی گروه ها با موفقیت حذف گردید 🎖</i>")
--reply_msg(msg.id, "لیست افراد قطع دسترسی شده به تمامی گروه ها با موفقیت حذف گردید", ok_cb, false)
redis:del(hash)
     end
if matches[2] == 'banlist' and is_owner(msg) then
local chat_id = msg.to.id
local hash = 'banned:'..chat_id
send_large_msg(get_receiver(msg), "<i>🎖 لیست افراد مسدود شده برای ورود به گروه با موفقیت حذف گردید 🎖</i>")
--reply_msg(msg.id, "لیست افراد مسدود شده برای ورود به گروه با موفقیت حذف گردید", ok_cb, false)
redis:del(hash)
end
end

  if matches[1]:lower() == "banlist" then -- Ban list !
    local chat_id = msg.to.id
    if matches[2] and is_admin1(msg) then
      chat_id = matches[2]
    end
    return ban_list(chat_id)
  end

  if matches[1]:lower() == 'ban' then-- /ban
    if type(msg.reply_id)~="nil" and is_owner(msg) then
      if is_admin1(msg) then
		msgr = get_message(msg.reply_id,ban_by_reply_admins, false)
      else
        msgr = get_message(msg.reply_id,ban_by_reply, false)
      end
      local user_id = matches[2]
      local chat_id = msg.to.id
    elseif string.match(matches[2], '^%d+$') then
        if tonumber(matches[2]) == tonumber(our_id) then
         	return
        end
        --[[if is_admin1(matches[2]) then
          	return "you can't ban mods/owner/admins"
        end]]
        if tonumber(matches[2]) == tonumber(msg.from.id) then
          	return "<i> 🎖️شما مجاز به اخراج کردن خود از گروه نیستید </i>"
        end
        local print_name = user_print_name(msg.from):gsub("‮", "")
	    local name = print_name:gsub("_", "")
		local receiver = get_receiver(msg)
        savelog(msg.to.id, name.." ["..msg.from.id.."] baned user ".. matches[2])
        ban_user(matches[2], msg.to.id)
		send_large_msg(receiver, '🎖<i> کاربر از گروه محروم شد </i>🎖\n><i> شناسه کاربری: </i> [<b>'..matches[2]..'</b>]')
		--send_document("channel#id"..msg.to.id, "/root/jove/userinfo/ban1.webp", ok_cb, false)
      else
		local cbres_extra = {
		chat_id = msg.to.id,
		get_cmd = 'ban',
		from_id = msg.from.id,
		chat_type = msg.to.type
		}
		local username = string.gsub(matches[2], '@', '')
		resolve_username(username, kick_ban_res, cbres_extra)
    end
  end

if matches[1]:lower() == 'kick' then
    if type(msg.reply_id)~="nil" and is_owner(msg) then
      if is_admin1(msg) then
        msgr = get_message(msg.reply_id,Kick_by_reply_admins, false)
      else
        msgr = get_message(msg.reply_id,Kick_by_reply, false)
      end
	elseif string.match(matches[2], '^%d+$') then
		if tonumber(matches[2]) == tonumber(our_id) then
			return
		end
		if not is_admin1(msg) and is_momod2(matches[2], msg.to.id) then
			return "<i> 🎖شما نمیتوانید دسترسی  مدیران/مالک گروه/ادمین ها را به این گروه مسدود کنید </i>"
		end
		if tonumber(matches[2]) == tonumber(msg.from.id) then
			return "<i> 🎖شما مجاز به اخراج کردن خود از گروه نیستید </i>"
		end
    local user_id = matches[2]
    local chat_id = msg.to.id
		local print_name = user_print_name(msg.from):gsub("‮", "")
		local name = print_name:gsub("_", "")
		savelog(msg.to.id, name.." ["..msg.from.id.."] kicked user ".. matches[2])
		kick_user(user_id, chat_id)
	else
		local cbres_extra = {
			chat_id = msg.to.id,
			get_cmd = 'kick',
			from_id = msg.from.id,
			chat_type = msg.to.type
		}
		local username = string.gsub(matches[2], '@', '')
		resolve_username(username, kick_ban_res, cbres_extra)
	end
end

	if not is_admin1(msg) and not is_support(support_id) then
		return
	end
	if matches[1]:lower() == 'banall' then-- /ban
    if type(msg.reply_id)~="nil" and is_admin1(msg) then
      if is_admin1(msg) then
		msgr = get_message(msg.reply_id,banall_by_reply, false)
      end
      local user_id = matches[2]
      local chat_id = msg.to.id
    elseif string.match(matches[2], '^%d+$') then
        if tonumber(matches[2]) == tonumber(our_id) then
         	return "TEST!"
        end
        --if is_admin2(msg.from.id) then
          	--return "<i> ℹ️شما نمیتوانید دسترسی  مدیران/مالک گروه/ادمین ها را به این گروه مسدود کنید </i>"
       -- end
       -- if tonumber(matches[2]) == tonumber(msg.from.id) then
         -- 	return "<i> ℹ️شما مجاز به اخراج کردن خود از گروه نیستید </i>"
       -- end
		if not is_admin1(msg) and is_momod2(matches[2], msg.to.id) then
			return "<i> 🎖شما نمیتوانید دسترسی  مدیران/مالک گروه/ادمین ها را به این گروه مسدود کنید </i>"
		end
		if tonumber(matches[2]) == tonumber(msg.from.id) then
			return "<i> 🎖شما مجاز به اخراج کردن خود از گروه نیستید </i>"
		end
        local print_name = user_print_name(msg.from):gsub("‮", "")
	    local name = print_name:gsub("_", "")
		local receiver = get_receiver(msg)
        savelog(msg.to.id, name.." ["..msg.from.id.."] banedall user ".. matches[2])
        banall_user(matches[2])
		 kick_user(matches[2], msg.to.id)
		send_large_msg(receiver, '🎖<i> دسترسی کاربر برای ورود به تمامی گروه های ربات </i>🎖 [ @JoveTG ] <i> مسدود شد </i> \n><i> شناسه کاربری: </i> [<b>'..matches[2]..'</b>]')
		--send_document("channel#id"..msg.to.id, "/root/jove/userinfo/ban.webp", ok_cb, false)
      else
		local cbres_extra = {
		chat_id = msg.to.id,
		get_cmd = 'banall',
		from_id = msg.from.id,
		chat_type = msg.to.type
		}
		local username = string.gsub(matches[2], '@', '')
		resolve_username(username, kick_ban_res, cbres_extra)
    end
  end

 if matches[1]:lower() == 'unbanall' then-- /ban
    if type(msg.reply_id)~="nil" and is_admin1(msg) then
      if is_admin1(msg) then
		msgr = get_message(msg.reply_id,unbanall_by_reply, false)
      end
      local user_id = matches[2]
      local chat_id = msg.to.id
    elseif string.match(matches[2], '^%d+$') then
        if tonumber(matches[2]) == tonumber(our_id) then
         	return
        end
        if not is_admin1(msg) and is_momod2(matches[2], msg.to.id) then
          	return "<i>🎖شما نمیتوانید دسترسی  مدیران/مالک گروه/ادمین ها را به این گروه مسدود کنید </i>"
        end
        if tonumber(matches[2]) == tonumber(msg.from.id) then
          	return "<i> 🎖شما مجاز به اخراج کردن خود از گروه نیستید </i>"
        end
        local print_name = user_print_name(msg.from):gsub("‮", "")
	    local name = print_name:gsub("_", "")
		local receiver = get_receiver(msg)
        savelog(msg.to.id, name.." ["..msg.from.id.."] unbanedall user ".. matches[2])
        unbanall_user(matches[2])
		send_large_msg(receiver, '🎖<i> دسترسی کاربر برای ورود به تمامی گروه های ربات </i> [ @JoveTG ] <i> بازگردانده شد </i>🎖\n><i> شناسه کاربری: </i> [<b>'..matches[2]..'</b>]')
    -- send_document("channel#id"..msg.to.id, "/root/jove/userinfo/unban.webp", ok_cb, false)
	 else
		local cbres_extra = {
		chat_id = msg.to.id,
		get_cmd = 'unbanall',
		from_id = msg.from.id,
		chat_type = msg.to.type
		}
		local username = string.gsub(matches[2], '@', '')
		resolve_username(username, kick_ban_res, cbres_extra)
    end
  end

if matches[1]:lower() == 'unban' then-- /ban
    if type(msg.reply_id)~="nil" and is_momod(msg) then
      if is_momod(msg) then
		msgr = get_message(msg.reply_id,unban_by_reply, false)
      end
      local user_id = matches[2]
      local chat_id = msg.to.id
    elseif string.match(matches[2], '^%d+$') then
        if tonumber(matches[2]) == tonumber(our_id) then
         	return
        end
        local print_name = user_print_name(msg.from):gsub("‮", "")
	    local name = print_name:gsub("_", "")
		local receiver = get_receiver(msg)
        savelog(msg.to.id, name.." ["..msg.from.id.."] unban user ".. matches[2])
        local hash = 'banned:'..msg.to.id
         redis:srem(hash, matches[2])
		send_large_msg(receiver, '🎖<i> دسترسی کاربر برای ورود به گروه بازگردانده شد </i> 🎖\n><i> شناسه کاربری: </i> [<b>'..matches[2]..'</b>]')
      else
		local cbres_extra = {
		chat_id = msg.to.id,
		get_cmd = 'unban',
		from_id = msg.from.id,
		chat_type = msg.to.type
		}
		local username = string.gsub(matches[2], '@', '')
		resolve_username(username, kick_ban_res, cbres_extra)
    end
  end
  if matches[1]:lower() == "globalbanlist" then -- Global ban list
  --local hash = 'globalbanlist'
  --if not redis:get(hash) then
      -- return 'clear!'
	  -- else
    return banall_list()
  end
 -- end
end

return {
  patterns = {
    "^[#/]([Bb]anall) (.*)$",
    "^[#/]([Bb]anall)$",
    "^[#/]([Bb]anlist) (.*)$",
    "^[#!/]([Bb]anlist)$",
    "^[#!/]([Gg]lobalbanlist)$",
	"^[#/]([Kk]ickme)",
    "^[#/]([Kk]ick)$",
	"^[#/]([Bb]an)$",
    "^[#/]([Bb]an) (.*)$",
    "^[#/]([Uu]nban) (.*)$",
    "^[#/]([Uu]nbanall) (.*)$",
    "^[#/]([Uu]nbanall)$",
    "^[#/]([Kk]ick) (.*)$",
    "^[#/]([Uu]nban)$",
    --"^[#/]([Ii])$",
	    "^([Bb]anall) (.*)$",
    "^([Bb]anall)$",
    "^([Bb]anlist) (.*)$",
    "^([Bb]anlist)$",
    "^([Gg]lobalbanlist)$",
	"^([Kk]ickme)",
    "^([Kk]ick)$",
	"^([Bb]an)$",
    "^([Bb]an) (.*)$",
    "^([Uu]nban) (.*)$",
    "^([Uu]nbanall) (.*)$",
    "^([Uu]nbanall)$",
    "^([Kk]ick) (.*)$",
    "^([Uu]nban)$",
    "^!!tgservice (.+)$"
  },
  run = run,
  pre_process = pre_process
}
