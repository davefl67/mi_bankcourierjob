local resourceName = GetCurrentResourceName()
local workped = {
  spawned = false,
  ped = nil
}
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- work ped
local function ped_work()
    local model = Config.peds.work.model
    local coords = Config.peds.work.loc
    local anim = Config.peds.work.anim
    

    if lib.requestModel(model, 1000) then
        local ped = CreatePed(1, model, coords.x, coords.y, coords.z-1, coords.w, false, false)
        Util.g6sped_utils(ped, anim)
        workped.ped = ped
        local options = {
          {
            name = 'ox:option2',
            icon = 'fa-solid fa-briefcase',
            groups = Config.job.name,
            label = 'Request equipment',
            canInteract = function(_, distance)
                return distance < 2.0
            end,
            onSelect = function()
                lib.callback('g6s:securitytools', false, source)
            end
          },
          {
            name = 'ox:option2',
            icon = 'fa-solid fa-sack-dollar',
            groups = Config.job.name,
            label = 'Fleeca: Transfer Money',
            canInteract = function(_, distance)
                return distance < 2.0
            end,
            onSelect = function()
              TriggerEvent('g6s:c:pedtaskstart')
            end
          },
          {
            name = 'ox:option2',
            icon = 'fa-solid fa-building-columns',
            groups = Config.job.name,
            label = 'Pacific Standard: Collect',
            canInteract = function(_, distance)
                return distance < 2.0
            end,
            onSelect = function()
              TriggerEvent('g6s:c:objtaskstart')
            end
          },
          {
            name = 'ox:option2',
            icon = 'fa-solid fa-landmark',
            groups = Config.job.name,
            label = 'Paleto Savings: Collect',
            canInteract = function(_, distance)
                return distance < 2.0
            end,
            onSelect = function()
              TriggerEvent('g6s:c:objtaskstart')
            end
          }
      }
      
      exports.ox_target:addLocalEntity(workped.ped, options)
      workped.spaned = true
    end
end

-- point location
local workped_coords = Config.peds.work.loc
local workped = lib.points.new({
    coords = workped_coords,
    distance = 3,
    currentDistance = 2
})


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- main thread
Citizen.CreateThread(function()
    if resourceName == GetCurrentResourceName() then
        ped_work()
        Citizen.Wait(1000)
    end
end)