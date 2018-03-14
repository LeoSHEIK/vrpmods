--[[

  dnaFramework Door Manager
  Coded by Darklandz
  Version: 1.0
  converted vRP by Leo SHK

  Allows cops to lock/unlock doors at the police stations/jail/...

  Resource File
]]

dependency "vrp"

--
-- Load client scripts
--

client_script {
  "c_doors.lua"
}

--
-- Load server script
--

server_scripts {
  "@vrp/lib/utils.lua",
  "@mysql-async/lib/MySQL.lua",
  "s_doors.lua"
}
