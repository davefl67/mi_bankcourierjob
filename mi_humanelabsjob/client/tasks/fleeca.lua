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
AddEventHandler('hls:task:start', function()
    taskA = Job.fleeca
    if Work.working then 
        lib.notify({
            id = 'fleeca1',
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
        Work.current = 'fleeca'
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
                name = 'fleecabank1',
                label = 'Take money',
                groups = job,
                icon = 'fa-solid fa-sack-dollar',
                canInteract = function(_, distance)
                    return distance < 2.5 and Work.working
                end,
                onSelect = function()
                    lib.callback('g6s:give:moneycase', false, source)
                    exports.ox_target:removeLocalEntity(taskBped.ped, { 'fleecabank1' })
                    TriggerEvent('g6s:fleeca:end')
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
            id = 'fleeca1',
            title = 'Fleeca: Transfer Money',
            description = 'Drive to the designated Fleeca Bank for pickup',
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


RegisterNetEvent('g6s:fleeca:final', function()
    lib.callback('payout:fleeca')
    Work.working = false
    Work.current = nil
    lib.notify({
        id = 'fleeca3',
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

RegisterNetEvent('g6s:fleeca:cancelled', function()
    Work.working = false
    Work.current = nil

    exports.ox_target:removeLocalEntity(taskBped.ped, { 'fleecabank1' })
    Util.g6sremove_blip(blipA)
    blipA = nil
    Util.g6sremove_ped(taskAped.ped)
    taskAped.spawned = false
    taskA = nil
    Wait(1000)

    exports.ox_target:removeLocalEntity(taskBped.ped, { 'fleecabank2' })
    Util.g6sremove_blip(blipB)
    blipB = nil
    Util.g6sremove_ped(taskBped.ped)
    taskBped.spawned = false
    taskB = nil
    Wait(1000)
end)
