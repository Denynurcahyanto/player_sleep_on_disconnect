-- Pastikan framework terdeteksi dengan aman
local QBCore, ESX, Framework = nil, nil, nil

-- Load framework berdasarkan konfigurasi
if Config.Framework:lower() == "qbcore" then
    QBCore = exports['qb-core']:GetCoreObject()
    Framework = "qbcore"
    print("[Players Sleep on Disconnect] QBCore framework loaded.")

elseif Config.Framework:lower() == "esx" then
    ESX = exports['es_extended']:getSharedObject()
    Framework = "esx"
    print("[Players Sleep on Disconnect] ESX framework loaded.")

elseif Config.Framework:lower() == "standalone" then
    Framework = "standalone"
    print("[Players Sleep on Disconnect] Running in standalone mode.")

else
    error("[Players Sleep on Disconnect] Invalid framework specified in config.lua.")
end

-- Event saat player disconnect
AddEventHandler('playerDropped', function(reason)
    local src = source
    local playerIdentifier

    -- Mendapatkan identifier sesuai framework
    if Framework == "qbcore" then
        playerIdentifier = QBCore.Functions.GetIdentifier(src, 'license')
    elseif Framework == "esx" then
        local identifiers = GetPlayerIdentifiers(src)
        for _, identifier in ipairs(identifiers) do
            if string.match(identifier, "license:") then
                playerIdentifier = identifier
                break
            end
        end
    elseif Framework == "standalone" then
        playerIdentifier = GetPlayerIdentifier(src, 0)
    end

    if not playerIdentifier then return end

    -- Simpan posisi player saat disconnect menggunakan oxmysql
    local ped = GetPlayerPed(src)
    local position = GetEntityCoords(ped)

    exports.oxmysql:execute('INSERT INTO player_sleep (identifier, posX, posY, posZ) VALUES (?, ?, ?, ?) ON DUPLICATE KEY UPDATE posX = ?, posY = ?, posZ = ?', {
        playerIdentifier, position.x, position.y, position.z,
        position.x, position.y, position.z
    })
end)

-- Event saat player connect kembali
RegisterNetEvent('playerConnecting', function(name, setKickReason, deferrals)
    local src = source
    local playerIdentifier

    -- Mendapatkan identifier sesuai framework
    if Framework == "qbcore" then
        playerIdentifier = QBCore.Functions.GetIdentifier(src, 'license')
    elseif Framework == "esx" then
        local identifiers = GetPlayerIdentifiers(src)
        for _, identifier in ipairs(identifiers) do
            if string.match(identifier, "license:") then
                playerIdentifier = identifier
                break
            end
        end
    elseif Framework == "standalone" then
        playerIdentifier = GetPlayerIdentifier(src, 0)
    end

    if not playerIdentifier then return end

    -- Ambil data posisi dari database menggunakan oxmysql
    exports.oxmysql:execute('SELECT posX, posY, posZ FROM player_sleep WHERE identifier = ?', {playerIdentifier}, function(result)
        if result and #result > 0 then
            local pos = result[1]
            TriggerClientEvent('player_sleep_on_disconnect:wakeUp', src, vector3(pos.posX, pos.posY, pos.posZ))
        end
    end)
end)