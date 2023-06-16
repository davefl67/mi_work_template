local resourceName = GetCurrentResourceName()
local workped = {
  spawned = false,
  ped = nil
}
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- work ped
local function ped_work()
    local model = Config.peds.work.model
    local coords = Config.peds.work.loc
    local anim = Config.peds.work.anim
    

    if lib.requestModel(model, 1000) then
        local ped = CreatePed(1, model, coords.x, coords.y, coords.z-1, coords.w, false, false)
        Util.ped_utils(ped, anim)
        workped.ped = ped
        local options = {
          {
            name = 'ox:option2',
            icon = 'fa-solid fa-briefcase',
            groups = Config.job.name,
            label = 'Request work bag',
            canInteract = function(_, distance)
                return distance < 2.0
            end,
            onSelect = function()
                lib.callback('wp:givebag', false, source)
            end
          },
          {
            name = 'ox:option2',
            icon = 'fa-solid fa-person-running',
            groups = Config.job.name,
            label = 'Request task type 1',
            canInteract = function(_, distance)
                return distance < 2.0
            end,
            onSelect = function()
                lib.callback.await('veh:delete', false)
            end
          }
      }
      
      exports.ox_target:addLocalEntity(workped.ped, options)
      workped.spaned = true
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
--[[
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
]]

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- context menu
lib.registerContext({
    id = 'work_menu',
    title = 'Work Menu',
    options = {
      {
        title = 'Request workbag',
        description = 'Contains all the tools you need',
        icon = 'suitcase',
        onSelect = function()
          print("Pressed the button!")
        end,
        metadata = {
          {label = 'Value 2', value = 1},
          {label = 'Value 2', value = 1},
          {label = 'Value 2', value = 1},
          {label = 'Value 2', value = 1},
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