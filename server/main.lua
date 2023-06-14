-- local veriables
local players = {}
local table = lib.table

-- credit to OverExtended team for service methods from ox_police
-- player service thread
CreateThread(function()
    for _, player in pairs(Ox.GetPlayers(true, {groups = Config.job.name})) do
        local inservice = player.get('inservice')
        if inservice and table.contains(Config.job.name, inservice) then
            players[player.source] = player
        end
    end
end)

lib.callback.register('s:setservice', function(group)
    local player = Ox.GetPlayer(source)
    if player then
        if group and table.contains(Config.job.name, group) and player.hasGroup(Config.job.name) then
            player[source] = player
            return player.set('inservice', group, true)
        end
        player.set('inservice', false, true)
    end
    players[source] = nil
end)

AddEventHandler('s:logout', function(source)
    players[source] = nil
end)

lib.callback.register('s:isinservice', function(source, target)
    return players[target or source]
end)

-- simple player service checker (server side)
lib.callback.register('setjob', function(source, group, grade)
    local player = Ox.GetPlayer()

    if player then
        player:setGroup(group, grade or 0)
    end
end)