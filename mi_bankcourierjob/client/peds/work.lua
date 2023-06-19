local resourceName = GetCurrentResourceName()
local time = Job.cooldown
local timer = false
local workped = {
  spawned = false,
  ped = nil
}
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- work ped
local function cooldown()
  timer = true
  SetTimeout(time * 60000, function()
    timer = false
  end)
end

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
              if timer then 
                lib.notify({
                  id = 'equipment',
                  title = 'Request denied',
                  description = 'Wait a while before requesting more equipment',
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
              }) return
              else
                cooldown()
                lib.callback('g6s:securitytools', false, source)
              end
                
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
              TriggerEvent('g6s:fleeca:bank_first')
              lib.notify({
                id = 'fleeca',
                title = 'Fleeca: Transfer Money',
                description = 'Go to the designated fleeca bank and meet with the manager for pickup',
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
          },
          {
            name = 'ox:option2',
            icon = 'fa-solid fa-building-columns',
            groups = Config.job.name,
            label = 'Pacific: Business Deposit',
            canInteract = function(_, distance)
                return distance < 2.0
            end,
            onSelect = function()
              lib.notify({
                id = 'pacific',
                title = 'Pacific: Business Deposit',
                description = 'Go to the designated business and meet with the manager for pickup',
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
          },
          {
            name = 'ox:option2',
            icon = 'fa-solid fa-landmark',
            groups = Config.job.name,
            label = 'Paleto Savings: Transfer',
            canInteract = function(_, distance)
                return distance < 2.0
            end,
            onSelect = function()
              lib.notify({
                id = 'paleto',
                title = 'Paleto: Transfer',
                description = 'Grab the money from the trolly and transfer it to the Paleto Savings Bank',
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