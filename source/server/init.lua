ESX = exports['es_extended']:getSharedObject()
local key = 'errorism_kd'

local skipDeathCount = {}

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
    if not xPlayer then
        xPlayer = ESX.GetPlayerFromId(playerId)
    end
    local isDead = MySQL.scalar.await('SELECT is_dead FROM users WHERE identifier = ?', {xPlayer.identifier}) or false
    if isDead then
        skipDeathCount[playerId] = true
    end
end)

RegisterNetEvent('esx:onPlayerDeath', function(data)
    local deathSource = source
    if skipDeathCount[deathSource] then
        skipDeathCount[deathSource] = false
        return
    end
    local deathXPlayer = ESX.GetPlayerFromId(deathSource)
    if not deathXPlayer then return end
    TriggerEvent('esx_datastore:getDataStore', key, deathXPlayer.identifier, function(store)
        local death = store.get('death') or 0
        store.set('death', death + 1)
    end)
    if not data?.killedByPlayer then return end
    local killerSource = data.killerServerId
    local killerXPlayer = ESX.GetPlayerFromId(killerSource)
    if not killerXPlayer then return end
    TriggerEvent('esx_datastore:getDataStore', key, killerXPlayer.identifier, function(store)
        local kill = store.get('kill') or 0
        store.set('kill', kill + 1)
    end)
end)
-- TODO Add a function to get the kill and death count of a player
function get(identifier)
    local p = promise.new()
    TriggerEvent('esx_datastore:getDataStore', key, identifier, function(store)
        local result = {
            death = store.get('death') or 0,
            kill = store.get('kill') or 0
        }
        p:resolve(result)
    end)
    return Citizen.Await(p)
end
exports('get', get)
function getKill(identifier)
    local p = promise.new()
    TriggerEvent('esx_datastore:getDataStore', key, identifier, function(store)
        p:resolve(store.get('kill') or 0)
    end)
    return Citizen.Await(p)
end
exports('getKill', getKill)

function getDeath(identifier)
    local p = promise.new()
    TriggerEvent('esx_datastore:getDataStore', key, identifier, function(store)
        p:resolve(store.get('death') or 0)
    end)
    return Citizen.Await(p)
end
exports('getDeath', getDeath)

