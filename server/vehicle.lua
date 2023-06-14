lib.callback.register('veh:spawn', function(source)
    local player = Ox.GetPlayer(source)
    local coords = Job.vehicle.loc
    vehicle = Ox.CreateVehicle({
        model = Job.vehicle.model,
        owner = player.charid,
        group = Config.job.name
    }, Job.vehicle.loc)
end)

lib.callback.register('veh:delete', function(source)
    local player = GetPlayerPed(source)
    local entity = GetVehiclePedIsIn(player, false)
    if entity == 0 then return end
    local vehicle = Ox.GetVehicle(entity)
    if vehicle then
        vehicle.delete()
    else
        DeleteEntity(entity)
    end
    return true
end)
