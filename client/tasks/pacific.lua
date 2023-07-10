-- local variables
local blipstart = nil
local taskstart = nil
local taskstartped = {
    spawned = false,
    ped = nil
}

local blipend = nil
local taskend = nil
local taskendped = {
    spawned = false,
    ped = nil
}

local nextblip = nil
local nexttask = nil
local nextped = {
    spawned = false,
    ped = nil
}

local job = Config.job.name
local stopcount = 0
local totalcount = Job.pacific.maxstop



---------- Job Events ----------
AddEventHandler('g6s:pacific:start', function()
    taskstart = Job.pacific
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
        local pedA = taskstart[math.random(1, #taskstart)]
        taskstart = pedA
        Work.working = true
        Work.current = 'pacific'
        local model = lib.requestmodel(joaat(taskstart.model))
        local coords = taskstart.loc
        local anim = taskstart.anim
        if taskstartped.spawned then return
        else
            local ped = CreatePed(1, model, coords.x, coords.y, coords.z-1, coords.w, false, false)
            Util.g6sped_utils(ped, anim)
            taskstartped.ped = ped
        end
        blipstart = nil
        local sprite = 1
        local color = 2
        local route = true
        local routecolor = 2
        local scale = 0.7
        local name = 'Job site'
        if blipstart ~= nil then
            Util.g6sremove_blip(blipstart)
            blipstart = nil
        end
        
        blipstart = AddBlipForCoord(coords.x, coords.y, coords.z)
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
                    exports.ox_target:removeLocalEntity(taskstartped.ped, { 'pacificbank1' })
                    TriggerEvent('g6s:pacific:nextjob')
                    TriggerEvent('g6s:pacific:end')
                    Wait(3000)
                    Util.g6sremove_blip(blipstart)
                    Util.g6sremove_ped(taskstartped.ped)
                    taskstartped.spawned = false
                end
            }
        }
    
        exports.ox_target:addLocalEntity(taskstartped.ped, ped_options)
        taskstartped.spawned = true
        Util.g6snotify('pacific1', 'Pacific: Business Deposit', 
        'Drive to the designated business for pickup')
    end
end)

AddEventHandler('g6s:pacific:nextjob', function()
    local nxtped = nil
    repeat
        nexttask = Job.pacific
        nxtped = nexttask[math.random(1, #nexttask)]
    until(nxtped ~= taskstart)
    nexttask = nxtped

    local model = lib.requestmodel(joaat(nexttask.model))
    local coords = nexttask.loc
    local anim = nexttask.anim
    if nextped.spawned then 
    else
        local ped = CreatePed(1, model, coords.x, coords.y, coords.z-1, coords.w, false, false)
        Util.g6sped_utils(ped, anim)
        nextped.ped = ped
    end

    nextblip = nil
    local sprite = 1
    local color = 2
    local route = true
    local routecolor = 2
    local scale = 0.7
    local name = 'Job site'
    if nextblip ~= nil then
        Util.g6sremove_blip(nextblip)
        nextblip = nil
    end
    nextblip = AddBlipForCoord(coords.x, coords.y, coords.z)
    Util.g6sroute(sprite, color, route, routecolor, scale, name)

    local ped_options = {
        {
            name = 'pacificnxt',
            label = 'Take money',
            groups = job,
            icon = 'fa-solid fa-sack-dollar',
            canInteract = function(_, distance)
                return distance < 2.5 and Work.working
            end,
            onSelect = function()
                lib.callback('g6s:give:moneybag', false, source)
                Wait(3000)
                Util.g6sremove_blip(nextblip)
                Util.g6sremove_ped(nextped.ped)
                Wait(500)
                TriggerEvent('g6s:pacific:nextjob')
                nextped.spawned = true
                Util.g6snotify('pacific1', 'Pacific: Business Deposit', 
                'Drive to the designated business for pickup or return the money to the bank')
            end
        }
    }

    exports.ox_target:addLocalEntity(nextped.ped, ped_options)
    

end)

RegisterNetEvent('g6s:pacific:end', function()
    taskend = Job.pacific.mngr
    local model = lib.requestmodel(joaat(taskend.model))
    local coords = taskend.loc
    local anim = taskend.anim
    if taskendped.spawned then 
    else
        local ped = CreatePed(1, model, coords.x, coords.y, coords.z-1, coords.w, false, false)
        Util.g6sped_utils(ped, anim)
        taskendped.ped = ped
    end
    blipend = nil
    local sprite = 1
    local color = 2
    local route = true
    local routecolor = 2
    local scale = 0.7
    local name = 'Bank Delivery'
    if blipend ~= nil then
        Util.g6sremove_blip(blipend)
        blipend = nil
    end

    blipend = AddBlipForCoord(coords.x, coords.y, coords.z)
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
                Wait(250)
                lib.callback('payout:pacific')
                exports.ox_target:removeLocalEntity(taskendped.ped, { 'pacificbank2' })
                Wait(3000)
                Util.g6sremove_blip(blipend)
                Util.g6sremove_ped(taskendped.ped)
                
            end
        }
    }

    exports.ox_target:addLocalEntity(taskendped.ped, ped_options)
    taskendped.spawned = true
    Util.g6snotify('pacific3', 'Pacific: Business Deposit', 
    'Deliver the money to the Manager at the Pacific Standard Bank')
end)

RegisterNetEvent('g6s:pacific:final', function()
    Work.working = false
    Work.current = nil
    TriggerEvent('g6s:pacific:cancelled')
    Util.g6snotify('pacific3', 'Pacific: Transfer Complete', 
    'Money delivered. Payment deposited to account')
end)

RegisterNetEvent('g6s:pacific:cancelled', function()
    Work.working = false
    Work.current = nil

    exports.ox_target:removeLocalEntity(taskstartped.ped, { 'pacificbank1' })
    Util.g6sremove_blip(blipstart)
    blipstart = nil
    Util.g6sremove_ped(taskstartped.ped)
    taskstartped.spawned = false
    taskstart = nil
    Wait(250)

    exports.ox_target:removeLocalEntity(taskendped.ped, { 'pacificnxt' })
    Util.g6sremove_blip(nextblip)
    nextblip = nil
    Util.g6sremove_ped(nextped.ped)
    nextped.spawned = false
    nexttask = nil
    Wait(250)

    exports.ox_target:removeLocalEntity(taskendped.ped, { 'pacificbank2' })
    Util.g6sremove_blip(blipend)
    blipend = nil
    Util.g6sremove_ped(taskendped.ped)
    taskendped.spawned = false
    taskend = nil
    Wait(250)
end)
