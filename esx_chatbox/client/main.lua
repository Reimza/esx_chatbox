

ESX = nil

RegisterNetEvent('sendProximityMessage')
AddEventHandler('sendProximityMessage', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chatMessage', "^4" .. name .. "", {0, 153, 204}, "^7 " .. message)
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
    TriggerEvent('chatMessage', "^4" .. name .. "", {0, 153, 204}, "^7 " .. message)
  end
end)

RegisterNetEvent('sendProximityMessageMe')
AddEventHandler('sendProximityMessageMe', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chatMessage', "", {255, 0, 0}, " ^6 " .. name .." ".."^6 " .. message)
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
    TriggerEvent('chatMessage', "", {255, 0, 0}, " ^6 " .. name .." ".."^6 " .. message)
  end
end)

RegisterNetEvent('sendProximityMessageDo')
AddEventHandler('sendProximityMessageDo', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)

  if pid == myId then
      TriggerEvent('chat:addMessage', {
          template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(165, 55, 50, 0.9); border-radius: 10px;"><i class="fas fa-user-circle"></i> Do | {0} : {1}</div>',
          args = { name, message }
      })
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 15.4 then
      TriggerEvent('chat:addMessage', {
          template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(165, 65, 50, 0.9); border-radius: 10px;"><i class="fas fa-user-circle"></i> Do | {0} : {1}</div>',
          args = { name, message }
      })
  end
end)





Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(6000)
		PlayerData = ESX.GetPlayerData()
	end
end)



RegisterCommand('police', function(source, args, rawCommand)
	local msg = rawCommand:sub(7)
    local job = PlayerData.job.name
    if PlayerData.job.name == 'police' then
    TriggerServerEvent('esx_jobChat:chatpolice', job, msg)
    else
        exports['mythic_notify']:SendAlert('inform', 'job invalid', 2500, { ['background-color'] = '#DC143C', ['color'] = '#ffffff' })
    end
end, false)

RegisterCommand('ems', function(source, args, rawCommand)
	local msg = rawCommand:sub(5)
    local job = PlayerData.job.label
    if PlayerData.job.name == 'ambulance' then
    TriggerServerEvent('esx_jobChat:chatems', job, msg)
    else
        exports['mythic_notify']:SendAlert('inform', 'job invalid', 2500, { ['background-color'] = '#DC143C', ['color'] = '#ffffff' })
    end
end, false)

RegisterCommand('mecha', function(source, args, rawCommand)
	local msg = rawCommand:sub(6)
    local job = PlayerData.job.name
    if PlayerData.job.name == 'mechanic' then
    TriggerServerEvent('esx_jobChat:chatmechanic', job, msg)
    else
        exports['mythic_notify']:SendAlert('inform', 'job invalid', 2500, { ['background-color'] = '#DC143C', ['color'] = '#ffffff' })
    end
end, false)

RegisterCommand('taxi', function(source, args, rawCommand)
	local msg = rawCommand:sub(5)
    local job = PlayerData.job.name
    if PlayerData.job.name == 'taxi' then
    TriggerServerEvent('esx_jobChat:chattaxi', job, msg)
    else
        exports['mythic_notify']:SendAlert('inform', 'job invalid', 2500, { ['background-color'] = '#DC143C', ['color'] = '#ffffff' })
    end
end, false)




RegisterNetEvent('esx_jobChat:Send')
AddEventHandler('esx_jobChat:Send', function(messageFull, job)
    
		TriggerEvent('chat:addMessage', messageFull)
    
end)







