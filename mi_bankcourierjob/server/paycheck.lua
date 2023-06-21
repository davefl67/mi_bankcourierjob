-- local variables
local pefcl = exports.pefcl
local paycheckInterval = Config.salary.intvl
local salary = Config.salary.pers 
local paychecks = {
    ['bankcourier'] = { 100, 200 },
}

-- job payout: fleeca
lib.callback.register('payout:fleeca', function(source)
    exports.pefcl:addBankBalance(source, { 
        amount = Job.fleeca.payment, 
        message = 'G6S: Job completed'})
end)

-- job payout: pacific
lib.callback.register('payout:pacific', function(source)
    exports.pefcl:addBankBalance(source, { 
        amount = Job.pacific.payment, 
        message = 'G6S: Job completed'})
end)

-- job payout: paleto
lib.callback.register('payout:paleto', function(source)
    exports.pefcl:addBankBalance(source, { 
        amount = Job.paleto.payment, 
        message = 'G6S: Job completed'})
end)

-- Credit and thanks to FlakeSkillz for creating this method of paycheck intervals
---@diagnostic disable: missing-parameter, param-type-mismatch
CreateThread(function()
    while salary == true do
        Wait(paycheckInterval * 60000)
        for _, player in pairs(Ox.GetPlayers()) do
            local group = Config.job.name
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