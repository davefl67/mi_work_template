-- local veriables
local groupname = Config.job.name


-- simple player service checker (server side)
lib.callback.register('setjob', function(source, group, grade)
    local player = Ox.GetPlayer()

    if player then
        player:setGroup(group, grade or 0)
    end
end)