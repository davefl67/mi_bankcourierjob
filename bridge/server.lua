local ox_inv = exports.ox_inventory
local pefcl = exports.pefcl
local frameWork = Config.frameWork

-- Money things
function addMoney(playerId, amount)
    if frameWork == "esx" then
        local xPlayer = ESX.GetPlayerFromId(playerId)
        xPlayer.addMoney(amount)
    elseif frameWork == "ox" then
        ox_inv:AddItem(playerId, 'money', amount)
    end
end

function removeMoney(playerId, amount)
    if frameWork == "esx" then
        local xPlayer = ESX.GetPlayerFromId(playerId)
        xPlayer.removeMoney(amount)
    elseif frameWork == "ox" then
        ox_inv:RemoveItem(playerId, 'money', amount)
    end
end

function addBankBalance(playerId, amount, msg)
    if frameWork == "esx" then
        local xPlayer = ESX.GetPlayerFromId(playerId)
        xPlayer.addAccountMoney('bank', amount)
    elseif frameWork == "ox" then
        pefcl:addBankBalance(playerId, { 
            amount = amount, 
            message = msg
        })
    end
end

function removeBankBalance(playerId, amount)
    if frameWork == "esx" then
        local xPlayer = ESX.GetPlayerFromId(playerId)
        xPlayer.removeAccountMoney('bank', amount)
    elseif frameWork == "ox" then
        pefcl:removeBankBalance(playerId, { 
            amount = amount, 
            message = msg
        })
    end
end

function getMoney(playerId, amount)
    local money = 0
    if frameWork == "esx" then
        local xPlayer = ESX.GetPlayerFromId(playerId)
        money = xPlayer.getMoney()
        return money
    elseif frameWork == "ox" then
        money = ox_inv:GetItem(playerId, 'money', nil, true)
    end
    return money
end

function getBankBalance(playerId, identifier)
    local money
    if frameWork == "esx" then
        local xPlayer = ESX.GetPlayerFromId(playerId)
        money = xPlayer.getAccount('bank').money
    elseif frameWork == "ox" then
        money = pefcl:getTotalBankBalanceByIdentifier(source, identifier) -- IDK if this is right :D 
    end
    return money
end

function addSocietyBalance(society, amount)
    if frameWork == "esx" then
        local soc = exports["esx_society"]:GetSociety(society)
        TriggerEvent('esx_addonaccount:getSharedAccount', soc.account, function(account)
            if amount > 0 and account.money >= amount then
                account.addMoney(amount)
            else
                return false
            end
        end)
    elseif frameWork == "ox" then
        -- You need to add this
    end
end

function removeSocietyBalance(society, amount, source, msg)
    local money
    if frameWork == "esx" then
        local soc = exports["esx_society"]:GetSociety(society)
        TriggerEvent('esx_addonaccount:getSharedAccount', soc.account, function(account)
            if amount > 0 and account.money >= amount then
                account.removeMoney(amount)
            else
                return false
            end
        end)
    elseif frameWork == "ox" then
        pefcl:removeBankBalanceByIdentifier(source, { 
            identifier = society, 
            amount = amount, 
            message = msg
        })
    end
end


function getSocietyBalance(society, src)
    local money
    if frameWork == "esx" then
        local soc = exports["esx_society"]:GetSociety(society)
        TriggerEvent('esx_addonaccount:getSharedAccount', soc.account, function(account)
            money = account.money
        end)
    elseif frameWork == "ox" then
        money = pefcl:getTotalBankBalanceByIdentifier(src, society)
    end
    return money
end

-- Items

function getItem(playerId, name)
    local item = false
    if frameWork == "esx" then
        local xPlayer = ESX.GetPlayerFromId(playerId)
        item = xPlayer.getInventoryItem(name)
    elseif frameWork == "ox" then
        item = ox_inv:GetItem(playerId, name, nil, true)
    end
    return item
end

function addItem(playerId, name, count)
    if frameWork == "esx" then
        local xPlayer = ESX.GetPlayerFromId(playerId)
        if xPlayer.canCarryItem(name, count) then
            xPlayer.addInventoryItem(name, count)
        else
            return false
        end
    elseif frameWork == "ox" then
        if exports.ox_inventory:CanCarryItem(source, name, count) then
            ox_inv:AddItem(playerId, name, count)
        else
            return false
        end
    end
    return true
end

function removeItem(playerId, name, count)
    if frameWork == "esx" then
        local xPlayer = ESX.GetPlayerFromId(playerId)
        xPlayer.removeInventoryItem(name, count)
    elseif frameWork == "ox" then
        ox_inv:RemoveItem(playerId, 'money', amount)
    end
end

-- Player

function getPlayers()
    local players = false
    if frameWork == "esx" then
        players = ESX.GetPlayers()
    elseif frameWork == "ox" then
        players = Ox.GetPlayers
    end
    return players
end

function getPlayer(playerId)
    local player = false
    if frameWork == "esx" then
        player = ESX.GetPlayerFromId(playerId)
    elseif frameWork == "ox" then
        player = Ox.GetPlayer(playerId)
    end
    return players
end


function getGroup(playerId)
    local group = false
    if frameWork == "esx" then
        local xPlayer = ESX.GetPlayerFromId(playerId)
        group = xPlayer.getGroup()
    elseif frameWork == "ox" then
        local player = Ox.GetPlayer(playerId)
        group = player.getGroup()
    end
    return group
end