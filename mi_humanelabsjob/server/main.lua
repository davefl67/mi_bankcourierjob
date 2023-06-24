-- local veriables
local Inventory = exports.ox_inventory

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- workped
lib.callback.register('g6s:securitytools', function(source)
    local armor = Inventory:CanCarryItem(source, 'bodyarmor_1', 1)
    local gun = Inventory:CanCarryItem(source, 'WEAPON_PISTOLXM3', 1)
    local ammo = Inventory:CanCarryItem(source, 'job_bag', 24)
    if armor == false and gun == false and ammo == false then return 
    else 
        Inventory:AddItem(source, 'bodyarmor_1', 1)
        Inventory:AddItem(source, 'WEAPON_PISTOLXM3', 1)
        Inventory:AddItem(source, 'ammo-9', 24)
    end
end)

lib.callback.register('g6s:workphone', function(source)
    local armor = Inventory:CanCarryItem(source, 'phone_g6s', 1)
    if armor == false then return 
    else 
        Inventory:AddItem(source, 'phone_g6s', 1)
    end
end)

lib.callback.register('g6s:give:moneycase', function(source)
    Inventory:AddItem(source, 'bank_case', 1)
end)

lib.callback.register('g6s:remove:moneycase', function(source)
    Inventory:RemoveItem(source, 'bank_case', 1)
end)

lib.callback.register('g6s:give:moneybag', function(source)
    Inventory:AddItem(source, 'bank_bag', 1)
end)

lib.callback.register('g6s:remove:moneybag', function(source)
    Inventory:RemoveItem(source, 'bank_bag', 1)
end)