local cfg = {}

--[[
Developed by Leo SHK

cmd - chat call command
display - visual display in the chat
anonymous - invisible nickname (true or false)
userdb - true show firstname and lastname from database, false show steam/fivem nickname
permission - create permission and insert to group in vrp/cfg/group.lua
]]--

cfg.chatcmd = {
  {cmd = "/twitter", display= "@twitter | ", anonymous = false, userdb = true, permission ="chatcmd.twitter", r =  7, g = 206, b = 246},
  {cmd = "/anonimo", display= "@anonimos | ", anonymous = true, userdb = false, permission = "chatcmd.anonimo", r =  129, g = 154, b = 151},
}

cfg.chatgroups = {
    {display = "[Hacker]", userdb = true, permission = "chatrules.hacker", r = 203, g = 38, b = 0 },
   
}

return cfg
