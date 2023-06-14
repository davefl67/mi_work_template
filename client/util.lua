Util = {}

Util.spawn_ped = function(model, x, y, z, w, anim)
        local ped = CreatePed(1, model, x, y, z-1, w, false, false)
        TaskStartScenarioInPlace(ped, anim, 0, true)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
end

Util.teleport = function(ped, x, y, z, w)
    DoScreenFadeOut(100)
    Wait(100)
    SetEntityCoords(ped, x, y, z, false, false, false, false)
    SetEntityHeading(ped, w)
    DoScreenFadeIn(750)
end

Util.blip = function(blip, x, y, z, sprite, color, scale, name)
    blip = AddBlipForCoord(x, y, z)
    SetBlipSprite(blip, sprite)
    SetBlipDisplay(blip, 4)
    SetBlipColour(blip, color)
    SetBlipScale(blip, scale)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(name)
    EndTextCommandSetBlipName(blip)
end

Util.Outfitter = function(ped)
    exports['fivem-appearance']:setPedProp(ped, { -- arms
        prop_id = 3, drawable = Config.uni.u1.arms.obj, texture = Config.uni.u1.arms.txt })
    exports['fivem-appearance']:setPedProp(ped, { -- torso
        prop_id = 11, drawable = Config.uni.u1.torso.obj, texture = Config.uni.u1.torso.txt })
    exports['fivem-appearance']:setPedProp(ped, { -- undershirt
        prop_id = 8, drawable = Config.uni.u1.undershirt.obj, texture = Config.uni.u1.undershirt.txt })
    exports['fivem-appearance']:setPedProp(ped, { -- pants
        prop_id = 4, drawable = Config.uni.u1.pants.obj, texture = Config.uni.u1.pants.txt })
    exports['fivem-appearance']:setPedProp(ped, { -- shoes
        prop_id = 6, drawable = Config.uni.u1.shoes.obj, texture = Config.uni.u1.shoes.txt })
    exports['fivem-appearance']:setPedProp(ped, { -- bag
        prop_id = 5, drawable = Config.uni.u1.bag.obj, texture = Config.uni.u1.bag.txt })
    exports['fivem-appearance']:setPedProp(ped, { -- neck
        prop_id = 7, drawable = Config.uni.u1.accs.obj, texture = Config.uni.u1.accs.txt })
    exports['fivem-appearance']:setPedProp(ped, { -- kevlar
        prop_id = 9, drawable = Config.uni.u1.kevlar.obj, texture = Config.uni.u1.kevlar.txt })
    exports['fivem-appearance']:setPedProp(ped, { -- badge
        prop_id = 10, drawable = Config.uni.u1.badge.obj, texture = Config.uni.u1.badge.txt })
    exports['fivem-appearance']:setPedProp(ped, { -- hat
        prop_id = 0, drawable = Config.uni.u1.hat.obj, texture = Config.uni.u1.hat.txt })
end