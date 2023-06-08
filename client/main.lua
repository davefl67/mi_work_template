local ox_inventory = exports.ox_inventory
local res_start = false

local workblip = nil
local job_blip = nil
local cur_task = nil
local in_work = false
local c_in_service = false

local taskped = {
    spawned = false,
    ped = nil
}

local taskobj = {
    spawned = false,
    obj = nil
}

---------- Work Location ----------
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
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(Config.wblip.name)
    EndTextCommandSetBlipName(workblip)
end

local function vehicle_ped()
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
                    TriggerServerEvent('sp_vehicle', Config.vehicle.model1)
                end,
                canInteract = function(_, distance)
                    return distance < 2.0 and c_in_service == true
                end
            },
            {
                name = 'spawn_vehicle',
                label = 'Spawn Vehicle 2',
                icon = 'fa-solid fa-car',
                groups = Config.jobname,
                event = 'spawn_vehicle',
                onSelect = function()
                    TriggerServerEvent('sp_vehicle', Config.vehicle.model2)
                end,
                canInteract = function(_, distance)
                    return distance < 2.0 and c_in_service == true
                end
            },
            {
                name = 'spawn_vehicle',
                label = 'Spawn Vehicle 3',
                icon = 'fa-solid fa-car',
                groups = Config.jobname,
                event = 'spawn_vehicle',
                onSelect = function()
                    TriggerServerEvent('sp_vehicle', Config.vehicle.model3)
                end,
                canInteract = function(_, distance)
                    return distance < 2.0 and c_in_service == true
                end
            },
        }
    
        exports.ox_target:addLocalEntity(npc, options)
    end
end

local function boss_ped()
    if lib.requestModel(Config.boss_ped.model, 1000) then
        local npc = CreatePed(1, 
            Config.boss_ped.model, 
            Config.boss_ped.loc.x, 
            Config.boss_ped.loc.y, 
            Config.boss_ped.loc.z-1, 
            Config.boss_ped.loc.w, 
            false, false)
        TaskStartScenarioInPlace(npc, Config.boss_ped.anim, 0, true)
        FreezeEntityPosition(npc, true)
        SetEntityInvincible(npc, true)
        SetBlockingOfNonTemporaryEvents(npc, true)

        local options = {
            {
                name = 'clock_in',
                label = 'Clock in',
                icon = 'fa-solid fa-check',
                groups = Config.jobname,
                event = 'clock_in',
                onSelect = function()
                    c_in_service = true
                    lib.callback('checkin')
                    lib.notify({
                        title = 'In Service',
                        description = 'You have checked in to work',
                        type = 'inform'
                    })
                end,
                canInteract = function(_, distance)
                    return distance < 2.0 and c_in_service == false
                end
            },
            {
                name = 'clock_out',
                label = 'Clock out',
                icon = 'fa-solid fa-xmark',
                groups = Config.jobname,
                event = 'clock_out',
                onSelect = function()
                    c_in_service = false
                    lib.notify({
                        title = 'Out of Service',
                        description = 'You have checked out of work',
                        type = 'inform'
                    })
                end,
                canInteract = function(_, distance)
                    return distance < 2.0 and c_in_service == true
                end
            },
            {
                name = 'start_job1',
                label = 'Job Option 1',
                icon = 'fa-solid fa-user',
                groups = Config.jobname,
                event = 'start_job1',
                onSelect = function()
                    TriggerEvent('miwt:c:start_job1')
                end,
                canInteract = function(_, distance)
                    return distance < 2.0 and c_in_service == true
                end
            },
            {
                name = 'start_job2',
                label = 'Job Option 2',
                icon = 'fa-solid fa-user',
                groups = Config.jobname,
                event = 'start_job1',
                onSelect = function()
                    TriggerEvent('miwt:c:start_job2')
                end,
                canInteract = function(_, distance)
                    return distance < 2.0 and c_in_service == true
                end
            },
            
        }
        exports.ox_target:addLocalEntity(npc, options)
    end
end

local function zone_vehicle()
    local vehicle_zone = lib.zones.box({
        coords = Config.vehicle.loc,
        size = vec3(2, 4, 2),
        rotation = Config.vehicle.head,
        debug = Config.debug,
        inside = inside,
        onEnter = function()
            lib.registerContext({
                id = 'vehicle_menu',
                title = 'Vehicle Menu',
                menu = 'veh_menu',
                options = {
                    {
                        title = 'Return vehicle',
                        description = 'Return vehicle to garage',
                        icon = 'car',
                        onSelect = function()
                            TriggerServerEvent('dl_vehicle')
                        end,
                    },
                }
            })
            lib.showContext('vehicle_menu')
        end,
        onExit = function()
            lib.hideContext('vehicle_menu')
        end
    })
end

local function zone_stash()
    exports.ox_target:addBoxZone({
        coords = Config.jobstash.loc,
        size = vec3(1.25, 0.9, 1.5),
        rotation = Config.jobstash.head,
        debug = Config.debug,
        options = {
            {
                name = 'job_stash',
                event = 'ox_target:debug',
                icon = 'fa-solid fa-archive',
                label = Config.jobstash_label,
                onSelect = function()
                    ox_inventory:openInventory('stash', {id = 'work_lockers', owner = false})
                end

            }
        }
    })
end


---------- Main Thread ----------
Citizen.CreateThread(function()
    while res_start == false do
        
        workloc_blip()
        vehicle_ped()
        boss_ped()
        zone_vehicle()
        zone_stash()

        res_start = true
        Citizen.Wait(1000)

    end
end)
