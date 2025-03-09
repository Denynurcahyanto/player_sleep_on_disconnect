function LoadTarget()
    if Config.TargetSystem == 'ox_target' and GetResourceState('ox_target') == 'started' then
        exports['ox_target']:addEntityZone('sleepingPlayer', {
            name = 'sleepingPlayer',
            icon = 'fa fa-bed',
            label = 'Loot Player',
            action = function(entity)
                LootPlayer(NetworkGetEntityOwner(entity))
            end
        })
    elseif Config.TargetSystem == 'qb-target' and GetResourceState('qb-target') == 'started' then
        exports['qb-target']:AddTargetEntity('sleepingPlayer', {
            options = {
                {
                    type = 'client',
                    event = 'players-sleep:lootPlayer',
                    icon = 'fa fa-bed',
                    label = 'Loot Player'
                }
            },
            distance = 2.5
        })
    end
end