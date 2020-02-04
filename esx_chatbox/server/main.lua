
function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height']
		}
	else
		return nil
	end
end


AddEventHandler('chatMessage', function(source, name, message)
    if string.sub(message, 1, string.len("/")) ~= "/" then
        local name = getIdentity(source)
      TriggerClientEvent("sendProximityMessage", -1, source, name.firstname, message)
    end
    CancelEvent()
end)

TriggerEvent('es:addCommand', 'do', function(source, args, user)
    local name = getIdentity(source)
    TriggerClientEvent("sendProximityMessageDo", -1, source, name.firstname, table.concat(args, " "))
end)

  RegisterCommand('ooc', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(5)
    local name = getIdentity(source)

    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(70, 121, 197, 0.9); border-radius: 10px;"> <b>OOC | {1} {0} :</b> {2}</div>',
        args = { playerName, source, msg }
    })
end, false)
   
RegisterCommand('news', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(5)
    local name = getIdentity(source)

    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(220, 118, 52, 0.9); border-radius: 10px;"> <b>NEWS :</b> {1} </div>',
        args = { playerName, msg }
    })
end, false)


RegisterCommand('anon', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(5)
    local name = getIdentity(source)

    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(225, 0, 0, 0.9); border-radius: 10px;"> <b>Anonymous :</b> {1}</div>',
        args = { playerName, msg }
    })
end, false)


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_jobChat:chatpolice')
AddEventHandler('esx_jobChat:chatpolice', function(job, msg)
    local _source = source
    local xPlayers = ESX.GetPlayers()
    local pName= getIdentity(source)
	fal = pName.firstname .. " " .. pName.lastname
	jobName = string.upper(job)
	local messageFull = {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(178, 34, 34, 0.9); border-radius: 10px;"><b> [{0}] {1} :</b> {2}</i></b></div>',
        args = {jobName, fal, msg}
    }
    TriggerClientEvent('esx_jobChat:Send', -1, messageFull, job)
end)

RegisterServerEvent('esx_jobChat:chatems')
AddEventHandler('esx_jobChat:chatems', function(job, msg)
    local _source = source
    local xPlayers = ESX.GetPlayers()
    local pName= getIdentity(source)
	fal = pName.firstname .. " " .. pName.lastname
	jobName = string.upper(job)
	local messageFull = {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(32, 178, 170, 0.9); border-radius: 10px;"> <b>[{0}] {1} :</b> {2}</i></b></div>',
        args = {jobName, fal, msg}
    }
    TriggerClientEvent('esx_jobChat:Send', -1, messageFull, job)
end)

RegisterServerEvent('esx_jobChat:chatmechanic')
AddEventHandler('esx_jobChat:chatmechanic', function(job, msg)
    local _source = source
    local xPlayers = ESX.GetPlayers()
    local pName= getIdentity(source)
	fal = pName.firstname .. " " .. pName.lastname
	jobName = string.upper(job)
	local messageFull = {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 153, 51, 0.9); border-radius: 10px;"> <b>[{0}] {1} :</b> {2}</i></b></div>',
        args = {jobName, fal, msg}
    }
    TriggerClientEvent('esx_jobChat:Send', -1, messageFull, job)
end)

RegisterServerEvent('esx_jobChat:chattaxi')
AddEventHandler('esx_jobChat:chattaxi', function(job, msg)
    local _source = source
    local xPlayers = ESX.GetPlayers()
    local pName= getIdentity(source)
	fal = pName.firstname .. " " .. pName.lastname
	jobName = string.upper(job)
	local messageFull = {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 165, 0, 0.9); border-radius: 10px;"><b> [{0}] {1} :</b> {2}</i></b></div>',
        args = {jobName, fal, msg}
    }
    TriggerClientEvent('esx_jobChat:Send', -1, messageFull, job)
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
