Util = {}

Util.g6sped_utils = function(ped, anim)
        TaskStartScenarioInPlace(ped, anim, 0, true)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
end

Util.g6sremove_ped = function(ped)
    DeleteEntity(ped)
end

Util.g6sobj_utils = function(obj, model, head)
    SetEntityHeading(obj, head)
    SetModelAsNoLongerNeeded(model)
    PlaceObjectOnGroundProperly(obj)
    FreezeEntityPosition(obj, true)
    SetEntityCollision(obj, true, true)
end

Util.g6sremove_obj = function(obj)
    DeleteEntity(obj)
end

Util.g6steleport = function(ped, x, y, z, w)
    DoScreenFadeOut(100)
    Wait(100)
    SetEntityCoords(ped, x, y, z, false, false, false, false)
    SetEntityHeading(ped, w)
    DoScreenFadeIn(750)
end

Util.g6sblip = function(blip, x, y, z, sprite, color, scale, name)
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

Util.g6sroute = function(blip, sprite, color, route, routecolor, scale, name)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, color)
    SetBlipRoute(blip, true)
    SetBlipRouteColour(blip, routecolor)
    SetBlipScale(blip, scale)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(name)
    EndTextCommandSetBlipName(blip)
end

Util.g6sremove_blip = function(blip)
    if DoesBlipExist(blip) then
        SetBlipAsMissionCreatorBlip(blip, false)
        RemoveBlip(blip)
    end
end