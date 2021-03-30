
ESX                           = nil
local PlayerData                = {}

Citizen.CreateThread(function()

	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

end)

local dowody = vector3(-552.6 , -191.1, 38.2)


Citizen.CreateThread(function()

	while true do
		Citizen.Wait(6)
	    local playerPed = GetPlayerPed(-1)
			local coords = GetEntityCoords(playerPed)
			if GetDistanceBetweenCoords(coords, dowody, true) < 10 then
					Draw3DText(dowody.x, dowody.y, dowody.z, '~r~[E]~w~ aby otworzyć menu ')
					if IsControlJustPressed(1, 51) and GetDistanceBetweenCoords(coords, dowody, true) < 3 then
						MenuUrzad()
					end
			end
	end
end)


RegisterNetEvent('dowod:trigger')
AddEventHandler('dowod:trigger', function()
ExecuteCommand('dowod')

end)
RegisterNetEvent('ubezpieczenie:trigger')
AddEventHandler('ubezpieczenie:trigger', function()
ExecuteCommand('ubez')

end)

RegisterNetEvent('wizytowka:trigger')
AddEventHandler('wizytowka:trigger', function()
ExecuteCommand('wiz')

end)





RegisterNetEvent('pokazujedowod')
AddEventHandler('pokazujedowod', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
  TriggerEvent('chatMessage',"^*Obywatel["  .. id .. "] Pokazuje Dowod Osobisty: " .. name, {255, 152, 247})
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
  TriggerEvent('chatMessage',"^*Obywatel["  .. id .. "] Pokazuje Dowod Osobisty: " .. name, {255, 152, 247})
  end
end)

RegisterNetEvent('pokazujewiz')
AddEventHandler('pokazujewiz', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
  TriggerEvent('chatMessage',"^*Obywatel["  .. id .. "] Pokazuje Wizytówkę: " .. name, {255, 152, 247})
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
  TriggerEvent('chatMessage',"^*Obywatel["  .. id .. "] Pokazuje Wizytówkę: " .. name, {255, 152, 247})
  end
end)

RegisterNetEvent('pokazujeubez')
AddEventHandler('pokazujeubez', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
  TriggerEvent('chatMessage',"^*Obywatel["  .. id .. "] Pokazuje Ubezpieczenie: " .. name, {255, 152, 247})
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
  TriggerEvent('chatMessage',"^*Obywatel["  .. id .. "] Pokazuje Ubezpieczenie: " .. name, {255, 152, 247})
  end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)



RegisterNetEvent('citizen:menu_ob')
AddEventHandler('citizen:menu_ob',function()
	        MenuObywatela()

end)


RegisterNetEvent('citizen:menu_urz')
AddEventHandler('citizen:menu_urz',function()
	        MenuUrzad()

end)

function MenuUrzad()
  ESX.UI.Menu.Open(
  'default', GetCurrentResourceName(), 'esx_urzad',
  {
    title    = 'Urząd Los Santos',
    align    = 'center',
    elements = {
      {label = 'Wyrabiaj Dowód', value = 'dowod'},
      {label = 'Wyrabiaj Wizytowke', value = 'wiz'},
      {label = 'Wyrabiaj Karte zdrowia', value = 'ubez'},
      {label = 'Wyrabiaj Prawo Jazdy', value = 'prawojazdy'},
			{label = 'Urząd Pracy', value = 'up'}
    }
  },
  function(data, menu)
    if data.current.value == 'dowod' then
			ESX.UI.Menu.CloseAll()
			TriggerEvent("mythic_progbar:client:progress", {
        name = "unique_action_name",
        duration = 10000,
        label = "Wyrabianie dowodu...",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }
    }, function(status)
        if not status then
					TriggerServerEvent('urzad_daj:dawaj_to', 'dowod')
		      ESX.UI.Menu.CloseAll()
        end
    end)
		elseif data.current.value == 'prawojazdy' then
		ESX.UI.Menu.CloseAll()
		MenuPrawJazdy()
		elseif data.current.value == 'up' then
			ESX.UI.Menu.CloseAll()
		TriggerEvent("joblist:stand")
    elseif data.current.value == 'wiz' then
			ESX.UI.Menu.CloseAll()
			TriggerEvent("mythic_progbar:client:progress", {
			name = "unique_action_name",
			duration = 10000,
			label = "Wyrabianie wizytówki...",
			useWhileDead = false,
			canCancel = true,
			controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
			}
	}, function(status)
			if not status then
				TriggerServerEvent('urzad_daj:dawaj_to', 'wizytowka')
				ESX.UI.Menu.CloseAll()
			end
	end)
    elseif data.current.value == 'ubez' then
			ESX.UI.Menu.CloseAll()
			TriggerEvent("mythic_progbar:client:progress", {
			name = "unique_action_name",
			duration = 10000,
			label = "Wyrabianie karty zdrowia...",
			useWhileDead = false,
			canCancel = true,
			controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}
		}, function(status)
				if not status then
					TriggerServerEvent('urzad_daj:dawaj_to', 'ubezpieczenie')
					ESX.UI.Menu.CloseAll()
				end
		end)
    else
		end
  end,
  function(data, menu)
    menu.close()
    ESX.UI.Menu.CloseAll()
  end
)
end

function MenuPrawJazdy()
  ESX.UI.Menu.Open(
  'default', GetCurrentResourceName(), 'esx_dowodbeztele',
  {
    title    = 'Menu Obywatela',
    align    = 'right',
    elements = {
      {label = 'Prawo jazdy A', value = 'aa'},
      {label = 'Prawo jazdy B', value = 'bb'},
      {label = 'Prawo jazdy C', value = 'cc'},
    }
  },
  function(data, menu)
		if data.current.value == 'aa' then
			ESX.UI.Menu.CloseAll()
			TriggerEvent("mythic_progbar:client:progress", {
			name = "unique_action_name",
			duration = 10000,
			label = "Wyrabianie Licencje A...",
			useWhileDead = false,
			canCancel = true,
			controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
			}
		}, function(status)
				if not status then
					 TriggerServerEvent('urzad_daj:dawaj_lic', 'drive_bike')
					ESX.UI.Menu.CloseAll()
				end
			end)
		elseif data.current.value == 'bb' then
			ESX.UI.Menu.CloseAll()
			TriggerEvent("mythic_progbar:client:progress", {
		 name = "unique_action_name",
		 duration = 10000,
		 label = "Wyrabianie Licencje B...",
		 useWhileDead = false,
		 canCancel = true,
		 controlDisables = {
				 disableMovement = true,
				 disableCarMovement = true,
				 disableMouse = false,
				 disableCombat = true,
		 }
		}, function(status)
			 if not status then
					TriggerServerEvent('urzad_daj:dawaj_lic', 'drive')
				 ESX.UI.Menu.CloseAll()
			 end
		 end)
		elseif data.current.value == 'cc' then
			ESX.UI.Menu.CloseAll()
			TriggerEvent("mythic_progbar:client:progress", {
			name = "unique_action_name",
			duration = 10000,
			label = "Wyrabianie Licencje C...",
			useWhileDead = false,
			canCancel = true,
			controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
			}
		}, function(status)
				if not status then
					 TriggerServerEvent('urzad_daj:dawaj_lic', 'drive_truck')
					ESX.UI.Menu.CloseAll()
				end
			end)
		end
  end,
  function(data, menu)
    menu.close()
    ESX.UI.Menu.CloseAll()
		MenuUrzad()
  end
)
end


function MenuObywatela()
  ESX.UI.Menu.Open(
  'default', GetCurrentResourceName(), 'esx_dowodbeztele',
  {
    title    = 'Menu Obywatela',
    align    = 'right',
    elements = {
      {label = 'Dowod', value = 'dowod'},
      {label = 'Wizytowka', value = 'wiz'},
      {label = 'Ubezpieczenie', value = 'ubez'},
    }
  },
  function(data, menu)
    if data.current.value == 'dowod' then
      ExecuteCommand('dowod')
      ESX.UI.Menu.CloseAll()
      elseif data.current.value == 'wiz' then
        ExecuteCommand('wiz')
      ESX.UI.Menu.CloseAll()
      elseif data.current.value == 'ubez' then
        ExecuteCommand('ubez')
	      elseif data.current.value == 'odznaka' then
	        ExecuteCommand('odznaka')
      ESX.UI.Menu.CloseAll()

    elseif data.current.value == 'animacje' then
      TriggerEvent('esx_animations:openmenu')
    elseif data.current.value == 'ubrania' then
      TriggerEvent('zdejmowanieciuchy')
  elseif data.current.value == 'vehiclemenu' then
    local playerPed = GetPlayerPed(-1)
    if IsPedSittingInAnyVehicle(playerPed) then
        local playerVeh = GetVehiclePedIsIn(playerPed, false)
        local playerVeh = GetVehiclePedIsIn(playerPed, false)
        local drivingPed = GetPedInVehicleSeat(playerVeh, -1)
        if drivingPed == playerPed then
          TriggerEvent('carcontrol:open')
          ESX.UI.Menu.CloseAll()
        else
          ESX.ShowNotification('~r~Nie jestes w aucie!')
        end
    end

  end
  end,
  function(data, menu)
    menu.close()
    ESX.UI.Menu.CloseAll()
  end
)
end

function ShowAdvancedNotification(title, subject, msg, icon, iconType)



	SetNotificationTextEntry('STRING')
	AddTextComponentString(msg)
	SetNotificationMessage(icon, icon, false, iconType, title, subject)
	DrawNotification(false, false)

end
RegisterNetEvent('esx:dowod_pokazdowod')
AddEventHandler('esx:dowod_pokazdowod', function(id, imie, data, dodatek)




  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  local mugshot, mugshotStr = ESX.Game.GetPedMugshot(GetPlayerPed(pid))
  if pid == myId then
    SetNotificationBackgroundColor(200)
    ShowAdvancedNotification(imie, data, dodatek, mugshotStr)
		chowaniebronianim()
		pokazdowodanim()
		portfeldowodprop1()
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 9.999 then
    SetNotificationBackgroundColor(200)
    ShowAdvancedNotification(imie, data, dodatek, mugshotStr)

  end

  UnregisterPedheadshot(mugshot)

end)



RegisterNetEvent('esx:dowod_wiz')
AddEventHandler('esx:dowod_wiz', function(id, imie, data, dodatek)




  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  local mugshot, mugshotStr = ESX.Game.GetPedMugshot(GetPlayerPed(pid))
  if pid == myId then
    SetNotificationBackgroundColor(11)
    ShowAdvancedNotification(imie, data, dodatek, mugshotStr)
		chowaniebronianim()
		pokazdowodanim()
		portfeldowodprop1()
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 9.999 then
    SetNotificationBackgroundColor(11)
    ShowAdvancedNotification(imie, data, dodatek, mugshotStr)

  end

  UnregisterPedheadshot(mugshot)

end)

RegisterNetEvent('esx:dowod_pokazubezpieczenia')
AddEventHandler('esx:dowod_pokazubezpieczenia', function(id, data, imie, dodatek)


	local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  local mugshot, mugshotStr = ESX.Game.GetPedMugshot(GetPlayerPed(pid))
  if pid == myId then
    SetNotificationBackgroundColor(45)
    ShowAdvancedNotification(imie, data, dodatek, mugshotStr)
		chowaniebronianim()
		pokazdowodanim()
		portfeldowodprop1()
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 9.999 then
    SetNotificationBackgroundColor(45)
    ShowAdvancedNotification(imie, data, dodatek, mugshotStr)

  end

  UnregisterPedheadshot(mugshot)

end)



CreateThread(function()
	while true do
Citizen.Wait(5000)
TriggerServerEvent('esx_dowod:dajitem', GetPlayerPed(-1))
TriggerServerEvent('esx_dowod:dajwiz', GetPlayerPed(-1))


     end
end)

local LegitModel = "p_ld_id_card_01"
local animDict = "missfbi_s4mop"
local animName = "swipe_card"
local Legit_net = nil
local plateModel2 = "prop_fib_badge"
local animDict2 = "missfbi_s4mop"
local animName2 = "swipe_card"
local plate_net = nil


function chowaniebronianim()
  if not IsPedInAnyVehicle(PlayerPedId(), false) and not IsPedCuffed(PlayerPedId()) then
  SetCurrentPedWeapon(PlayerPedId(), -1569615261,true)
  Citizen.Wait(1)
  end
  end

  function pokazdowodanim()
  if not IsPedInAnyVehicle(PlayerPedId(), false) and not IsPedCuffed(PlayerPedId()) then
  RequestAnimDict("random@atmrobberygen")
  while (not HasAnimDictLoaded("random@atmrobberygen")) do Citizen.Wait(0) end
  TaskPlayAnim(PlayerPedId(), "random@atmrobberygen", "a_atm_mugging", 8.0, 3.0, 2000, 0, 1, false, false, false)
  end
  end

  function pokazblachaanim()
  if not IsPedInAnyVehicle(PlayerPedId(), false) and not IsPedCuffed(PlayerPedId()) then
  RequestAnimDict("random@atm_robbery@return_wallet_male")
  while (not HasAnimDictLoaded("random@atm_robbery@return_wallet_male")) do Citizen.Wait(0) end
  TaskPlayAnim(PlayerPedId(), "random@atm_robbery@return_wallet_male", "return_wallet_positive_a_player", 8.0, 3.0, 1000, 56, 1, false, false, false)
  end
  end

  function portfeldowodprop1()
  if not IsPedInAnyVehicle(PlayerPedId(), false) and not IsPedCuffed(PlayerPedId()) then
  usuwanieprop()
  portfel = CreateObject(GetHashKey('prop_ld_wallet_01'), GetEntityCoords(PlayerPedId()), true)-- creates object
  AttachEntityToEntity(portfel, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 0x49D9), 0.17, 0.0, 0.019, -120.0, 0.0, 0.0, 1, 0, 0, 0, 0, 1)
  Citizen.Wait(500)
  dowod = CreateObject(GetHashKey('prop_michael_sec_id'), GetEntityCoords(PlayerPedId()), true)-- creates object
  AttachEntityToEntity(dowod, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 0xDEAD), 0.150, 0.045, -0.015, 0.0, 0.0, 180.0, 1, 0, 0, 0, 0, 1)
  Citizen.Wait(1300)
  usuwanieportfelprop()
  end
  end


  function usuwanieprop()
  DeleteEntity(blacha)
  DeleteEntity(dowod)
  DeleteEntity(portfel)
  end

  function usuwanieportfelprop()
  DeleteEntity(dowod)
  Citizen.Wait(200)
  DeleteEntity(portfel)
  end

	function Draw3DText(x, y, z, text)
	    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	    local p = GetGameplayCamCoords()
	    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
	    local scale = (1 / distance) * 2
	    local fov = (1 / GetGameplayCamFov()) * 100
	    local scale = scale * fov
	    if onScreen then
	        SetTextScale(0.0, 0.35)
	        SetTextFont(4)
	        SetTextProportional(1)
	        SetTextColour(255, 255, 255, 255)
	        SetTextDropshadow(0, 0, 0, 0, 255)
	        SetTextEdge(2, 0, 0, 0, 150)
	        SetTextDropShadow()
	        SetTextOutline()
	        SetTextEntry("STRING")
	        SetTextCentre(1)
	        AddTextComponentString(text)
	        DrawText(_x,_y)
	    end
	end
