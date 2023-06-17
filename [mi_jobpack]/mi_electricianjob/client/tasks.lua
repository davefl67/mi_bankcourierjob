-- local variables
local currenttask = nil
local working = false
local blip = nil

local job = Config.job.name

local pedjob = nil
local objjob = nil

local taskped = {
    spawned = false,
    ped = nil
}
local taskobj = {
    spawned = false,
    obj = nil
}

-- set up job blip
local function taskblip()
    local coords = currenttask.loc
    local sprite = Job.blip.sprite
    local color = Job.blip.color
    local route = Job.blip.route
    local routecolor = Job.blip.routecolor
    local scale = Job.blip.scale
    local name = Job.blip.name
    blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    Util.route(sprite, color, route, routecolor, scale, name)
end

-- spawn task ped
local function sp_taskped()
    local model = lib.requestmodel(joaat(currenttask.model))
    local coords = currenttask.loc
    local anim = currenttask.anim
    if taskped.spawned then return
    else
        local ped = CreatePed(1, model, coords.x, coords.y, coords.z-1, coords.w, false, false)
        Util.ped_utils(ped, anim)
        taskped.ped = ped
    end

    local ped_options = {
        {
            name = 'miwt:c:dojob2',
            label = 'Do the job',
            groups = job,
            icon = 'fa-solid fa-box',
            canInteract = function(_, distance)
                return distance < 2.0 and working
            end,
            onSelect = function()
                TriggerEvent('wt:c:pedtaskend')
            end
        }
    }

    exports.ox_target:addLocalEntity(taskped.ped, ped_options)
    taskped.spawned = true
end

-- delete task ped
local function dl_taskped()
    if not taskped.spawned then return 
    else
        exports.ox_target:removeLocalEntity(taskped.ped, { 'miwt:c:dojob1' })
        Util.remove_ped(taskped.ped)
        taskped.spawned = false
        taskped.ped = nil
    end
    
end

-- spawn task object
local function sp_taskobj()
    local model = lib.requestModel(joaat(currenttask.object))
    local coords = currenttask.loc
    if taskobj.spawned then return end
    local object = CreateObject(currenttask.object, coords.x, coords.y, coords.z, true, true, true)
    Util.obj_utils(object, model, coords.w)
    taskobj.obj = object

    local obj_options = {
        {
            name = 'miwt:c:dojob2',
            label = 'Do the job',
            icon = 'fa-solid fa-box',
            canInteract = function(_, distance)
                return distance < 2.0 and working
            end,
            onSelect = function()
                TriggerEvent('wt:c:objtaskend')
            end
        }
    }

    exports.ox_target:addLocalEntity(taskobj.obj, obj_options)
    taskobj.spawned = true
end

-- delete task object
local function dl_taskobj()
    if not taskobj.spawned then return 
    else
        exports.ox_target:removeLocalEntity(taskobj.obj, { 'miwt:c:dojob2' })
        DeleteEntity(taskobj.obj)
        taskobj.spawned = false
        taskobj.obj = nil
    end
    
end

---------- Job Events ----------
RegisterNetEvent('wt:c:pedtaskstart', function()
    local task = Job.pedtask
    if working then 
        lib.notify({
            title = 'Already working',
            description = 'Complete your current task before getting another one',
            type = 'error'
        })
    else
        pedjob = task[math.random(1, #task)]
        currenttask = pedjob
        working = true
        taskblip()
        sp_taskped()
        lib.notify({
            title = 'Task started',
            description = 'It\'s pizza time',
            type = 'inform'
        })
    end
end)

RegisterNetEvent('wt:c:pedtaskend', function()
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
        dl_taskped()
        working = false
        currenttask = nil 
        Util.remove_blip(blip)
    else 
        print('Do stuff when cancelled') 
    end
    exports.scully_emotemenu:CancelAnimation()
    lib.notify({
        title = 'Task Completed',
        description = 'Good Pizza Time',
        type = 'success'
    })
end)

RegisterNetEvent('wt:c:objtaskstart', function()
    local task = Job.objtask
    if working then 
        lib.notify({
            title = 'Already working',
            description = 'Complete your current task before getting another one',
            type = 'error'
        })
    else
        objjob = task[math.random(1, #task)]
        currenttask = objjob
        working = true
        taskblip()
        sp_taskobj()
        lib.notify({
            title = 'Task started',
            description = 'It\'s pizza time',
            type = 'inform'
        })
    end
end)

RegisterNetEvent('wt:c:objtaskend', function()
    exports.scully_emotemenu:PlayByCommand('mechanic4')
    if lib.progressBar({
        duration = 3000,
        label = 'doing task',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
    }) then 
        lib.callback('objpayout')
        dl_taskobj()
        working = false
        currenttask = nil
        Util.remove_blip(blip)
    else 
        print('Do stuff when cancelled') 
    end
    exports.scully_emotemenu:CancelAnimation()
    lib.notify({
        title = 'Task Completed',
        description = 'Good Pizza Time',
        type = 'success'
    })
end)