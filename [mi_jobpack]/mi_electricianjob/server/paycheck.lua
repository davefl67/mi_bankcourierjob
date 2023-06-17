-- local variables
local pefcl = exports.pefcl
local paycheckInterval = Config.salary.intvl
local salary = Config.salary.pers 
local paychecks = {
    ['job1'] = { 100, 200, 300 },
}

-- job payout
lib.callback.register('pedpayout', function(source)
    exports.pefcl:addBankBalance(source, { 
        amount = Job.pedtask.payment, 
        message = 'Job: Task c/w'})
end)

-- job payout
lib.callback.register('objpayout', function(source)
    exports.pefcl:addBankBalance(source, { 
        amount = Job.objtask.payment, 
        message = 'Job: Task c/w'})
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
                    message = 'Work: Direct Deposit'  })
                pefcl:addBankBalance(player.source, { 
                    amount = paycheck, 
                    message = 'Work: Direct Deposit' })
            end
        end
    end
end)