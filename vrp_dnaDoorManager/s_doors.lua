--[[

  dnaFramework Door Manager
  Coded by Darklandz
  Version: 0.1

  Allows cops to lock/unlock doors at the police stations/jail/...

  Main Server File
]]

--
-- Server Event : To unlock doors
--
MySQL = module("vrp_mysql", "MySQL")
local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_dnsDoorManager")

MySQL.createCommand("vRP/dDM_get_door_status","SELECT locked FROM city_doors WHERE id = @doorId")
MySQL.createCommand("vRP/dDM_get_door_all","SELECT * FROM city_doors")
MySQL.createCommand("vRP/dDM_set_door_status","UPDATE city_doors SET locked = @doorStatus WHERE id = @doorId")


RegisterServerEvent("doormanager:s_openDoor")
AddEventHandler("doormanager:s_openDoor", function(doorId)
local user_id = vRP.getUserId({source})
local player = vRP.getUserSource({user_id})
local perm = {"police.doormanager"}

    local isDoorLocked = GetDoorStatus(doorId)

    if (isDoorLocked == 1) then
        if vRP.hasPermissions({user_id, perm}) then
            -- Client Event to open door
            TriggerClientEvent("doormanager:c_openDoor", -1, doorId)
            -- Update door status in DB
            SetDoorStatus(doorId,0)
        else
            -- Client Event, if user has no rights to open door, show notification
            TriggerClientEvent("doormanager:c_noDoorKey", player, doorId)
        end
    end
end)

--
-- Server Event : To lock doors
--

RegisterServerEvent("doormanager:s_closeDoor")
AddEventHandler("doormanager:s_closeDoor", function(doorId)
  local user_id = vRP.getUserId({source})
  local player = vRP.getUserSource({user_id})
  local perm = {"police.doormanager"}

    -- Get the status of the door
    local isDoorLocked = GetDoorStatus(doorId)

    if isDoorLocked == 0 then
        if vRP.hasPermissions({user_id, perm}) then
            -- Client Event to close door
            TriggerClientEvent("doormanager:c_closeDoor", -1, doorId)
            -- Update door status in DB
            SetDoorStatus(doorId,1)
        else
            -- Client Event, if user has no rights to open door, show notification
            TriggerClientEvent("doormanager:c_noDoorKey", player, doorId)
        end
    end
end)

--
-- Sync door database with client
--

RegisterServerEvent("doormanager:s_syncDoors")
AddEventHandler('doormanager:s_syncDoors', function()
    -- Source
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})

    MySQL.query("vRP/dDM_get_door_all", {}, function(result, affected)
      if (result) then
          TriggerClientEvent("doormanager:c_getSyncData",player, result)
      end
    end)
end)

--
-- Function to check if player is a cop
--

function GetPlayerJob(sId)
    return MySQL.Sync.fetchScalar("SELECT citizenStatus FROM characters WHERE steamId = @sid", {['@sid'] = sId})
end

--
-- Function to check the door status
--
local resp = {}
function GetDoorStatus(doorId)
  MySQL.query("vRP/dDM_get_door_status", {doorId = doorId}, function(result, affected)
    resp[1] = nil
    table.insert(resp,result[1]["locked"])
  end)
    for i,v in ipairs(resp) do
      --return resp
      return v
    end
end

--
-- Function to update the door status
--

function SetDoorStatus(doorId,doorStatus)
  MySQL.query("vRP/dDM_set_door_status", {doorId = doorId, doorStatus = doorStatus})
end
