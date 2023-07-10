local resourceName = GetCurrentResourceName()
local spawnped = {
    spawned = false,
    ped = nil
  }
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- work ped
local function ped_vehicle()
    local model = Config.peds.spawn.model
    local coords = Config.peds.spawn.loc
    local anim = Config.peds.spawn.anim
    

    if lib.requestModel(model, 1000) then
        local ped = CreatePed(1, model, coords.x, coords.y, coords.z-1, coords.w, false, false)
        Util.g6sped_utils(ped, anim)
        spawnped.ped = ped
        local options = {
            {
                name = 'veh_create',
                icon = 'fa-solid fa-car',
                groups = Config.job.name,
                label = 'Request work vehicle',
                canInteract = function(_, distance)
                    return distance < 2.0
                end,
                onSelect = function()
                    local vehicle = Job.vehicle.model
                    if Config.frameWork == "ox" then
                        vehicle = lib.callback.await('veh:spawn', false, source)
                    elseif Config.frameWork == "esx" then
                        ESX.Game.SpawnVehicle(Job.vehicle.model, vec3(Job.vehicle.loc), Job.vehicle.loc[4], function(veh) 
                            vehicle = veh
                        end)
                    end
                    lib.notify({
                        title = 'Vehicle Management',
                        description = 'Your work vehicle is parked outside',
                        type = 'inform'
                    }) 
                end
            },
            {
                name = 'veh_delet',
                icon = 'fa-solid fa-xmark',
                groups = Config.job.name,
                label = 'Return work vehicle',
                canInteract = function(_, distance)
                    return distance < 2.0
                end,
                onSelect = function()
                    if Config.frameWork == "ox" then
                        lib.callback.await('veh:delete', false)
                    elseif Config.frameWork == "esx" then
                        local ped = PlayerPedId()
                        local veh = GetVehiclePedIsIn(ped, false)
                        ESX.Game.DeleteVehicle(veh)
                    end
                    lib.notify({
                        title = 'Vehicle Management',
                        description = 'Your work vehicle has been returned',
                        type = 'inform'
                    })
                end
            }
        }
      
      exports.ox_target:addLocalEntity(spawnped.ped, options)
      spawnped.spaned = true
    end
end

---------------------------------------------------------------
--------------------------------------------------------------------------------
-- context menu
lib.registerContext({
    id = 'vehicle_menu',
    title = 'Vehicle Menu',
    options = {
      {
        title = 'Spawn Vehicle',
        description = 'spawn work vehicle',
        icon = 'car',
        onSelect = function()
            local vehicle = Job.vehicle.model
            if Config.frameWork == "ox" then
                vehicle = lib.callback.await('veh:spawn', false, source)
            elseif Config.frameWork == "esx" then
                ESX.Game.SpawnVehicle(Job.vehicle.model, vec3(Job.vehicle.loc), Job.vehicle.loc[4], function(veh) 
                    vehicle = veh
                end)
            end
        end,
      },
      {
        title = 'Return Vehicle',
        description = 'return work vehicle',
        icon = 'car',
        onSelect = function()
            if Config.frameWork == "ox" then
                lib.callback.await('veh:delete', false)
            elseif Config.frameWork == "esx" then
                local ped = PlayerPedId()
                local veh = GetVehiclePedIsIn(ped, false)
                ESX.Game.DeleteVehicle(veh)
            end
        end,
      },
    }
  })

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- main thread
Citizen.CreateThread(function()
    if resourceName == GetCurrentResourceName() then
        ped_vehicle()
        Wait(1000)
    end
end)