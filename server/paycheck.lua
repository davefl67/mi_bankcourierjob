-- local variables
local pefcl = exports.pefcl
local paycheckInterval = Config.salary.intvl
local salary = Config.salary.pers 
local gname = Config.job.name
local paychecks = {
    ['bankcourier'] = { 100, 200 },
}

-- job payout: fleeca
lib.callback.register('payout:fleeca', function(source)
    addBankBalance(source, Job.fleeca.payment, 'G6S: Job completed')
end)

-- job payout: pacific
lib.callback.register('payout:pacific', function(source)
    addBankBalance(source, Job.pacific.payment * SM.bagtotal, 'G6S: Job completed')
end)

-- job payout: paleto
lib.callback.register('payout:paleto', function(source)
    addBankBalance(source, Job.paleto.payment, 'G6S: Job completed')
    SM.bagtotal = 0
end)

-- Credit and thanks to FlakeSkillz for creating this method of paycheck intervals
---@diagnostic disable: missing-parameter, param-type-mismatch
if Config.frameWork == "ox" then
    CreateThread(function()
        while salary == true do
            Wait(paycheckInterval * 60000)
            for _, player in pairs(Ox.GetPlayers()) do
                local group = gname
                local grade = player.getGroup(group)
                local paycheck = paychecks?[group]?[grade]

                if paycheck > 0 and pefcl:getTotalBankBalanceByIdentifier(player.source, group) then
                    pefcl:removeBankBalanceByIdentifier(player.source, { 
                        identifier = group, 
                        amount = paycheck, 
                        message = 'G6S: Direct Deposit'  })
                    pefcl:addBankBalance(player.source, { 
                        amount = paycheck, 
                        message = 'G6S: Direct Deposit' })
                end
            end
        end
    end)
elseif Config.frameWork == "esx" then
    CreateThread(function()
        while salary == true do
            Wait(paycheckInterval * 60000)
            
            for _, player in pairs(ESX.GetExtendedPlayers("job", gname)) do
                local job = player.job
                local paycheck = paychecks?[job.name]?[job.grade]

                if paycheck > 0 and pefcl:getTotalBankBalanceByIdentifier(player.source, group) then
                    pefcl:removeBankBalanceByIdentifier(player.source, { 
                        identifier = group, 
                        amount = paycheck, 
                        message = 'G6S: Direct Deposit'  })
                    pefcl:addBankBalance(player.source, { 
                        amount = paycheck, 
                        message = 'G6S: Direct Deposit' })
                end
            end
        end
    end)
end