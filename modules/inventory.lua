function LootPlayer(targetPlayer)
    if Config.InventorySystem == 'ox_inventory' and GetResourceState('ox_inventory') == 'started' then
        exports['ox_inventory']:openInventory('player', targetPlayer)
    elseif Config.InventorySystem == 'qb-inventory' and GetResourceState('qb-inventory') == 'started' then
        TriggerServerEvent('inventory:server:OpenInventory', 'player', targetPlayer)
    else
        -- Sistem inventory lainnya
    end
end