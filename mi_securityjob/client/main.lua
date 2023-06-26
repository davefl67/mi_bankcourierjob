-- local variables
local resourceName = GetCurrentResourceName()
local workblip = nil

local active = Config.teleport.active
local pointa = Config.teleport.pointa
local pointb = Config.teleport.pointb

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- work blip
local function workloc_blip()
    local coords = Config.blip.loc
    local sprite = Config.blip.sprite
    local color = Config.blip.color
    local scale = Config.blip.scale
    local name = Config.blip.name

    if workblip ~= nil then
        RemoveBlip(workblip)
        workblip = nil
    end
    
    Util.g6sblip(workblip, coords.x, coords.y, coords.z, sprite, color, scale, name)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- teleport
local job_pointa = lib.points.new({
    coords = pointa,
    distance = 5,
    currentDistance = 2
})
function job_pointa:nearby()
    if active == false then
        return
    else
        if self.currentDistance < 1 then
            lib.showTextUI('[E] - Use Elevator')
        end
        if self.currentDistance < 1 and IsControlJustReleased(0, 38) then
            lib.hideTextUI()
            lib.showContext('elevator_left')
        end
        if self.currentDistance > 1 then
            lib.hideTextUI()
        end
    end
end

local job_pointb = lib.points.new({
    coords = pointb,
    distance = 5,
    currentDistance = 2
})
function job_pointb:nearby()
    if active == false then
        return
    else
        if self.currentDistance < 2 then
            lib.showTextUI('[E] - Use Elevator')
        end
        if self.currentDistance < 2 and IsControlJustReleased(0, 38) then
            lib.hideTextUI()
            lib.showContext('elevator_left')
        end
        if self.currentDistance > 2 then
            lib.hideTextUI()
        end
    end
end

-- elevator context left
lib.registerContext({
    id = 'elevator_left',
    title = 'Job Elevator',
    options = {
        {   -- lux floor
            title = 'Point A',
            description = 'Teleport marker',
            icon = 'elevator',
            onSelect = function()
                    Util.g6steleport(cache.ped, pointa.x, pointa.y, pointa.z, pointa.w)
            end,
        },
        {   -- box floor
            title = 'Point B',
            description = 'Teleport marker',
            icon = 'elevator',
            onSelect = function()
                    Util.g6steleport(cache.ped, pointb.x, pointb.y, pointb.z, pointb.w)
            end,
        },
    }
})

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- exports




exports('g6sworkphonemenu', function()
    lib.registerContext({
        id = 'phone_menu',
        title = 'G6Security: Mobile Phone',
        options = {
            {   
                title = 'Fleeca: Transfer Money',
                description = 'Transfer money between Fleeca Banks',
                icon = 'sack-dollar',
                onSelect = function()
                    TriggerEvent('g6s:fleeca:start')
                    Work.current = 'fleeca'
                end,
            },
            {   
                title = 'Pacific: Business Deposit',
                description = 'Transfer money from business to Pacific standard',
                icon = 'building-columns',
                onSelect = function()
                    TriggerEvent('g6s:pacific:start')
                    Work.current = 'pacific'
                end,
            },
            {   
                title = 'Paleto Savings: Transfer',
                description = 'Transfer money between Pacific to Paleto',
                icon = 'landmark',
                onSelect = function()
                    TriggerEvent('g6s:paleto:start')
                    Work.current = 'paleto'
                end,
            },

            {   
                title = 'Cancel current Job',
                description = 'Quit the current task you are on',
                icon = 'xmark',
                onSelect = function()
                    TriggerEvent('g6s:fleeca:cancelled')
                    TriggerEvent('g6s:pacific:cancelled')
                    TriggerEvent('g6s:paleto:cancelled')
                    Work.current = nil
                    lib.notify({
                        id = 'taskcancel',
                        title = 'G6 Security: Task canceled',
                        description = 'Job cancelled. You many now pick another job',
                        position = 'top-right',
                        style = {
                            backgroundColor = '#F4F6F7',
                            color = '#252525',
                            ['.description'] = {
                              color = '#4B4B4B'
                            }
                        },
                        icon = '6',
                        iconColor = '#28B463'
                    })
                end,
            },
        }
    })

    lib.showContext('phone_menu')
end)


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- main thread
Citizen.CreateThread(function()
    if resourceName == GetCurrentResourceName() then
        workloc_blip()
        Citizen.Wait(1000)
    end
end)
