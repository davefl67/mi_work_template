local resourceName = GetCurrentResourceName()

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- work ped
local function ped_vehicle()
    local model = Config.peds.spawn.model
    local coords = Config.peds.spawn.loc
    local anim = Config.peds.spawn.anim
    

    if lib.requestModel(model, 1000) then
        Util.spawn_ped(model, coords.x, coords.y, coords.z, coords.w, anim) 
    end
end

-- point location
local workped_coords = Job.vehicle.loc
local workped = lib.points.new({
    coords = workped_coords,
    distance = 3,
    currentDistance = 2
})

-- text ui load
function workped:nearby()
    local dist = Config.peds.spawn.dist
    if self.currentDistance < dist then
        lib.showTextUI('[E] - Vehicle Menu')
    end
    if self.currentDistance < dist and IsControlJustReleased(0, 38) then
        lib.hideTextUI()
        lib.showContext('vehicle_menu')
    end
    if self.currentDistance > dist then
        lib.hideTextUI()
    end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- context menu
lib.registerContext({
    id = 'vehicle_menu',
    title = 'Vehicle Menu',
    options = {
      {
        title = 'Spawn Vehicle',
        description = 'spawn work vehicle',
        icon = 'car',
        onSelect = function()
            local vehicle = Job.vehicle.model
            vehicle = lib.callback.await('veh:spawn', false, source)
            print(vehicle)
        end,
      },
      {
        title = 'Return Vehicle',
        description = 'return work vehicle',
        icon = 'car',
        onSelect = function()
            lib.callback.await('veh:delete', false)
        end,
      },
    }
  })

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- main thread
Citizen.CreateThread(function()
    if resourceName == GetCurrentResourceName() then
        ped_vehicle()
        Citizen.Wait(1000)
    end
end)