local Framework = LoadFramework()

AddEventHandler('onClientResourceStart', function()
    Framework.LoadPlayerData()
end)

RegisterNetEvent('players-sleep:wakeUp')
AddEventHandler('players-sleep:wakeUp', function(coords)
    SetEntityCoords(PlayerPedId(), coords)
end)

AddEventHandler('onPlayerDisconnect', function()
    local coords = GetEntityCoords(PlayerPedId())
    local playerData = Framework.GetPlayerData()
    TriggerServerEvent('players-sleep:onDisconnect', coords, playerData)
end)