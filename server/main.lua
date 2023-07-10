-- local veriables
local Inventory = exports.ox_inventory
SM = {}
SM.bagtotal = 0

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