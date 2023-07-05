Work = {}
Work.working = false
Work.current = nil
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

local function givetools()
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

local function givephone()
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
    lib.callback('g6s:workphone', false, source)
  end
end

local function ped_tasks()
  local options = {
    {
      name = 'g6s:work:phone',
      icon = 'fa-solid fa-mobile-screen',
      groups = Config.job.name,
      label = 'Request work phone',
      canInteract = function(_, distance)
          return distance < 2.0
      end,
      onSelect = function()
        givephone()
      end
    },
    {
      name = 'g6s:work:equipment',
      icon = 'fa-solid fa-briefcase',
      groups = Config.job.name,
      label = 'Request equipment',
      canInteract = function(_, distance)
          return distance < 2.0
      end,
      onSelect = function()
        givetools()
      end
    },
    {
      name = 'g6s:work:fleeca',
      icon = 'fa-solid fa-sack-dollar',
      groups = Config.job.name,
      label = 'Fleeca: Transfer Money',
      canInteract = function(_, distance)
          return distance < 2.0 and not Work.working
      end,
      onSelect = function()
        TriggerEvent('g6s:fleeca:start')
        Work.current = 'fleeca'
      end
    },
    {
      name = 'g6s:work:pacific',
      icon = 'fa-solid fa-building-columns',
      groups = Config.job.name,
      label = 'Pacific: Business Deposit',
      canInteract = function(_, distance)
          return distance < 2.0 and not Work.working
      end,
      onSelect = function()
        TriggerEvent('g6s:pacific:start')
        Work.current = 'pacific'
      end
    },
    {
      name = 'g6s:work:paleto',
      icon = 'fa-solid fa-landmark',
      groups = Config.job.name,
      label = 'Paleto Savings: Transfer',
      canInteract = function(_, distance)
          return distance < 2.0 and not Work.working
      end,
      onSelect = function()
        TriggerEvent('g6s:paleto:start')
        Work.current = 'paleto'
      end
    },

    {
      name = 'g6s:work:fleecacancel',
      icon = 'fa-solid fa-xmark',
      groups = Config.job.name,
      label = 'Cancel Job',
      canInteract = function(_, distance)
          return distance < 2.0 and Work.working and Work.current == 'fleeca'
      end,
      onSelect = function()
        TriggerEvent('g6s:fleeca:cancelled')
        Work.current = nil
        lib.notify({
          id = 'taskcancel',
          title = 'G6 Security: Task canceled',
          description = 'Job cancelled. You many now pick another job',
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
      name = 'g6s:work:pacificcancel',
      icon = 'fa-solid fa-xmark',
      groups = Config.job.name,
      label = 'Cancel Job',
      canInteract = function(_, distance)
          return distance < 2.0 and Work.working and Work.current == 'pacific'
      end,
      onSelect = function()
        TriggerEvent('g6s:pacific:cancelled')
        Work.current = nil
        lib.notify({
          id = 'taskcancel',
          title = 'G6 Security: Task canceled',
          description = 'Job cancelled. You many now pick another job',
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
      name = 'g6s:work:paletocancel',
      icon = 'fa-solid fa-xmark',
      groups = Config.job.name,
      label = 'Cancel Job',
      canInteract = function(_, distance)
          return distance < 2.0 and Work.working and Work.current == 'paleto'
      end,
      onSelect = function()
        TriggerEvent('g6s:paleto:cancelled')
        Work.current = nil
        lib.notify({
          id = 'taskcancel',
          title = 'G6 Security: Task canceled',
          description = 'Job cancelled. You many now pick another job',
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
  }

  exports.ox_target:addLocalEntity(workped.ped, options)
  workped.spawned = true
end

local function ped_work()
    local model = Config.peds.work.model
    local coords = Config.peds.work.loc
    local anim = Config.peds.work.anim
    

    if lib.requestModel(model, 1000) then
        local ped = CreatePed(1, model, coords.x, coords.y, coords.z-1, coords.w, false, false)
        Util.g6sped_utils(ped, anim)
        workped.ped = ped
        
    end
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- main thread


Citizen.CreateThread(function()
    if resourceName == GetCurrentResourceName() then
        ped_work()
        Wait(1000)
        if not Work.working then
          ped_tasks()
          Wait(1000)
        end
    end
end)