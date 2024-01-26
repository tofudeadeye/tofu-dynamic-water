AddEventHandler('onClientResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    print('Loading custom water.xml')
    local success = LoadWaterFromPath(GetCurrentResourceName(), 'flood.xml')
    if success ~= 1 then
        print('Failed to load water.xml, does the file exist within the resource?')
    end
    local waterQuadCount = GetWaterQuadCount()
    print("water quad count: " .. waterQuadCount)
    local calmingQuadCount = GetCalmingQuadCount()
    print("calming quad count: " .. calmingQuadCount)
    local waveQuadCount = GetWaveQuadCount()
    print("wave quad count: " .. waveQuadCount)
end)

RegisterCommand('loadwater', function(source, args)
    print('Loading custom water.xml')
    local success = LoadWaterFromPath(GetCurrentResourceName(), 'flood.xml')
    if success ~= 1 then
        print('Failed to load water.xml, does the file exist within the resource?')
    end
    local waterQuadCount = GetWaterQuadCount()
    print("water quad count: " .. waterQuadCount)
    local calmingQuadCount = GetCalmingQuadCount()
    print("calming quad count: " .. calmingQuadCount)
    local waveQuadCount = GetWaveQuadCount()
    print("wave quad count: " .. waveQuadCount)
end)

RegisterCommand('resetwater', function(source, args)
    print('Resetting water to game defaults')
    ResetWater()
end)

-- Change this value to set the maximum flood height
local maxFloodHeight = 400
-- Change this value to increase/decrease the rate at which the water height changes
local increaseRate = 0.1
-- Change this value to increase/decrease the time it takes to reach maxFloodHeight.
local threadWait = 100

RegisterCommand('flood', function(source, args)
    Citizen.CreateThread(function()
        local pCoords, wCoords, allPeds = nil, nil, nil
        while true do
            ped = PlayerPedId()
            pCoords = GetEntityCoords(ped)
            wCoords = GetWaterQuadAtCoords_3d(pCoords.x, pCoords.y, pCoords.z)

            if wCoords ~= -1 then
                allPeds = GetGamePool('CPed')
                for i = 1, #allPeds do
                    SetPedConfigFlag(allPeds[i], 65, true)
                    SetPedDiesInWater(allPeds[i], true)
                end
            end
            Citizen.Wait(5000)
        end
    end)

    Citizen.CreateThread(function()
        -- Things you could do to further enhance:
        --  - Configure WaveQuads and increase amplitude, remember disable all CalmingQuads which take priority!
        --  - Task all peds to flee from players/coords
        --  - Change weather to thunder & increase rain / mist
        --  - Spawn sharks and make them hostile / attack players
        --  - Turn off artificial lighting
        --  - Turn off all ped & vehicle generators to stop spawning
        --  - Modify world gravity to make fleeing slightly harder
        --  - Set extreme wind conditions for those trying to flee by air

        local waterQuadCount = GetWaterQuadCount()
        local isFlooding = true

        while isFlooding do
            for i = 1, waterQuadCount, 1 do
                local success, waterQuadLevel = GetWaterQuadLevel(i)
                if success == 1 then
                    SetWaterQuadLevel(i, waterQuadLevel + increaseRate)
                end

                if waterQuadLevel >= maxFloodHeight then
                    isFlooding = false
                end
            end
            Citizen.Wait(threadWait)
        end
        print('done')
    end)
end)
