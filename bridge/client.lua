local ox_inv = exports.ox_inventory
local frameWork = Config.frameWork


function getPlayerData()
    local data = false
    if frameWork == "esx" then
        data = ESX.GetPlayerData()
    elseif frameWork == "ox" then
        data = player
    end
    return data
end

function getPlayerJob()
    local job = false
    if frameWork == "esx" then
        job = ESX.GetPlayerData().job
    elseif frameWork == "ox" then
        job = player.groups
    end
    return job
end

function getPlayerName()
    local name = false
    if frameWork == "esx" then
        name = ESX.GetPlayerData().name
    elseif frameWork == "ox" then
        name = player.firstname .." ".. player.lastname
    end
    return name
end

function getVehProps(veh)
    local props = false
    if frameWork == "esx" then
        props = ESX.Game.GetVehicleProperties(veh)
    elseif frameWork == "ox" then
        props = lib.getVehicleProperties(veh)
    end
    return props
end

function setVehProps(veh, props)
    if frameWork == "esx" then
        ESX.Game.SetVehicleProperties(veh, props)
    elseif frameWork == "ox" then
        lib.setVehicleProperties(veh, props)
    end
end