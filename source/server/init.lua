ESX = exports['es_extended']:getSharedObject()
local key = 'errorism_kd'

local alreadyLogin = {}
local skipDeathCount = {}

RegisterNetEvent('esx:onPlayerSpawn', function(data)
    if alreadyLogin[source] then return end
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end
    local isDead = MySQL.scalar.await('SELECT is_dead FROM users WHERE identifier = ?', {xPlayer.identifier}) or false
    if isDead then
        skipDeathCount[source] = true
    end
    alreadyLogin[source] = true
end)

RegisterNetEvent('esx:onPlayerDeath', function(data)
    local deathSource = source
    if skipDeathCount[deathSource] then
        skipDeathCount[deathSource] = false
        return
    end
    local deathXPlayer = ESX.GetPlayerFromId(deathSource)
    if not deathxPlayer then return end
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

AddEventHandler('playerDropped', function()
    alreadyLogin[source] = false
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

