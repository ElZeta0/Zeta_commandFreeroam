RegisterCommand('c', function() ----- comando per curarti
    local giocatore = PlayerPedId()
    SetEntityHealth(giocatore, 200)
end,false)

RegisterCommand('g', function() ----- comando per darti il giubotto
    local giocatore = PlayerPedId()
    SetPedArmour(giocatore, 100)
end,false)

RegisterCommand('r', function() ----- comando per rianimarti
    if Config.comandoRianima == true then
        local giocatore = PlayerPedId()
        local cordinate = GetEntityCoords(giocatore, true)
        local giocatore_morto = GetEntityHealth(giocatore)

        SetEntityHealth(giocatore, 200)
        SetEntityVisible(PlayerPedId(), true, 0)
        NetworkResurrectLocalPlayer(cordinate, true, true, false)
        SetPlayerInvincible(giocatore, false)
        ClearPedBloodDamage(giocatore)
        -- print('giocatore rianimato')
    end
end,false)

CreateThread(function() --- premi [E] per ressarti
    while true do
        local aspetta = 500

        local giocatore = PlayerPedId()
        local cordinate = GetEntityCoords(giocatore, true)
        local giocatore_morto = GetEntityHealth(giocatore)
        -- print(giocatore_morto) -- debug
            if giocatore_morto <= 0 then
                aspetta = 0
                SetEntityVisible(PlayerPedId(), false, 0)
                SetPlayerInvincible(giocatore, true)

                SetTextFont(4)
                SetTextScale(0.5, 0.5)
                SetTextColour(200, 50, 50, 255)
                SetTextDropshadow(0.1, 3, 27, 27, 255)
                BeginTextCommandDisplayText('STRING')
                AddTextComponentSubstringPlayerName('Premi [E] per respwnare')
                EndTextCommandDisplayText(0.43, 0.77)

                -- print('controllo sei il giocatore e morto') -- debug
            if Config.comandoRianima == false then 
                if IsControlJustReleased(0, 38) then
                    aspetta = 0
                    -- print('controllo sei il giocatore ha cliccato E') -- debug
                    SetEntityHealth(giocatore, 200)
                    SetEntityVisible(PlayerPedId(), true, 0)
                    NetworkResurrectLocalPlayer(cordinate, true, true, false)
                    SetPlayerInvincible(giocatore, false)
                    ClearPedBloodDamage(giocatore)
                end
            end
        end
        Wait(aspetta)
    end
end)
