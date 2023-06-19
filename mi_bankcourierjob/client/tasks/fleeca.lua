-- local variables
local task = nil
local working = false
local blip = nil
local job = Config.job.name
local pedjob = nil
local fleecaped = {
    spawned = false,
    ped = nil
}

-- set up job blip
local function spn_fleecablip()
    local coords = currenttask.loc
    local sprite = Job.blip.sprite
    local color = Job.blip.color
    local route = Job.blip.route
    local routecolor = Job.blip.routecolor
    local scale = Job.blip.scale
    local name = Job.blip.name
    blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    Util.g6sroute(sprite, color, route, routecolor, scale, name)
end

-- spawn task ped
local function spn_fleecaped(ped)
    local model = lib.requestmodel(joaat(task.model))
    local coords = task.loc
    local anim = task.anim
    if fleecaped.spawned then return
    else
        ped = CreatePed(1, model, coords.x, coords.y, coords.z-1, coords.w, false, false)
        Util.g6sped_utils(ped, anim)
        fleecaped.ped = ped
    end
end

-- delete task ped
local function del_fleecaped()
    if not fleecaped.spawned then return 
    else
        exports.ox_target:removeLocalEntity(fleecaped.ped, { 'miwt:c:dojob1' })
        Util.g6sremove_ped(fleecaped.ped)
        fleecaped.spawned = false
        fleecaped.ped = nil
    end
    
end

---------- Job Events ----------
RegisterNetEvent('g6s:fleeca:bank_first', function()
    local task = Job.fleeca
    if working then 
        lib.notify({
            title = 'Already working',
            description = 'Complete your current task before getting another one',
            type = 'error'
        })
    else
        pedjob = task[math.random(1, #task)]
        task = pedjob
        working = true
        spn_fleecablip()
        spn_fleecaped()

        local ped_options = {
            {
                name = 'fleecabank1',
                label = 'Do the job',
                groups = job,
                icon = 'fa-solid fa-sack-dollar',
                canInteract = function(_, distance)
                    return distance < 2.0 and working
                end,
                onSelect = function()
                    TriggerEvent('g6s:fleeca:bank_second')
                end
            }
        }
    
        exports.ox_target:addLocalEntity(fleecaped.ped, ped_options)
        fleecaped.spawned = true

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

RegisterNetEvent('g6s:fleeca:bank_second', function()
    local task = Job.fleeca
    if working then 
        lib.notify({
            title = 'Already working',
            description = 'Complete your current task before getting another one',
            type = 'error'
        })
    else
        pedjob = task[math.random(1, #task)]
        task = pedjob
        spn_fleecablip()
        spn_fleecaped()

        local ped_options = {
            {
                name = 'fleecabank1',
                label = 'Do the job',
                groups = job,
                icon = 'fa-solid fa-sack-dollar',
                canInteract = function(_, distance)
                    return distance < 2.0 and working
                end,
                onSelect = function()
                    TriggerEvent('g6s:fleeca:bank_second')
                end
            }
        }
    
        exports.ox_target:addLocalEntity(fleecaped.ped, ped_options)
        fleecaped.spawned = true
    end
end)

RegisterNetEvent('g6s:fleeca:bank_end', function()
    exports.scully_emotemenu:PlayByCommand('notepad')
    if lib.progressBar({
        duration = 3000,
        label = 'doing task',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
    }) then 
        lib.callback('pedpayout')
        del_fleecaped()
        working = false
        task = nil 
        Util.g6sremove_blip(blip)
    else 
        print('Do stuff when cancelled') 
    end
    exports.scully_emotemenu:CancelAnimation()
    lib.notify({
        id = 'fleeca',
        title = 'Fleeca: Transfer Money',
        description = 'Task completed. Payment sent to your bank account.',
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