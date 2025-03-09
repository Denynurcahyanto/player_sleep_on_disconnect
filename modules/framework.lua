function LoadFramework()
    if Config.Framework == 'ESX' and GetResourceState('es_extended') == 'started' then
        ESX = exports['es_extended']:getSharedObject()
        return ESXFramework()
    elseif Config.Framework == 'QBCore' and GetResourceState('qb-core') == 'started' then
        QBCore = exports['qb-core']:GetCoreObject()
        return QBCoreFramework()
    else
        return StandaloneFramework()
    end
end

function ESXFramework()
    return {
        GetPlayerData = function()
            return ESX.GetPlayerData()
        end,
        SavePlayerData = function(playerId, playerData, coords)
            -- Simpan data ESX di sini
        end
    }
end

function QBCoreFramework()
    return {
        GetPlayerData = function()
            return QBCore.Functions.GetPlayerData()
        end,
        SavePlayerData = function(playerId, playerData, coords)
            -- Simpan data QBCore di sini
        end
    }
end

function StandaloneFramework()
    return {
        GetPlayerData = function()
            return {} -- Manual input untuk standalone
        end,
        SavePlayerData = function(playerId, playerData, coords)
            -- Simpan data Standalone di sini
        end
    }
end