-- local variables
local resourceName = GetCurrentResourceName()
local workblip = nil

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- work blip
local function workloc_blip()
    local coords = Config.blip.loc
    local sprite = Config.blip.sprite
    local color = Config.blip.color
    local scale = Config.blip.scale
    local name = Config.blip.name

    if workblip ~= nil then
        RemoveBlip(workblip)
        workblip = nil
    end
    
    Util.blip(workblip, coords.x, coords.y, coords.z, sprite, color, scale, name)
end

local function loadjob()
    workloc_blip()
end

-- main thread
Citizen.CreateThread(function()
    if resourceName == GetCurrentResourceName() then
        loadjob()
        Citizen.Wait(1000)
    end
end)
local table = lib.table
In_service = player?.inservice 
    and table.contains(Config.job.name, player.inservice) 
    and player.hasGroup(Config.job.name)

lib.callback.register('startservice', function()
    In_service = not In_service and player.hasgroup(Config.job.name) or false
    lib.callback('s:setservice', false, function(group)
        print(group)
    end)
end)

lib.callback.await('logout', function()
    In_service = false
end)