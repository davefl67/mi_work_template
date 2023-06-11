-- local variables
local resourceName = GetCurrentResourceName()
local workblip = nil
local has_job = false
local c_in_service = false

-- load work location blip
local function workloc_blip()
    if workblip ~= nil then
        RemoveBlip(workblip)
        workblip = nil
    end
    workblip = AddBlipForCoord(
        Config.wblip.loc.x, 
        Config.wblip.loc.y,
        Config.wblip.loc.z)
    SetBlipSprite(workblip, Config.wblip.sprite)
    SetBlipDisplay(workblip, 4)
    SetBlipColour(workblip, Config.wblip.color)
    SetBlipScale(workblip, Config.wblip.scale)
    SetBlipAsShortRange(workblip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(Config.wblip.name)
    EndTextCommandSetBlipName(workblip)
end

-- spawn work ped
local function ped_boss()
    if lib.requestModel(Config.vehicle_ped.model, 1000) then
        local npc = CreatePed(1, 
            Config.vehicle_ped.model, 
            Config.vehicle_ped.loc.x, 
            Config.vehicle_ped.loc.y, 
            Config.vehicle_ped.loc.z-1, 
            Config.vehicle_ped.loc.w, 
            false, false)
        TaskStartScenarioInPlace(npc, Config.vehicle_ped.anim, 0, true)
        FreezeEntityPosition(npc, true)
        SetEntityInvincible(npc, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
        local options = {
            {
                name = 'apply_job',
                label = 'Apply for job',
                icon = 'fa-solid fa-briefcase',
                --groups = Config.jobname,
                event = 'apply_job',
                onSelect = function()
                    lib.callback('ox_inventory:getItemCount', false, function(count)
                        print(count)
                    end, 'water')
                end,
                canInteract = function(_, distance)
                    return distance < 2.0 and has_job == false
                end
            },
        }
        exports.ox_target:addLocalEntity(npc, options)
    end
end

lib.callback.register('job_menu', function()

end)

-- spawn vehicle ped
local function ped_work()
    if lib.requestModel(Config.vehicle_ped.model, 1000) then
        local npc = CreatePed(1, 
            Config.vehicle_ped.model, 
            Config.vehicle_ped.loc.x, 
            Config.vehicle_ped.loc.y, 
            Config.vehicle_ped.loc.z-1, 
            Config.vehicle_ped.loc.w, 
            false, false)
        TaskStartScenarioInPlace(npc, Config.vehicle_ped.anim, 0, true)
        FreezeEntityPosition(npc, true)
        SetEntityInvincible(npc, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
        local options = {
            {
                name = 'spawn_vehicle',
                label = 'Spawn Vehicle 1',
                icon = 'fa-solid fa-car',
                groups = Config.jobname,
                event = 'spawn_vehicle',
                onSelect = function()
                    TriggerServerEvent('sp_vehicle', 'faggio')
                end,
                canInteract = function(_, distance)
                    return distance < 2.0 and c_in_service == true
                end
            },
        }
        exports.ox_target:addLocalEntity(npc, options)
    end
end
-- spawn vehicle ped
local function ped_vehicle()
    if lib.requestModel(Config.vehicle_ped.model, 1000) then
        local npc = CreatePed(1, 
            Config.vehicle_ped.model, 
            Config.vehicle_ped.loc.x, 
            Config.vehicle_ped.loc.y, 
            Config.vehicle_ped.loc.z-1, 
            Config.vehicle_ped.loc.w, 
            false, false)
        TaskStartScenarioInPlace(npc, Config.vehicle_ped.anim, 0, true)
        FreezeEntityPosition(npc, true)
        SetEntityInvincible(npc, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
        local options = {
            {
                name = 'spawn_vehicle',
                label = 'Spawn Vehicle 1',
                icon = 'fa-solid fa-car',
                groups = Config.jobname,
                event = 'spawn_vehicle',
                onSelect = function()
                    --TriggerServerEvent('sp_vehicle', 'faggio')
                end,
                canInteract = function(_, distance)
                    return distance < 2.0 and c_in_service == true
                end
            },
        }
        exports.ox_target:addLocalEntity(npc, options)
    end
end



local function loadjob()
    workloc_blip()
    ped_boss()
    ped_work()
    ped_vehicle()
end

-- main thread
Citizen.CreateThread(function()
    if resourceName == GetCurrentResourceName() then
        loadjob()
        Citizen.Wait(1000)
    end
end)
