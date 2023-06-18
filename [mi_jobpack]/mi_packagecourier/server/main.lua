-- local veriables
local Inventory = exports.ox_inventory

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- workped
lib.callback.register('wp:givebag', function(source)
    local carry = Inventory:CanCarryItem(source, 'job_bag', 1)
    if carry == false then return 
    else 
        Inventory:AddItem(source, 'job_bag', 1)
    end
end)