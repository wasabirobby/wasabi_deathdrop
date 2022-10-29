-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
local weaponsOnly = false -- Weapons only that drop?

ESX = exports["es_extended"]:getSharedObject()

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
    data.victim = source
    local xPlayer = ESX.GetPlayerFromId(data.victim)
    local rawInventory = exports.ox_inventory:Inventory(data.victim).items
    local inventory = {}
    if weaponsOnly then
        for _,v in pairs(rawInventory) do
            if v.name:sub(0, 7) == 'WEAPON_' then
                inventory[#inventory + 1] = {
                    v.name,
                    v.count,
                    v.metadata
                }
                exports.ox_inventory:RemoveItem(data.victim, v.name, v.count, v.metadata)
            end
        end
    else
        for _,v in pairs(rawInventory) do
            inventory[#inventory + 1] = {
                v.name,
                v.count,
                v.metadata
            }
        end
    end
    local deathCoords = xPlayer.getCoords(true)
    if #inventory > 0 then
        exports.ox_inventory:CustomDrop('Death Drop', inventory, deathCoords)
    end
    if not weaponsOnly then
        exports.ox_inventory:ClearInventory(data.victim, false)
    end
end)