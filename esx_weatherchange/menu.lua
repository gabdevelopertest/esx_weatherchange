ESX = nil

local MenuPosition = "right"

rightPosition = {x = 5000, y = 3000}
leftPosition = {x = 3000, y = 3000}
menuPosition = {x = 1200, y = 200}  

_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Weather Menu", "~h~~r~ Coded By Toxic Maniax#8753",menuPosition["x"], menuPosition["y"])
_menuPool:Add(mainMenu)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function Player(menu)
    local submenu = _menuPool:AddSubMenu(menu, "~g~Weather Options","", menuPosition["x"], menuPosition["y"])
    local click = NativeUI.CreateItem("~w~ExtraSunny", "~p~Changes The Weather")
    _menuPool:MouseControlsEnabled(false)
     click.Activated = function (sender, item, index)
        if item == click then
            SetWeatherTypeOverTime("EXTRASUNNY", 0)
            _menuPool:CloseAllMenus()
        end
    end
     local ammo = NativeUI.CreateItem("~g~Rain", "~g~Changes The Weather")
     _menuPool:MouseControlsEnabled(false)
      ammo.Activated = function (sender, item, index)
         if item == ammo then
          SetWeatherTypeOverTime("RAIN", 0)
          _menuPool:CloseAllMenus()
        end
      end
 local heal = NativeUI.CreateItem("~b~OverCast", "~g~Changes The Weather")
_menuPool:MouseControlsEnabled(false)
 heal.Activated = function (sender, item, index)
    if item == heal then
      SetWeatherTypeOverTime("Overcast", 0)
      _menuPool:CloseAllMenus()
    end
 end
 local heal2 = NativeUI.CreateItem("~b~Overcast", "~g~Changes The Weather")
 _menuPool:MouseControlsEnabled(false)
  heal.Activated = function (sender, item, index)
     if item == heal then
       SetWeatherTypeOverTime("OVERCAST", 0)
       _menuPool:CloseAllMenus()
     end
  end
 local heal1 = NativeUI.CreateItem("~b~Fog", "~g~Changes The Weather")
 _menuPool:MouseControlsEnabled(false)
  heal1.Activated = function (sender, item, index)
     if item == heal1 then
      SetWeatherTypeOverTime("FOGGY", 0)
      _menuPool:CloseAllMenus()
     end
  end
submenu:AddItem(click)
submenu:AddItem(heal)
submenu:AddItem(heal1)
submenu:AddItem(heal2)
submenu:AddItem(ammo)
end

function Player2(menu)
  local submenu = _menuPool:AddSubMenu(menu, "~g~Time Options","", menuPosition["x"], menuPosition["y"])
  local click = NativeUI.CreateItem("~m~Day", "")
  _menuPool:MouseControlsEnabled(false)
   click.Activated = function (sender, item, index)
      if item == click then
        NetworkOverrideClockTime(12,00,00)
          _menuPool:CloseAllMenus()
      end
  end
   local ammo = NativeUI.CreateItem("~m~Night", "")
   _menuPool:MouseControlsEnabled(false)
    ammo.Activated = function (sender, item, index)
       if item == ammo then
        NetworkOverrideClockTime(23,40,00)
        _menuPool:CloseAllMenus()
      end
    end
submenu:AddItem(click)
submenu:AddItem(ammo)
end


Player(mainMenu)
Player2(mainMenu)
_menuPool:RefreshIndex()
Citizen.CreateThread(function()
  while true do
      Citizen.Wait(0)
      _menuPool:ProcessMenus()
RegisterCommand("changeweather", function(source, args, rawCommand)
  mainMenu:Visible(not mainMenu:Visible())
  notify('Menus Opened')
end, false) -- set this to false to allow anyone.      
end
end)

RegisterCommand("day", function(source, args, rawCommand)
  NetworkOverrideClockTime(12,00,00)
end, false)

RegisterCommand("night", function(source, args, rawCommand)
  NetworkOverrideClockTime(23,40,00)
end, false)



--[[ COPY BELOW ]]

function notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(true, true)
end

function giveWeapon(hash)
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(hash), 999, false, false)
end

function spawnCar(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(50)
    end

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, x + 2, y + 2, z + 1, GetEntityHeading(PlayerPedId()), true, false)
    SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
    
    SetEntityAsNoLongerNeeded(vehicle)
    SetModelAsNoLongerNeeded(vehicleName)
    
    --[[ SetEntityAsMissionEntity(vehicle, true, true) ]]
end

