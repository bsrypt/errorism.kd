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
    debug('esx:onPlayerDeath')
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
        debug(store.get('death') or 0)
        debug('getDataStore:death')
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

function get(identifier)
    TriggerEvent('esx_datastore:getDataStore', key, identifier, function(store)
        local data = {
            death = store.get('death') or 0,
            kill = store.get('kill') or 0
        }
        return data
    end)
end
exports('get', get)

function getKill(identifier)
    TriggerEvent('esx_datastore:getDataStore', key, identifier, function(store)
        return store.get('kill') or 0
    end)
end
exports('getKill', getKill)

function getDeath(identifier)
    TriggerEvent('esx_datastore:getDataStore', key, identifier, function(store)
        return store.get('death') or 0
    end)
end
exports('getDeath', getDeath)

