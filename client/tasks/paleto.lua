-- local variables
local blipA = nil
local taskA = nil
local taskAped = {
    spawned = false,
    ped = nil
}

local blipB = nil
local taskB = nil
local taskBped = {
    spawned = false,
    ped = nil
}
local job = Config.job.name

---------- Job Events ----------
AddEventHandler('g6s:paleto:start', function()
    if Work.working then 
        lib.notify({
            id = 'paleto1',
            title = 'G6 Security: Job in Progress',
            description = 'Complete your task befor getting another',
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
    else
        taskA = Job.paleto.mngr1
        Work.working = true
        Work.current = 'paleto'
        local model = lib.requestmodel(joaat(taskA.model))
        local coords = taskA.loc
        local anim = taskA.anim
        if taskAped.spawned then return
        else
            local ped = CreatePed(1, model, coords.x, coords.y, coords.z-1, coords.w, false, false)
            Util.g6sped_utils(ped, anim)
            taskAped.ped = ped
        end
        blipA = nil
        local sprite = 1
        local color = 2
        local route = true
        local routecolor = 2
        local scale = 0.7
        local name = 'Job site'
        if blipA ~= nil then
            Util.g6sremove_blip(blipA)
            blipA = nil
        end
        
        blipA = AddBlipForCoord(coords.x, coords.y, coords.z)
        Util.g6sroute(sprite, color, route, routecolor, scale, name)

        local ped_options = {
            {
                name = 'paletobank1',
                label = 'Take money',
                groups = job,
                icon = 'fa-solid fa-sack-dollar',
                canInteract = function(_, distance)
                    return distance < 2.5 and Work.working
                end,
                onSelect = function()
                    lib.callback('g6s:give:moneybag', false, source)
                    exports.ox_target:removeLocalEntity(taskBped.ped, { 'paletobank1' })
                    TriggerEvent('g6s:paleto:end')
                    Wait(3000)
                    Util.g6sremove_blip(blipA)
                    Util.g6sremove_ped(taskAped.ped)
                    taskAped.spawned = false
                    
                end
            }
        }
    
        exports.ox_target:addLocalEntity(taskAped.ped, ped_options)
        taskAped.spawned = true

        lib.notify({
            id = 'paleto1',
            title = 'Paleto Savings: Transfer',
            description = 'Pick up the money from the Pacific Standard Manager',
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
    end
end)

RegisterNetEvent('g6s:paleto:end', function()
    taskB = Job.paleto.mngr2
    local model = lib.requestmodel(joaat(taskB.model))
    local coords = taskB.loc
    local anim = taskB.anim
    if taskBped.spawned then 
    else
        local ped = CreatePed(1, model, coords.x, coords.y, coords.z-1, coords.w, false, false)
        Util.g6sped_utils(ped, anim)
        taskBped.ped = ped
    end
    blipB = nil
    local sprite = 1
    local color = 2
    local route = true
    local routecolor = 2
    local scale = 0.7
    local name = 'Job site'
    if blipB ~= nil then
        Util.g6sremove_blip(blipB)
        blipB = nil
    end
    
    blipB = AddBlipForCoord(coords.x, coords.y, coords.z)
    Util.g6sroute(sprite, color, route, routecolor, scale, name)
    
    
    local ped_options = {
        {
            name = 'paletobank2',
            label = 'Deliver money',
            groups = job,
            icon = 'fa-solid fa-sack-dollar',
            canInteract = function(_, distance)
                return distance < 2.5 and Work.working
            end,
            onSelect = function()
                TriggerEvent('g6s:paleto:final')
                lib.callback('g6s:remove:moneybag', false, source)
                exports.ox_target:removeLocalEntity(taskBped.ped, { 'paletobank2' })
                Wait(3000)
                Util.g6sremove_blip(blipB)
                Util.g6sremove_ped(taskBped.ped)
                
            end
        }
    }

    exports.ox_target:addLocalEntity(taskBped.ped, ped_options)
    taskBped.spawned = true

    lib.notify({
        id = 'paleto3',
        title = 'Paleto Savings: Transfer',
        description = 'Deliver the money to the Manager at the Paleto Savings Bank',
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

end)

RegisterNetEvent('g6s:paleto:final', function()
    lib.callback('payout:paleto')
    Work.working = false
    Work.current = nil
    lib.notify({
        id = 'paleto3',
        title = 'Paleto Savings: Transfer Complete',
        description = 'Money delivered. Payment deposited to account',
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
end)

RegisterNetEvent('g6s:paleto:cancelled', function()
    Work.working = false
    Work.current = nil

    exports.ox_target:removeLocalEntity(taskBped.ped, { 'paletobank1' })
    Util.g6sremove_blip(blipA)
    blipA = nil
    Util.g6sremove_ped(taskAped.ped)
    taskAped.spawned = false
    taskA = nil
    Wait(1000)

    exports.ox_target:removeLocalEntity(taskBped.ped, { 'paletobank2' })
    Util.g6sremove_blip(blipB)
    blipB = nil
    Util.g6sremove_ped(taskBped.ped)
    taskBped.spawned = false
    taskB = nil
    Wait(1000)
end)
