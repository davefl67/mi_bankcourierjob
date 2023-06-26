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
                vehicle = lib.callback.await('veh:spawn', false, source)
                print(vehicle)
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
                lib.callback.await('veh:delete', false)
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
            vehicle = lib.callback.await('veh:spawn', false, source)
            print(vehicle)
        end,
      },
      {
        title = 'Return Vehicle',
        description = 'return work vehicle',
        icon = 'car',
        onSelect = function()
            lib.callback.await('veh:delete', false)
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
        Citizen.Wait(1000)
    end
end)