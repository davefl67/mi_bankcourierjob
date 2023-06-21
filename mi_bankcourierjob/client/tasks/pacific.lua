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
AddEventHandler('g6s:pacific:start', function()
    taskA = Job.pacific
    if Work.working then 
        lib.notify({
            id = 'pacific1',
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
        local pedA = taskA[math.random(1, #taskA)]
        taskA = pedA
        Work.working = true
        Work.current = 'pacific'
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
                name = 'pacificbank1',
                label = 'Take money',
                groups = job,
                icon = 'fa-solid fa-sack-dollar',
                canInteract = function(_, distance)
                    return distance < 2.5 and Work.working
                end,
                onSelect = function()
                    lib.callback('g6s:give:moneybag', false, source)
                    exports.ox_target:removeLocalEntity(taskBped.ped, { 'pacificbank1' })
                    TriggerEvent('g6s:pacific:end')
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
            id = 'pacific1',
            title = 'Pacific: Business Deposit',
            description = 'Drive to the designated business for pickup',
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

RegisterNetEvent('g6s:pacific:end', function()
    taskB = Job.pacific.mngr
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
            name = 'pacificbank2',
            label = 'Deliver money',
            groups = job,
            icon = 'fa-solid fa-sack-dollar',
            canInteract = function(_, distance)
                return distance < 2.5 and Work.working
            end,
            onSelect = function()
                TriggerEvent('g6s:pacific:final')
                lib.callback('g6s:remove:moneybag', false, source)
                exports.ox_target:removeLocalEntity(taskBped.ped, { 'pacificbank2' })
                Wait(3000)
                Util.g6sremove_blip(blipB)
                Util.g6sremove_ped(taskBped.ped)
                
            end
        }
    }

    exports.ox_target:addLocalEntity(taskBped.ped, ped_options)
    taskBped.spawned = true

    lib.notify({
        id = 'pacific3',
        title = 'Pacific: Business Deposit',
        description = 'Deliver the money to the Manager at the Pacific Standard Bank',
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

RegisterNetEvent('g6s:pacific:final', function()
    lib.callback('payout:pacific')
    Work.working = false
    Work.current = nil
    lib.notify({
        id = 'pacific3',
        title = 'Fleeca: Transfer Complete',
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

RegisterNetEvent('g6s:pacific:cancelled', function()
    Work.working = false
    Work.current = nil

    exports.ox_target:removeLocalEntity(taskBped.ped, { 'pacificbank1' })
    Util.g6sremove_blip(blipA)
    blipA = nil
    Util.g6sremove_ped(taskAped.ped)
    taskAped.spawned = false
    taskA = nil
    Wait(1000)

    exports.ox_target:removeLocalEntity(taskBped.ped, { 'pacificbank2' })
    Util.g6sremove_blip(blipB)
    blipB = nil
    Util.g6sremove_ped(taskBped.ped)
    taskBped.spawned = false
    taskB = nil
    Wait(1000)
end)
