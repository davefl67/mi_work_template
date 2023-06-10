-- local veriables
local s_in_service = false
local vehicle = nil

local jobstash = {
    id = Config.jobstash_id,
    label = Config.jobstash_label,
    slots = Config.jobstash_slots,
    weight = Config.jobstash_weight,
    owner = 'char1:license'
}

-- initialize stash
AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
        exports.ox_inventory:RegisterStash(
            jobstash.id, 
            jobstash.label, 
            jobstash.slots, 
            jobstash.weight, 
            jobstash.owner, 
            jobstash.jobs)
    end
end)

-- simple player service checker (server side)
lib.callback.register('checkin', function(source)
    if s_in_service == false then
        s_in_service = true
    else
        s_in_service = false
    end
end)

-- spawn vehicle
RegisterServerEvent('sp_vehicle', function(vehicle)
    local player = Ox.GetPlayer(source)
    print(json.encode(player, { indent = true }))

    vehicle = Ox.CreateVehicle({
        model = vehicle,
        group = Config.jobname,
        owner = player.charid,
    }, Config.vehicle.loc, Config.vehicle.head)
    print(json.encode(vehicle, { indent = true }))
end)

-- despawn & de-own vehicle
RegisterServerEvent('dl_vehicle', function(source)
    --local player = GetPlayerPed(source)
    local entity = vehicle

    if entity == 0 then return end

    local vehicle = Ox.GetVehicle(entity)

    if vehicle then
        -- delete the entity and remove it from the database, if it is persistant
        -- player vehicles go bye-bye forever
        vehicle.delete()
    else
        -- it's a random vehicle, i.e. traffic or a vehicle that has been spawned without using ox_core
        DeleteEntity(entity)
    end

    -- tell the client the vehicle was deleted
    return true
end)