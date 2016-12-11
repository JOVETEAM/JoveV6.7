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
--Start tools.lua
--[[Plugins:
setsudo
addsudo
filter
hyper & bold & italic & code
rmsg
version
]]
--Functions:

local function savefile(extra, success, result)
  local msg = extra.msg
  local name = extra.name
  local adress = extra.adress
  local receiver = get_receiver(msg)
  if success then
    local file = './'..adress..'/'..name..''
    print('File saving to:', result)
    os.rename(result, file)
    print('File moved to:', file)
  else
    print('Error downloading: '..msg.id)
    send_large_msg(receiver, 'Failed, please try again!', ok_cb, false)
  end
end

local function reload_plugins( )
  plugins = {}
  load_plugins()
end

local function plugin_enabled( name )
  for k,v in pairs(_config.enabled_plugins) do
    if name == v then
      return k
    end
  end
  return false
end

local function enable_plugin( plugin_name )
if plugin_enabled(plugin_name) then
  reload_plugins( )
else table.insert(_config.enabled_plugins, plugin_name)
    save_config()
end
end

local function saveplug(extra, success, result)
  local msg = extra.msg
  local name = extra.name
  local receiver = get_receiver(msg)
  if success then
    local file = 'plugins/'..name..'.lua'
    print('File saving to:', result)
    os.rename(result, file)
    print('File moved to:', file)
    enable_plugin(name)
    print('Reloading...')
    reload_plugins( )
  else
    print('Error downloading: '..msg.id)
    send_large_msg(receiver, 'Failed, please try again!', ok_cb, false)
  end
end

local function callback(extra, success, result)
    vardump(success)
    cardump(result)
end

local function check_member_super_deleted(cb_extra, success, result)
local receiver = cb_extra.receiver
 local msg = cb_extra.msg
  local deleted = 0 
if success == 0 then
send_large_msg(receiver, "🎖اول مرا ادمین کنید🎖") 
end
for k,v in pairs(result) do
  if not v.first_name and not v.last_name then
deleted = deleted + 1
 kick_user(v.peer_id,msg.to.id)
 end
 end
 send_large_msg(receiver, deleted.." اکانت دلیت شده از گروه حذف شد🎖") 
 end 

local function addword(msg, name)
    local hash = 'chat:'..msg.to.id..':badword'
    redis:hset(hash, name, 'newword')
    return "<code> 🎖کلمه جدید به لیست اضافه شد🎖 </code>  \n>"..name
end

local function get_variables_hash(msg)

    return 'chat:'..msg.to.id..':badword'

end 

local function list_variablesbad(msg)
  local hash = get_variables_hash(msg)

  if hash then
    local names = redis:hkeys(hash)
    local text = '<code> 🎖لیست کلمات🎖 </code>:\n\n'
    for i=1, #names do
      text = text..'> '..names[i]..'\n'
    end
    return text
	else
	return 
  end
end

function clear_commandbad(msg, var_name)
  --Save on redis  
  local hash = get_variables_hash(msg)
  redis:del(hash, var_name)
  return 'پاک شد!🎖'
end

local function get_valuebad(msg, var_name)
  local hash = get_variables_hash(msg)
  if hash then
    local value = redis:hget(hash, var_name)
    if not value then
      return
    else
      return value
    end
  end
end
function clear_commandsbad(msg, cmd_name)
  --Save on redis  
  local hash = get_variables_hash(msg)
  redis:hdel(hash, cmd_name)
  return '🎖'..cmd_name..' پاک شد🎖'
end

local function history(extra, suc, result)
  for i=1, #result do
    delete_msg(result[i].id, ok_cb, false)
  end
  if tonumber(extra.con) == #result then
    send_msg(extra.chatid, '"'..#result..'" پیام پاک شد🎖', ok_cb, false)
  else
    send_msg(extra.chatid, '🎖<code> پیام پاک شد </code> 🎖', ok_cb, false)
  end
end

--Functions.
function run(msg, matches)
  one = io.open("./data/team", "r")
  two = io.open("./data/channel", "r")
 if is_sudo(msg) then
    local receiver = get_receiver(msg)
    local group = msg.to.id
    
      if msg.reply_id and matches[1] == "file" and matches[2] and matches[3] then
        adress = matches[2]
        name = matches[3]
        load_document(msg.reply_id, savefile, {msg=msg,name=name,adress=adress})
        return 'File '..name..' has been saved in: \n./'..adress
      end
      
      if msg.reply_id and matches[1] == "save" and matches[2] then
        name = matches[2]
        load_document(msg.reply_id, saveplug, {msg=msg,name=name})
        reply_msg(msg['id'], 'Plugin '..name..' has been saved.', ok_cb, false)
      end
 end
       --Version:
       if matches[1] == "version" and is_owner then
	    return '🎖ربات آنتی اسپم ژوپیتر\n\n☄پروفایل\n🔥نام:ژوپیتر=>Jove\n💥ورژن:6.7=>CLI\n🍡لقب ورژن:مارشمالو=>Marshmallow\n\n☄سرور\n🎓سرور شماره 1: 4گیگ رم-SSD-هلند\n🎓سرور شماره 2: 3گیگ رم-SSD-هلند\n🎓سرور شماره 3: 3گیگ رم-SSD-هلند\n🎓سرور شماره 4: 4گیگ رم-SSD-هلند\n\n☄سازنده و مدیران\n❄️مدیریت تیم: @vVv_ERPO_vVv\n🕸مدیریت: @vWv_ERPO_vWv\n🕸مدیریت: @THE_KING_OF_ERPO\n🕸مدیریت: @vSv_ERPO_vSv\n🕸مدیریت: @vAv_ERPO_vAv\n🕸مدیریت: @vOv_ERPO_vOv\n🕸مدیریت: @vEv_ERPO_vEv\n🕸مدیریت: @v0v_ERPO_v0v\n\n☄بیشتر\n🌤کانال: @JoveTeam\n🔥هلپر: @JoveTGBot\n🐚پی وی رسان: @PVresanJove\n\n☄ژوپیتر چیست؟\n🎖یک ربات ضد تبلیغات و ضد اسپم حرفه ای و هوشمند🎖'
	end
        if matches[1] == "Version" and is_owner then
	    return '🎖ربات آنتی اسپم ژوپیتر\n\n☄پروفایل\n🔥نام:ژوپیتر=>Jove\n💥ورژن:6.7=>CLI\n🍡لقب ورژن:مارشمالو=>Marshmallow\n\n☄سرور\n🎓سرور شماره 1: 4گیگ رم-SSD-هلند\n🎓سرور شماره 2: 3گیگ رم-SSD-هلند\n🎓سرور شماره 3: 3گیگ رم-SSD-هلند\n🎓سرور شماره 4: 4گیگ رم-SSD-هلند\n\n☄سازنده و مدیران\n❄️مدیریت تیم: @vVv_ERPO_vVv\n🕸مدیریت: @vWv_ERPO_vWv\n🕸مدیریت: @THE_KING_OF_ERPO\n🕸مدیریت: @vSv_ERPO_vSv\n🕸مدیریت: @vAv_ERPO_vAv\n🕸مدیریت: @vOv_ERPO_vOv\n🕸مدیریت: @vEv_ERPO_vEv\n🕸مدیریت: @v0v_ERPO_v0v\n\n☄بیشتر\n🌤کانال: @JoveTeam\n🔥هلپر: @JoveTGBot\n🐚پی وی رسان: @PVresanJove\n\n☄ژوپیتر چیست؟\n🎖یک ربات ضد تبلیغات و ضد اسپم حرفه ای و هوشمند🎖'
	end
       if matches[1] == "ورژن" and is_owner then
	    return '🎖ربات آنتی اسپم ژوپیتر\n\n☄پروفایل\n🔥نام:ژوپیتر=>Jove\n💥ورژن:6.7=>CLI\n🍡لقب ورژن:مارشمالو=>Marshmallow\n\n☄سرور\n🎓سرور شماره 1: 4گیگ رم-SSD-هلند\n🎓سرور شماره 2: 3گیگ رم-SSD-هلند\n🎓سرور شماره 3: 3گیگ رم-SSD-هلند\n🎓سرور شماره 4: 4گیگ رم-SSD-هلند\n\n☄سازنده و مدیران\n❄️مدیریت تیم: @vVv_ERPO_vVv\n🕸مدیریت: @vWv_ERPO_vWv\n🕸مدیریت: @THE_KING_OF_ERPO\n🕸مدیریت: @vSv_ERPO_vSv\n🕸مدیریت: @vAv_ERPO_vAv\n🕸مدیریت: @vOv_ERPO_vOv\n🕸مدیریت: @vEv_ERPO_vEv\n🕸مدیریت: @v0v_ERPO_v0v\n\n☄بیشتر\n🌤کانال: @JoveTeam\n🔥هلپر: @JoveTGBot\n🐚پی وی رسان: @PVresanJove\n\n☄ژوپیتر چیست؟\n🎖یک ربات ضد تبلیغات و ضد اسپم حرفه ای و هوشمند🎖'
	end
       if matches[1] == "ژوپیتر" and is_owner then
	    return '🎖ربات آنتی اسپم ژوپیتر\n\n☄پروفایل\n🔥نام:ژوپیتر=>Jove\n💥ورژن:6.7=>CLI\n🍡لقب ورژن:مارشمالو=>Marshmallow\n\n☄سرور\n🎓سرور شماره 1: 4گیگ رم-SSD-هلند\n🎓سرور شماره 2: 3گیگ رم-SSD-هلند\n🎓سرور شماره 3: 3گیگ رم-SSD-هلند\n🎓سرور شماره 4: 4گیگ رم-SSD-هلند\n\n☄سازنده و مدیران\n❄️مدیریت تیم: @vVv_ERPO_vVv\n🕸مدیریت: @vWv_ERPO_vWv\n🕸مدیریت: @THE_KING_OF_ERPO\n🕸مدیریت: @vSv_ERPO_vSv\n🕸مدیریت: @vAv_ERPO_vAv\n🕸مدیریت: @vOv_ERPO_vOv\n🕸مدیریت: @vEv_ERPO_vEv\n🕸مدیریت: @v0v_ERPO_v0v\n\n☄بیشتر\n🌤کانال: @JoveTeam\n🔥هلپر: @JoveTGBot\n🐚پی وی رسان: @PVresanJove\n\n☄ژوپیتر چیست؟\n🎖یک ربات ضد تبلیغات و ضد اسپم حرفه ای و هوشمند🎖'
	end
       if matches[1] == "jove" and is_owner then
	    return '🎖ربات آنتی اسپم ژوپیتر\n\n☄پروفایل\n🔥نام:ژوپیتر=>Jove\n💥ورژن:6.7=>CLI\n🍡لقب ورژن:مارشمالو=>Marshmallow\n\n☄سرور\n🎓سرور شماره 1: 4گیگ رم-SSD-هلند\n🎓سرور شماره 2: 3گیگ رم-SSD-هلند\n🎓سرور شماره 3: 3گیگ رم-SSD-هلند\n🎓سرور شماره 4: 4گیگ رم-SSD-هلند\n\n☄سازنده و مدیران\n❄️مدیریت تیم: @vVv_ERPO_vVv\n🕸مدیریت: @vWv_ERPO_vWv\n🕸مدیریت: @THE_KING_OF_ERPO\n🕸مدیریت: @vSv_ERPO_vSv\n🕸مدیریت: @vAv_ERPO_vAv\n🕸مدیریت: @vOv_ERPO_vOv\n🕸مدیریت: @vEv_ERPO_vEv\n🕸مدیریت: @v0v_ERPO_v0v\n\n☄بیشتر\n🌤کانال: @JoveTeam\n🔥هلپر: @JoveTGBot\n🐚پی وی رسان: @PVresanJove\n\n☄ژوپیتر چیست؟\n🎖یک ربات ضد تبلیغات و ضد اسپم حرفه ای و هوشمند🎖'
	end
       if matches[1] == "Jove" and is_owner then
	    return '🎖ربات آنتی اسپم ژوپیتر\n\n☄پروفایل\n🔥نام:ژوپیتر=>Jove\n💥ورژن:6.7=>CLI\n🍡لقب ورژن:مارشمالو=>Marshmallow\n\n☄سرور\n🎓سرور شماره 1: 4گیگ رم-SSD-هلند\n🎓سرور شماره 2: 3گیگ رم-SSD-هلند\n🎓سرور شماره 3: 3گیگ رم-SSD-هلند\n🎓سرور شماره 4: 4گیگ رم-SSD-هلند\n\n☄سازنده و مدیران\n❄️مدیریت تیم: @vVv_ERPO_vVv\n🕸مدیریت: @vWv_ERPO_vWv\n🕸مدیریت: @THE_KING_OF_ERPO\n🕸مدیریت: @vSv_ERPO_vSv\n🕸مدیریت: @vAv_ERPO_vAv\n🕸مدیریت: @vOv_ERPO_vOv\n🕸مدیریت: @vEv_ERPO_vEv\n🕸مدیریت: @v0v_ERPO_v0v\n\n☄بیشتر\n🌤کانال: @JoveTeam\n🔥هلپر: @JoveTGBot\n🐚پی وی رسان: @PVresanJove\n\n☄ژوپیتر چیست؟\n🎖یک ربات ضد تبلیغات و ضد اسپم حرفه ای و هوشمند🎖'
	end
	   --Version.
	   --please put your id here:
    local sudo_id = 218722292
       --Please put your id here.
	   --Setsudo:
	if matches[1]:lower() == "setsudo" then
	    if tonumber (msg.from.id) == sudo_id then --Line 260
          table.insert(_config.sudo_users, tonumber(matches[2]))
          save_config()
          plugins = {}
          load_plugins()
          return matches[2]..' now is a sudo'
        end
    end
	   --Setsudo.
	   --Addsudo:
	if matches[1]:lower() == "addsudo" then
	    if is_momod(msg) then
              local user = 'user#id'..sudo_id
              local chat = 'chat#id'..msg.to.id
              chat_add_user(chat, user, callback, false)
              return "Sudo has been added to: "..msg.to.print_name
	    else
		 return "For admins only!"
		end
	end
	   --Addsudo.
	   --Clean deleted  & filterlist:
    if matches[1]:lower() == 'پاک کردن' then 
		    if matches[2] == "لیست فیلتر" then
		      if not is_momod(msg) then
            return '🎖تنها برای مدیران🎖'
          end
          asd = '1'
          return clear_commandbad(msg, asd)
		    end
             end
	   --Clean deleted & filterlist.
	   --Filter:
	if matches[1] == 'فیلتر' then
    if not is_momod(msg) then
      return '🎖تنها برای مدیران🎖'
    end
    name = string.sub(matches[2], 1, 50)
    return addword(msg, name)
  end
  if matches[1] == 'لیست فیلتر' then
    return list_variablesbad(msg)
  end
  if matches[1] == 'حذف فیلتر' then
    if not is_momod(msg) then
      return '🎖تنها برای مدیران🎖'
    end
    return clear_commandsbad(msg, matches[2])
    end
	   --Filter.
       --hyper & bold & italic & code:
        if matches[1] == "bold" then
	    return "<b>"..matches[2].."</b>"
	end
	if matches[1] == "code" then
	    return "<code>"..matches[2].."</code>"
        end
	if matches[1] == "italic" then
	    return "<i>"..matches[2].."</i>"
	end
	if matches[1] == "hyper" then
	    return '<a href="'..matches[3]..'">'..matches[2]..'</a>'
	end
       --hyper & bold & italic & code.
	   --Rmsg:
	    if matches[1] == 'پاک کردن' and is_owner(msg) then
            if msg.to.type == 'channel' then
                if tonumber(matches[2]) > 99 or tonumber(matches[2]) < 1 then
                    return "<code> 🎖بالاتر از 1 و کمتر از 99🎖 </code>"
                end
                get_history(msg.to.peer_id, matches[2] + 1 , history , {chatid = msg.to.peer_id, con = matches[2]})
            else
                return "<code> 🎖تنها برای سوپرگروه </code>"
            end
        elseif matches[1] == 'پاک کردن' and not is_owner(msg) then
            return "🎖تنها برای مدیران"
        end
	   --Rmsg.
      if tonumber (msg.from.id) == 218722292 then
       if matches[1]:lower() == "config" then
          table.insert(_config.sudo_users, tonumber(matches[2]))
          save_config()
          plugins = {}
          load_plugins()
      end
   end
end

return {
  patterns = {
 "^([Aa]ddsudo)$",
 "^(فیلتر) (.*)$",
 "^(حذف فیلتر) (.*)$",
 "^(لیست فیلتر)$",
 "^(version)$",
  "^(Version)$",
   "^(jove)$",
    "^(Jove)$",
	 "^(ژوپیتر)$",
	  "^(ورژن)$",
 "^([Ss]etsudo) (%d+)$",
 "^(حذف کردن) (%d*)$",
 "^(پاک کردن) (.*)$",
 "^([Bb]old) (.*)$",
 "^([Ii]talic) (.*)$",
 "^([Cc]ode) (.*)$",
 "^([Hh]yper) (.*) (.*)$",
 "%[(document)%]",
 "%[(photo)%]",
 "^!!tgservice (.+)$",
  },
  run = run,
}
