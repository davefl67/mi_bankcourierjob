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
    local entity = GetVehiclePedIsIn(player, true)
    local group = Config.job.name

    if entity == 0 and vehicle.group ~= group then
    elseif vehicle then
        vehicle.delete()
    end
    return true
end)
