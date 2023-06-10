-- local variables
local pefcl = exports.pefcl
local paycheckInterval = 15
local paychecks = {
    ['job1'] = { 100, 200, 300 },
}

-- job payout
lib.callback.register('payout', function(source)
    exports.pefcl:addBankBalance(source, { 
        amount = Config.job1.payment, 
        message = 'Job: Task c/w'})
end)

-- Credit and thanks to FlakeSkillz for creating this method of paycheck intervals
---@diagnostic disable: missing-parameter, param-type-mismatch
CreateThread(function()
    while s_in_service == true do
        Wait(paycheckInterval * 60000)
        for _, player in pairs(Ox.GetPlayers()) do
            local group = Config.jobname
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