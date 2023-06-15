local resourceName = GetCurrentResourceName()
local employeenames = setmetatable({}, {
	__index = function(self, index)
		local data = Ox.GetVehicleData(index)

		if data then
			self[index] = data.name
			return data.name
		end
	end
})
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- work ped
local function ped_boss()
    local model = Config.peds.mngr.model
    local coords = Config.peds.mngr.loc
    local anim = Config.peds.mngr.anim
    

    if lib.requestModel(model, 1000) then
        Util.spawn_ped(model, coords.x, coords.y, coords.z, coords.w, anim) 
    end
end

-- point location
local mngrped_coords = Config.peds.mngr.loc
local mngrped = lib.points.new({
    coords = mngrped_coords,
    distance = 3,
    currentDistance = 2
})

-- text ui load
function mngrped:nearby()
    local dist = Config.peds.mngr.dist
    if self.currentDistance < dist then
        lib.showTextUI('[E] - Manager Menu')
    end
    if self.currentDistance < dist and IsControlJustReleased(0, 38) then
        lib.hideTextUI()
        lib.showContext('mngr_menu')
    end
    if self.currentDistance > dist then
        lib.hideTextUI()
    end
end

-- huge credit to hyperextended for the group manager system
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- manager functions
--[[
local function employeelist()
  local options = {}

  for i = 1, 
end
]]

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- context menu
lib.registerContext({
    id = 'mngr_menu',
    title = 'Manager Menu',
    options = {
      {
        title = 'Employee Options',
        description = 'Manage current employees',
        icon = 'users',
        onSelect = function()
          local player = cache.ped
          print(player)
        end,
      },
      {
        title = 'Hiring options',
        description = 'Manage Employees',
        icon = 'user',
        onSelect = function()
          print('Hiring menu')
        end,
      }
    }
  })

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- main thread
Citizen.CreateThread(function()
    if resourceName == GetCurrentResourceName() then
        ped_boss()
        Citizen.Wait(1000)
    end
end)