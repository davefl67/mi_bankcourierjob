-- local veriables
local Inventory = exports.ox_inventory
SM = {}
SM.bagtotal = 0

local file = ('imports/%s.lua'):format(IsDuplicityVersion() and 'server' or 'client')
local import = LoadResourceFile('ox_core', file)
local chunk = assert(load(import, ('@@ox_core/%s'):format(file)))
chunk()

-- borrowed from ox_police to help with paycheck issue
local players = {}
local table = lib.table

CreateThread(function()
    for _, player in pairs(Ox.GetPlayers(true, { groups = Config.job.name })) do
        local inService = player.get('inService')

        if inService and table.contains(Config.job.name, inService) then
            players[player.source] = player
        end
    end
end)


RegisterNetEvent('ox:setPlayerInService', function(group)
    local player = Ox.GetPlayer(source)

    if player then
        if group and table.contains(Config.job.name, group) and player.hasGroup(Config.job.name) then
            players[source] = player
            return player.set('inService', group, true)
        end
        player.set('inService', false, true)
    end

    players[source] = nil
end)

AddEventHandler('ox:playerLogout', function(source)
    players[source] = nil
end)

lib.callback.register('ox_police:isPlayerInService', function(source, target)
    return players[target or source]
end)

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- workped
lib.callback.register('g6s:securitytools', function(source)
    addItem(source, 'bodyarmor_1', 1)
    addItem(source, 'WEAPON_PISTOLXM3', 1)
    addItem(source, 'job_bag', 24)
end)

lib.callback.register('g6s:workphone', function(source)
    addItem(source, 'phone_g6s', 1)
end)

lib.callback.register('g6s:give:moneycase', function(source)
    addItem(source, 'bank_case', 1)
end)

lib.callback.register('g6s:remove:moneycase', function(source)
    removeItem(source, 'bank_case', 1)
end)

lib.callback.register('g6s:give:moneybag', function(source)
    addItem(source, 'bank_bag', 1)
end)

lib.callback.register('g6s:remove:moneybag', function(source)
    local total = getItem(source, 'bank_bag')
    removeItem(source, 'bank_bag', total)
    SM.bagtotal = total
end)