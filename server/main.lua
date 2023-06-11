-- local veriables
local GetCurrentResourceName = GetCurrentResourceName()
local ox_inventory = exports.ox_inventory
local s_in_service = false

local stash = {
    id = 'lockerstash',
    label = 'Work Lockers',
    slots = 50,
    weight = 100000,
    owner = 'char1:license'
}

-- simple player service checker (server side)
lib.callback.register('checkin', function(source)
    if s_in_service == false then
        s_in_service = true
    else
        s_in_service = false
    end
end)

-- simple player service checker (server side)
lib.callback.register('setjob', function(source, group, grade)
    local player = Ox.GetPlayer()

    if player then
        player:setGroup(group, grade or 0)
    end
end)