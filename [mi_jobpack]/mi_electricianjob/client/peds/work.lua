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
        Util.ped_utils(ped, anim)
        workped.ped = ped
        local options = {
          {
            name = 'ox:option2',
            icon = 'fa-solid fa-briefcase',
            groups = Config.job.name,
            label = 'Request work bag',
            canInteract = function(_, distance)
                return distance < 2.0
            end,
            onSelect = function()
                lib.callback('wp:givebag', false, source)
            end
          },
          {
            name = 'ox:option2',
            icon = 'fa-solid fa-person-running',
            groups = Config.job.name,
            label = 'Request task type 1',
            canInteract = function(_, distance)
                return distance < 2.0
            end,
            onSelect = function()
              TriggerEvent('wt:c:pedtaskstart')
            end
          },
          {
            name = 'ox:option2',
            icon = 'fa-solid fa-gears',
            groups = Config.job.name,
            label = 'Request task type 2',
            canInteract = function(_, distance)
                return distance < 2.0
            end,
            onSelect = function()
              TriggerEvent('wt:c:objtaskstart')
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