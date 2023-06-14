-- local variables
local resourceName = GetCurrentResourceName()
local workblip = nil
local table = lib.table
InService = player?.inService 
    and table.contains(Config.job.name, player.inService) 
    and player.hasGroup(Config.job.name)

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

lib.callback.register('startservice', function()
    
end)

lib.callback.await('logout', function()
    InService = false
end)

-- main thread
Citizen.CreateThread(function()
    if resourceName == GetCurrentResourceName() then
        loadjob()
        Citizen.Wait(1000)
    end
end)
