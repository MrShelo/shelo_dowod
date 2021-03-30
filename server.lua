ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local katb = false
local kata = false
local katc = false
local jestb = 'nil'
local jestzdrowie = nil
local jestoc = nil
function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			name = identity['name'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height'],
            phone_number = identity['phone_number']


		}
	else
		return nil
	end
end



function getlicenseOC(source)
	local identifier = GetPlayerIdentifiers(source)[1]
    local result = MySQL.Sync.fetchAll("SELECT * FROM user_licenses WHERE type = @type and owner = @owner",
    {
      ['@owner']   = identifier,
      ['@type'] = 'oc'

    })
	if result[1] ~= nil then
        jestoc = '~h~~g~Aktualne ~s~'
	else
		jestoc = '~h~~r~Brak ~s~'
	end
end

function getlicenseUZ(source)
	local identifier = GetPlayerIdentifiers(source)[1]
    local result = MySQL.Sync.fetchAll("SELECT * FROM user_licenses WHERE type = @type and owner = @owner",
    {
      ['@owner']   = identifier,
      ['@type'] = 'uz'

    })
	if result[1] ~= nil then
        jestuz = '~h~~g~Aktualne ~s~'
	else
		jestuz = '~h~~r~Brak ~s~'
	end
end


function getlicenseA(source)
	local identifier = GetPlayerIdentifiers(source)[1]
    local result = MySQL.Sync.fetchAll("SELECT * FROM user_licenses WHERE type = @type and owner = @owner",
    {
      ['@owner']   = identifier,
      ['@type'] = 'drive_bike'

    })
	if result[1] ~= nil then
        jesta = '~h~~g~A ~s~'
	else
		jesta = '~h~~r~A ~s~'
	end
end

function getlicenseB(source)
	local identifier = GetPlayerIdentifiers(source)[1]
    local result = MySQL.Sync.fetchAll("SELECT * FROM user_licenses WHERE type = @type and owner = @owner",
    {
      ['@owner']   = identifier,
      ['@type'] = 'drive'

    })
	if result[1] ~= nil then
        jestb = '~h~~g~B ~s~'
	else
		jestb = '~h~~r~B ~s~'
	end
end

function getlicenseC(source)
	local identifier = GetPlayerIdentifiers(source)[1]
    local result = MySQL.Sync.fetchAll("SELECT * FROM user_licenses WHERE type = @type and owner = @owner",
    {
      ['@owner']   = identifier,
      ['@type'] = 'drive_truck'

    })
	if result[1] ~= nil then
        jestc = '~h~~g~C~n~ ~s~'
	else
		jestc = '~h~~r~C ~n~~s~'
	end
end

function getlicenseW(source)
	local identifier = GetPlayerIdentifiers(source)[1]
    local result = MySQL.Sync.fetchAll("SELECT * FROM user_licenses WHERE type = @type and owner = @owner",
    {
      ['@owner']   = identifier,
      ['@type'] = 'weapon'

    })
	if result[1] ~= nil then
        jestw = '~g~Tak~n~ ~s~'
	else
		jestw = '~r~Nie~n~ ~s~'
	end
end


ESX.RegisterServerCallback('esx_phone:getItemAmount', function(source, cb, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local qtty = xPlayer.getInventoryItem(item).count
    cb(qtty)
end)

TriggerEvent('es:addCommand', 'dowod', function(source, args, user)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local liczba = xPlayer.getInventoryItem('dowod').count

    local lickaB = getlicenseB(source)
    local lickaA = getlicenseA(source)
    local lickaC = getlicenseC(source)
	local lickaW = getlicenseW(source)

	local name = getIdentity(source)
	if liczba >= 1 then
	TriggerClientEvent('esx:dowod_pokazdowod', -1,_source,  name.firstname..' '..name.lastname, 'Data urodzin: ~y~' ..name.dateofbirth, '~s~Licencja Na Bron: '..jestw.. 'Prawo Jazdy Kat: '..jesta..' '..jestb..' '..jestc)
	TriggerClientEvent("pokazujedowod", -1, _source, name.firstname .. " ".. name.lastname, table.concat(args, " "))
	elseif liczba == nil then
		pNotify('Nie posiadasz Dowodu', 'success', 3000)
	end
end)


TriggerEvent('es:addCommand', 'ubez', function(source, args, user)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)


	local lickaOC = getlicenseOC(source)
	local lickaUZ = getlicenseUZ(source)

	local name = getIdentity(source)

	local liczba = xPlayer.getInventoryItem('ubezpieczenie').count
	if liczba >= 1 then
	TriggerClientEvent('esx:dowod_pokazubezpieczenia', -1,_source, 'Karta Ubezpieczeń', name.firstname..' '..name.lastname, '~w~Ubezpieczenie UZ: ' ..jestuz)
	TriggerClientEvent("pokazujeubez", -1, _source, name.firstname .. " - ".. name.lastname,'Ubezpieczenie')
	elseif liczba == nil then
		pNotify('Nie posiadasz Karty Ubezpieczeniowej', 'success', 3000)
	end
end)


TriggerEvent('es:addCommand', 'wiz', function(source, args, user)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)


	 local name = getIdentity(source)


	 local liczba = xPlayer.getInventoryItem('wizytowka').count
 	if liczba >= 1 then
	TriggerClientEvent('esx:dowod_wiz', -1,_source, name.firstname..' '..name.lastname, 'Numer Telefonu: ~y~'..name.phone_number, '')
	TriggerClientEvent("pokazujewiz", -1, _source, name.firstname .. " - ".. name.phone_number, table.concat(args, " "))
	elseif liczba == nil then
		pNotify('Nie posiadasz Wizytówki', 'success', 3000)
	end
end)


RegisterNetEvent('urzad_daj:dawaj_to')
AddEventHandler('urzad_daj:dawaj_to', function(it)
  local xPlayer = ESX.GetPlayerFromId(source)
  local itemCount = xPlayer.getInventoryItem(it).count

if itemCount < 1 then
	xPlayer.addInventoryItem(it, 1)
	xPlayer.removeAccountMoney("bank", 50)
		pNotify('Pobrano <span style="color: green">$50</span> z banku', 'success', 3000)
else
	pNotify('<span style="color: orange">Posiadasz już '..it..'</span>', 'success', 3000)
end
end)

RegisterNetEvent('urzad_daj:dawaj_uz')
AddEventHandler('urzad_daj:dawaj_uz', function (closestPlayer)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(player)
	local steamhex = GetPlayerIdentifier(closestPlayer)
	print(steamhex)
  MySQL.Async.execute(
    'INSERT INTO user_licenses (type, owner) VALUES (@type, @owner)',
    {
      ['@type'] = 'uz',
      ['@owner']   = steamhex
    },
    	function (rowsChanged)
		end)

end)

RegisterNetEvent('urzad_daj:zabier_uz')
AddEventHandler('urzad_daj:zabier_uz', function (closestPlayer)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(closestPlayer)

  MySQL.Async.execute(
    'DELETE FROM user_licenses (type, owner) VALUES (@type, @owner)',
    {
      ['@type'] = 'uz',
      ['@owner']   = steamhex
    },
    function (rowsChanged)

end)
end)

RegisterNetEvent('urzad_daj:dawaj_lic')
AddEventHandler('urzad_daj:dawaj_lic', function (id)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)

  MySQL.Async.execute(
    'INSERT INTO user_licenses (type, owner) VALUES (@type, @owner)',
    {
      ['@type'] = id,
      ['@owner']   = xPlayer.identifier
    },
    function (rowsChanged)

end)
end)


pNotify = function(message, messageType, messageTimeout)
	TriggerClientEvent("pNotify:SendNotification", source, {
		text = message,
		type = messageType,
		queue = "shop_sv",
		timeout = messageTimeout,
		layout = "centerRight"
	})
end
