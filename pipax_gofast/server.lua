ESX = exports["es_extended"]:getSharedObject()

local playerGoFastCount = {}

RegisterServerEvent('gofast:startMission')
AddEventHandler('gofast:startMission', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    if not playerGoFastCount[xPlayer.identifier] then
        playerGoFastCount[xPlayer.identifier] = 0
    end
    
    if playerGoFastCount[xPlayer.identifier] < Config.GoFastLimit then
        playerGoFastCount[xPlayer.identifier] = playerGoFastCount[xPlayer.identifier] + 1
        TriggerClientEvent('gofast:startMissionClient', _source)
    else
        TriggerClientEvent('esx:showNotification', _source, "Vous avez atteint la limite de go fast pour aujourd'hui.")
    end
end)

RegisterServerEvent('gofast:completeMission')
AddEventHandler('gofast:completeMission', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    xPlayer.addMoney(Config.RewardAmount)
    TriggerClientEvent('esx:showNotification', _source, "Vous avez reçu " .. Config.RewardAmount .. "$ pour le go fast.")
end)

-- Réinitialiser les compteurs toutes les 24 heures
function ResetGoFastCounts()
    playerGoFastCount = {}
    SetTimeout(24 * 60 * 60 * 1000, ResetGoFastCounts)
end

SetTimeout(24 * 60 * 60 * 1000, ResetGoFastCounts)
