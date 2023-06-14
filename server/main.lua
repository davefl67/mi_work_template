-- local veriables
local groupname = Config.job.name



lib.callback.register('service:setin', function(service)
    if service == false then
        return service == true
    end
end)

lib.callback.register('service:setout', function(service)
    if service == true then
        return service == false
    end
end)


-- simple player service checker (server side)
lib.callback.register('setjob', function(source, group, grade)
    local player = Ox.GetPlayer()

    if player then
        player:setGroup(group, grade or 0)
    end
end)