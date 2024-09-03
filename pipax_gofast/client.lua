ESX = exports["es_extended"]:getSharedObject()

local startPed, endPed, missionVehicle, missionBlip, countdown

-- Créer les PNJ
Citizen.CreateThread(function()
    RequestModel(GetHashKey(Config.StartPed.model))
    while not HasModelLoaded(GetHashKey(Config.StartPed.model)) do
        Citizen.Wait(1)
    end
    
    startPed = CreatePed(4, GetHashKey(Config.StartPed.model), Config.StartPed.coords, Config.StartPed.heading, false, true)
    SetEntityInvincible(startPed, true)
    FreezeEntityPosition(startPed, true)
    SetBlockingOfNonTemporaryEvents(startPed, true)
    
    RequestModel(GetHashKey(Config.EndPed.model))
    while not HasModelLoaded(GetHashKey(Config.EndPed.model)) do
        Citizen.Wait(1)
    end
    
    endPed = CreatePed(4, GetHashKey(Config.EndPed.model), Config.EndPed.coords, Config.EndPed.heading, false, true)
    SetEntityInvincible(endPed, true)
    FreezeEntityPosition(endPed, true)
    SetBlockingOfNonTemporaryEvents(endPed, true)
end)

-- Interaction avec le PNJ de départ
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerCoords = GetEntityCoords(PlayerPedId())
        local dist = #(playerCoords - Config.StartPed.coords)
        
        if dist < 2.0 then
            ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour commencer le go fast")
            if IsControlJustReleased(0, 38) then -- E
                TriggerServerEvent('gofast:startMission')
            end
        end
    end
end)

RegisterNetEvent('gofast:startMissionClient')
AddEventHandler('gofast:startMissionClient', function()
    -- Animation de remise du sac
    local playerPed = PlayerPedId()
    RequestAnimDict("mp_common")
    while not HasAnimDictLoaded("mp_common") do
        Citizen.Wait(1)
    end
    TaskPlayAnim(playerPed, "mp_common", "givetake1_a", 8.0, -8.0, -1, 0, 0, false, false, false)
    TaskPlayAnim(startPed, "mp_common", "givetake1_a", 8.0, -8.0, -1, 0, 0, false, false, false)
    
    Citizen.Wait(2000)
    
    -- Faire apparaître la voiture
    RequestModel(GetHashKey(Config.VehicleModel))
    while not HasModelLoaded(GetHashKey(Config.VehicleModel)) do
        Citizen.Wait(1)
    end
    
    missionVehicle = CreateVehicle(GetHashKey(Config.VehicleModel), Config.VehicleSpawnPoint, 0.0, true, false)
    SetVehicleOnGroundProperly(missionVehicle)
    
    -- Définir le point GPS
    missionBlip = AddBlipForCoord(Config.EndPed.coords)
    SetBlipRoute(missionBlip, true)
    
    -- Démarrer le compte à rebours
    countdown = Config.MissionTime
    Citizen.CreateThread(function()
        while countdown > 0 do
            Citizen.Wait(1000)
            countdown = countdown - 1
            if countdown == 0 then
                ESX.ShowNotification("Temps écoulé ! Mission échouée.")
                EndMission(false)
            end
        end
    end)
end)

-- Interaction avec le PNJ de fin
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if missionVehicle then
            local playerCoords = GetEntityCoords(PlayerPedId())
            local dist = #(playerCoords - Config.EndPed.coords)
            
            if dist < 2.0 and IsPedInVehicle(PlayerPedId(), missionVehicle, false) then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour terminer le go fast")
                if IsControlJustReleased(0, 38) then -- E
                    EndMission(true)
                end
            end
        end
    end
end)

function EndMission(success)
    if success then
        -- Animation de remise d'argent
        local playerPed = PlayerPedId()
        RequestAnimDict("mp_common")
        while not HasAnimDictLoaded("mp_common") do
            Citizen.Wait(1)
        end
        TaskPlayAnim(playerPed, "mp_common", "givetake1_a", 8.0, -8.0, -1, 0, 0, false, false, false)
        TaskPlayAnim(endPed, "mp_common", "givetake1_a", 8.0, -8.0, -1, 0, 0, false, false, false)
        
        TriggerServerEvent('gofast:completeMission')
    end
    
    -- Nettoyer
    if DoesBlipExist(missionBlip) then
        RemoveBlip(missionBlip)
    end
    if DoesEntityExist(missionVehicle) then
        DeleteVehicle(missionVehicle)
    end
    missionVehicle = nil
    countdown = 0
end

-- Afficher le compte à rebours
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if countdown and countdown > 0 then
            DrawText2D(0.5, 0.92, ("Temps restant: %02d:%02d"):format(math.floor(countdown/60), countdown%60), 0.4)
        end
    end
end)

function DrawText2D(x, y, text, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextScale(scale, scale)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end
