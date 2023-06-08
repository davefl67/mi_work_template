---------- Job Functions ----------
local function sp_jblip()
    if job_blip ~= nil then
        RemoveBlip(job_blip)
        job_blip = nil
    end
    job_blip = AddBlipForCoord(
        cur_task.loc.x, 
        cur_task.loc.y,
        cur_task.loc.z)
        SetBlipSprite(job_blip, 1)
        SetBlipColour(job_blip, 68)
        SetBlipRoute(job_blip, true)
        SetBlipRouteColour(job_blip, 68)
        SetBlipScale(job_blip, 0.8)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString('Delivery Location')
        EndTextCommandSetBlipName(job_blip)
end

local function sp_taskped()
    if taskped.spawned then return end
    local model = lib.requestmodel(joaat(cur_task.model))
    while not HasModelLoaded(joaat(cur_task.model)) do
        Wait(100)
    end
    local ped = CreatePed(4, 
        cur_task.model, 
        cur_task.loc.x, 
        cur_task.loc.y, 
        cur_task.loc.z-1, 
        cur_task.loc.w, 
        false, true)
    taskped.ped = ped
    TaskStartScenarioInPlace(ped, 'PROP_HUMAN_STAND_IMPATIENT', 0, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    local ped_options = {
        {
            name = 'miwt:c:dojob1',
            label = 'Deliver Pizza',
            icon = 'fa-solid fa-box',
            event = 'miwt:c:finish_job1',
            canInteract = function(_, distance)
                return distance < 2.0 and in_work
            end
        }
    }

    exports.ox_target:addLocalEntity(taskped.ped, ped_options)

    taskped.spawned = true
end

local function dl_taskped()
    if not taskped.spawned then return end
    exports.ox_target:removeLocalEntity(taskped.ped, { 'miwt:c:dojob1' })
    DeleteEntity(taskped.ped)
    taskped.spawned = false
    taskped.ped = nil
end

local function sp_taskobj()
    if taskobj.spawned then return end
    local model = lib.requestModel(joaat(cur_task.object))
    while not HasModelLoaded(cur_task.object) do
        Wait(100)
    end

    local object = CreateObject(
        cur_task.object, 
        cur_task.loc.x, 
        cur_task.loc.y, 
        cur_task.loc.z, 
        true, true, true)
    taskobj.obj = object

    SetModelAsNoLongerNeeded(model)
    PlaceObjectOnGroundProperly(object)
    FreezeEntityPosition(object, true)
    SetEntityCollision(object, true, true)

    local obj_options = {
        {
            name = 'miwt:c:dojob2',
            label = 'Do the job',
            icon = 'fa-solid fa-box',
            event = 'miwt:c:finish_job2',
            canInteract = function(_, distance)
                return distance < 2.0 and in_work
            end
        }
    }

    exports.ox_target:addLocalEntity(taskobj.obj, obj_options)
    taskobj.spawned = true
end

local function dl_taskobj()
    if not taskobj.spawned then return end
    exports.ox_target:removeLocalEntity(taskobj.obj, { 'miwt:c:dojob2' })
    DeleteEntity(taskobj.obj)
    taskobj.spawned = false
    taskobj.obj = nil
end

---------- Job Events ----------
RegisterNetEvent('miwt:c:start_job1', function()
    if in_work and c_in_service == true then return end
    local task1 = Config.job1[math.random(1, #Config.job1)]
    cur_task = task1
    in_work = true
    lib.notify({
        title = 'Delivery Started',
        description = 'It\'s pizza time',
        type = 'inform'
    })
    sp_jblip()
    sp_taskped()
    if health == 0 then
        TriggerEvent('miwt:c:failed_job')
    end
end)

RegisterNetEvent('miwt:c:finish_job1', function()
    exports.scully_emotemenu:PlayByCommand('carrypizza')
    if lib.progressBar({
        duration = 3000,
        label = 'Delivering Pizza',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
    }) then 
        lib.callback('payout')
        dl_taskped()
        RemoveBlip(job_blip)
        in_work = false
        cur_task = nil 
    else 
        print('Do stuff when cancelled') 
    end
    exports.scully_emotemenu:CancelAnimation()
    lib.notify({
        title = 'Delivery Completed',
        description = 'Good Pizza Time',
        type = 'success'
    })
    
    
end)

RegisterNetEvent('miwt:c:start_job2', function()
    if in_work and c_in_service == true then return end
    local task2 = Config.job2[math.random(1, #Config.job2)]
    cur_task = task2
    in_work = true
    lib.notify({
        title = 'Task active',
        description = 'Do the job',
        type = 'inform'
    })
    sp_jblip()
    sp_taskobj()
end)

RegisterNetEvent('miwt:c:finish_job2', function()
    exports.scully_emotemenu:PlayByCommand('mechanic4')
    local success = lib.skillCheck({'easy', 'easy', 'easy'}, {'w', 'a', 's', 'd'})
    if success == true then
        lib.notify({
            title = 'Task Completed',
            description = 'Good job',
            type = 'success'
        })
        RemoveBlip(job_blip)
        exports.scully_emotemenu:CancelAnimation()
        lib.callback('payout')
        dl_taskobj()
        in_work = false
        cur_task = nil
    else
        RemoveBlip(job_blip)
        lib.notify({
            title = 'Task Failed',
            description = 'Not good job',
            type = 'error'
        })
        exports.scully_emotemenu:CancelAnimation()
        dl_taskobj()
        in_work = false
        cur_task = nil
    end
end)

RegisterNetEvent('miwt:c:failed_job', function()
    RemoveBlip(job_blip)
    lib.notify({
        title = 'Task Failed',
        description = 'Not good job',
        type = 'error'
    })
    dl_taskobj()
    in_work = false
    cur_task = nil
end)
