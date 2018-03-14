local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_chatrules")

local cfg = module("vrp_chatrules", "cfg/config")
local cfgcmd = cfg.chatcmd
local cfgrules = cfg.chatgroups


AddEventHandler('chatMessage', function(source, name, msg)
  CancelEvent()
  local user_id = vRP.getUserId({source})

  if user_id ~= nil then
    vRP.getUserIdentity({user_id, function (identity)
      sm = stringsplit(msg, " ");
      CancelEvent()

      local iscmd = false

      for r=1, #cfgcmd do
        if sm[1] == cfgcmd[r].cmd then
          if vRP.hasPermission({user_id,cfgcmd[r].permission}) then
            iscmd = true
            if cfgcmd[r].userdb then
              local dbfirstname = identity.firstname
              local dbname = identity.name
              name = dbfirstname .." "..dbname

            end
            if cfgcmd[r].anonymous then
              name = ""
            end
            CancelEvent()
            TriggerClientEvent('chatMessage', -1, cfgcmd[r].display .. name.." ", { cfgcmd[r].r, cfgcmd[r].g, cfgcmd[r].b }, string.sub(msg,string.len(cfgcmd[r].cmd)+1))
          end
        end
      end

      if not iscmd then
        local ing = false
        for v=1, #cfgrules do
          if vRP.hasPermission({user_id,cfgrules[v].permission}) then
            if cfgrules[v].userdb then
              local dbfirstname = identity.firstname
              local dbname = identity.name
              local name = dbfirstname .." "..dbname
            end
            ing = true
            CancelEvent()
            TriggerClientEvent('chatMessage', -1, cfgrules[v].display .. name.." ", { cfgrules[v].r, cfgrules[v].g, cfgrules[v].b }, msg)
          end
        end
        if not ing then
          TriggerClientEvent('chatMessage', -1, "Cidadão | " .. name.." ", { 239, 229, 255 }, msg)
        end
      end
    end})
  end
end)

function stringsplit(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t={} ; i=1
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    t[i] = str
    i = i + 1
  end
  return t
end
