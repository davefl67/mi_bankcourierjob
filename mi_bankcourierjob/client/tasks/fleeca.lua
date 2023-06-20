-- local variables
local taskA = nil
local taskAped = {
    spawned = false,
    ped = nil
}

local taskB = nil
local taskBped = {
    spawned = false,
    ped = nil
}

local working = false
local blip = nil
local job = Config.job.name

-- set up job blip
local function spn_fleecablip(coords)
    local sprite = Job.blip.sprite
    local color = Job.blip.color
    local route = Job.blip.route
    local routecolor = Job.blip.routecolor
    local scale = Job.blip.scale
    local name = Job.blip.name
    blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    Util.g6sroute(sprite, color, route, routecolor, scale, name)
end

---------- Job Events ----------
RegisterNetEvent('g6s:fleeca:start', function()
    taskA = Job.fleeca
    if working then 
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
        working = true
        local model = lib.requestmodel(joaat(taskA.model))
        local coords = taskA.loc
        local anim = taskA.anim
        if taskAped.spawned then return
        else
            local ped = CreatePed(1, model, coords.x, coords.y, coords.z-1, coords.w, false, false)
            Util.g6sped_utils(ped, anim)
            taskAped.ped = ped
        end
        spn_fleecablip(coords)

        local ped_options = {
            {
                name = 'fleecabank1',
                label = 'Take money',
                groups = job,
                icon = 'fa-solid fa-sack-dollar',
                canInteract = function(_, distance)
                    return distance < 2.0 and working
                end,
                onSelect = function()
                    TriggerEvent('g6s:fleeca:end')
                    Wait(10000)
                    Util.g6sremove_ped(taskAped.ped)
                    taskAped.spawned = false
                    Util.g6sremove_blip(blip)
                end
            }
        }
    
        exports.ox_target:addLocalEntity(taskAped.ped, ped_options)
        taskAped.spawned = true

        lib.notify({
            id = 'fleeca1',
            title = 'Fleeca: Transfer Money',
            description = 'Deliver the money to the designated Fleeca Bank',
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

RegisterNetEvent('g6s:fleeca:end', function()
    taskB = Job.fleeca
    local pedB = taskB[math.random(1, #taskB)]
    taskB = pedB
    working = true
    local model = lib.requestmodel(joaat(taskB.model))
    local coords = taskB.loc
    local anim = taskB.anim
    if taskBped.spawned then return
    else
        local ped = CreatePed(1, model, coords.x, coords.y, coords.z-1, coords.w, false, false)
        Util.g6sped_utils(ped, anim)
        taskBped.ped = ped
    end
    spn_fleecablip(coords)

    local ped_options = {
        {
            name = 'fleecabank2',
            label = 'Deliver money',
            groups = job,
            icon = 'fa-solid fa-sack-dollar',
            canInteract = function(_, distance)
                return distance < 2.0 and working
            end,
            onSelect = function()
                TriggerEvent('g6s:fleeca:bank_second')
                Wait(10000)
                Util.g6sremove_ped(taskBped.ped)
            end
        }
    }

    exports.ox_target:addLocalEntity(taskBped.ped, ped_options)
    taskBped.spawned = true

    lib.notify({
        id = 'fleeca3',
        title = 'Fleeca: Transfer Money',
        description = 'Deliver the money to the designated Fleeca Bank',
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
