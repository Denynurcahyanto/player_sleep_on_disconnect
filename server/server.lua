local Framework = LoadFramework()

RegisterNetEvent('players-sleep:onDisconnect')
AddEventHandler('players-sleep:onDisconnect', function(coords, playerData)
    SavePlayerData(source, playerData, coords)
end)

function SavePlayerData(playerId, playerData, coords)
    Framework.SavePlayerData(playerId, playerData, coords)
end