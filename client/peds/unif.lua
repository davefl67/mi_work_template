local resourceName = GetCurrentResourceName()

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- work ped
local function ped_unif()
    local model = Config.peds.unif.model
    local coords = Config.peds.unif.loc
    local anim = Config.peds.unif.anim
    

    if lib.requestModel(model, 1000) then
        Util.spawn_ped(model, coords.x, coords.y, coords.z, coords.w, anim) 
    end
end

-- point location
local unifped_coords = Config.peds.unif.loc
local unifped = lib.points.new({
    coords = unifped_coords,
    distance = 4,
    currentDistance = 2
})

-- text ui load
function unifped:nearby()
    local dist = Config.peds.unif.dist
    if self.currentDistance < dist then
        lib.showTextUI('[E] - Uniform Menu')
    end
    if self.currentDistance < dist and IsControlJustReleased(0, 38) then
        lib.hideTextUI()
        lib.showContext('unif_menu')
    end
    if self.currentDistance > dist then
        lib.hideTextUI()
    end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- clothing functions

local function outfit_male(outfit)
  exports['fivem-appearance']:setPedComponents(cache.ped, {outfit.torso, outfit.undershirt, outfit.pants, outfit.shoes, outfit.bag, outfit.accesories, outfit.kevlar, outfit.badge, outfit.arms})
  exports['fivem-appearance']:setPedProps(cache.ped, {outfit.hat})
end

local function outfit_female(outfit)
  exports['fivem-appearance']:setPedComponents(cache.ped, {outfit.torso, outfit.undershirt, outfit.pants, outfit.shoes, outfit.bag, outfit.accesories, outfit.kevlar, outfit.badge, outfit.arms})
  exports['fivem-appearance']:setPedProps(cache.ped, {outfit.hat})
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- context menu
lib.registerContext({
    id = 'unif_menu',
    title = 'Uniform Menu',
    options = {
      {
        title = 'Uniform - male',
        description = 'The standard work uniform',
        icon = 'person',
        onSelect = function()
            local outfit = Config.uniforms.male
            outfit_male(outfit)
        end,
        metadata = {
          {label = 'head', value = 'none'},
          {label = 'shirt', value = 'tucket white button up'},
          {label = 'jacket', value = 'green work jacket'},
          {label = 'neck', value = 'black tie'},
          {label = 'waist', value = 'none'},
          {label = 'pants', value = 'khaki slacks'},
          {label = 'shoes', value = 'brown dress shoes'},
          {label = 'accs', value = 'security card'},
        },
      },
      {
        title = 'Uniform - female',
        description = 'The standard work uniform',
        icon = 'person-dress',
        onSelect = function()
          local outfit = Config.uniforms.male
          outfit_female(outfit)
        end,
        metadata = {
          {label = 'body', value = 'item'},
          {label = 'body', value = 'item'},
          {label = 'body', value = 'item'},
          {label = 'body', value = 'item'},
        },
      },
      {
        title = 'Personal Wardrobe',
        description = 'Change back to your casual fit',
        icon = 'shirt',
        onSelect = function()
          TriggerEvent('ox_appearance:wardrobe')
        end,
        metadata = {
          {label = 'body', value = 'item'},
          {label = 'body', value = 'item'},
          {label = 'body', value = 'item'},
          {label = 'body', value = 'item'},
        },
      },
    }
  })

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- main thread
Citizen.CreateThread(function()
    if resourceName == GetCurrentResourceName() then
        ped_unif()
        Citizen.Wait(1000)
    end
end)