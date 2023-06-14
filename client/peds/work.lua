local resourceName = GetCurrentResourceName()

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- work ped
local function ped_work()
    local model = Config.peds.work.model
    local coords = Config.peds.work.loc
    local anim = Config.peds.work.anim
    

    if lib.requestModel(model, 1000) then
        Util.spawn_ped(model, coords.x, coords.y, coords.z, coords.w, anim) 
    end
end

-- point location
local workped_coords = Config.peds.work.loc
local workped = lib.points.new({
    coords = workped_coords,
    distance = 3,
    currentDistance = 2
})

-- text ui load
function workped:nearby()
    local dist = Config.peds.work.dist
    if self.currentDistance < dist then
        lib.showTextUI('[E] - Work Menu')
    end
    if self.currentDistance < dist and IsControlJustReleased(0, 38) then
        lib.hideTextUI()
        lib.showContext('work_menu')
    end
    if self.currentDistance > dist then
        lib.hideTextUI()
    end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- context menu
lib.registerContext({
    id = 'work_menu',
    title = 'Work Menu',
    options = {
      {
        title = 'Start task 1',
        description = 'Example button description',
        icon = 'user',
        onSelect = function()
          print("Pressed the button!")
        end,
        metadata = {
          {label = 'Value 1', value = 'Some value'},
          {label = 'Value 2', value = 300}
        },
      },
      {
        title = 'start task 2',
        description = 'Example button description',
        icon = 'city',
        onSelect = function()
          print("Pressed the button!")
        end,
        metadata = {
          {label = 'Value 1', value = 'Some value'},
          {label = 'Value 2', value = 300}
        },
      },
    }
  })

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- main thread
Citizen.CreateThread(function()
    if resourceName == GetCurrentResourceName() then
        ped_work()
        Citizen.Wait(1000)
    end
end)