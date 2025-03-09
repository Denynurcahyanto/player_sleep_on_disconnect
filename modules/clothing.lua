function ApplyClothing(playerData)
    if Config.ClothingSystem == 'esx_skin' then
        TriggerEvent('skinchanger:loadSkin', playerData.skin)
    elseif Config.ClothingSystem == 'qb-clothing' then
        TriggerEvent('qb-clothing:client:loadOutfit', playerData.clothing)
    elseif Config.ClothingSystem == 'illenium' then
        exports['illenium-appearance']:setPlayerAppearance(playerData.appearance)
    end
end