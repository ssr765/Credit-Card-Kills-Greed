local CCKGmod = RegisterMod("CreditCardKillsGreed", 1)
local json = require("json") -- For MCM

CCKGconfig = {
    ["killsMiniBoss"] = true,
    ["killsKeeper"] = true,
    ["killsGreedGaper"] = true,
    ["killsHanger"] = true,
    ["killsCoins"] = true,
    ["killsShopkeepers"] = false,
    ["killsUltraGreed"] = false,
    ["killsPlayer"] = false,
}

-- External Item Descriptions
-- Modifies the description of Credit Card.
if EID then
    local function myModifierCondition(descObj)
        -- Credit Card
        if descObj.ObjType == EntityType.ENTITY_PICKUP and descObj.ObjVariant == PickupVariant.PICKUP_TAROTCARD and descObj.ObjSubType == Card.CARD_CREDIT then return true end
    end

    local function myModifierCallback(descObj)
        if CCKGconfig["killsMiniBoss"] then
            EID:appendToDescription(descObj, "#{{MiniBoss}} Kills Greed and Super Greed minibosses")
        end
        
        if CCKGconfig["killsKeeper"] or CCKGconfig["killsGreedGaper"] or CCKGconfig["killsHanger"] then
            EID:appendToDescription(descObj, "#{{DeathMark}} Kills some greed-related enemies")
        end

        if CCKGconfig["killsUltraGreed"] then
            EID:appendToDescription(descObj, "#{{GreedMode}} Kills one phase of Ultra Greed")
            
            if CCKGconfig["killsCoins"] then
                EID:appendToDescription(descObj, " and his {{Coin}} Ultra Coins")
            end

        end
        
        if CCKGconfig["killsPlayer"] then
            EID:appendToDescription(descObj, "#{{Warning}} Kills you when playing as Keeper or Tainted Keeper")
        end

        return descObj
    end
    
    EID:addDescriptionModifier("CCKGdescriptionModifier", myModifierCondition, myModifierCallback)
end

-- Mod Config Menu
if ModConfigMenu then
    local CCKG = "Credit Card Kills Greed"

    ModConfigMenu.UpdateCategory(CCKG, {
        Info = {"Personalize what the Credit Card kills.",}
    })

    -- Section.
    ModConfigMenu.AddSpace(CCKG, "Settings")

    -- Kills Greed and Super Greed minibosses option.
    ModConfigMenu.AddSetting(CCKG, "Settings", 
        {
            Type = ModConfigMenu.OptionType.BOOLEAN,
            CurrentSetting = function()
                return CCKGconfig["killsMiniBoss"]
            end,
            Display = function()
                local onOff = "False"
                if CCKGconfig["killsMiniBoss"] then
                    onOff = "True"
                end
                return 'Kills minibosses: ' .. onOff
            end,
            OnChange = function(currentBool)
                CCKGconfig["killsMiniBoss"] = currentBool
            end,
            Info = {'Kills Greed and Super Greed minibosses.'}
    })

    -- Kills Keeper option.
    ModConfigMenu.AddSetting(CCKG, "Settings", 
        {
            Type = ModConfigMenu.OptionType.BOOLEAN,
            CurrentSetting = function()
                return CCKGconfig["killsKeeper"]
            end,
            Display = function()
                local onOff = "False"
                if CCKGconfig["killsKeeper"] then
                    onOff = "True"
                end
                return 'Kills "Keeper" enemy: ' .. onOff
            end,
            OnChange = function(currentBool)
                CCKGconfig["killsKeeper"] = currentBool
            end,
            Info = {'Kills "Keeper" enemies.'}
    })

    -- Kills Greed Gapers option.
    ModConfigMenu.AddSetting(CCKG, "Settings", 
        {
            Type = ModConfigMenu.OptionType.BOOLEAN,
            CurrentSetting = function()
                return CCKGconfig["killsGreedGaper"]
            end,
            Display = function()
                local onOff = "False"
                if CCKGconfig["killsGreedGaper"] then
                    onOff = "True"
                end
                return 'Kills "Greed Gaper" enemy: ' .. onOff
            end,
            OnChange = function(currentBool)
                CCKGconfig["killsGreedGaper"] = currentBool
            end,
            Info = {'Kills "Greed Gaper" enemies.'}
    })

    -- Kills Hangers option.
    ModConfigMenu.AddSetting(CCKG, "Settings", 
        {
            Type = ModConfigMenu.OptionType.BOOLEAN,
            CurrentSetting = function()
                return CCKGconfig["killsHanger"]
            end,
            Display = function()
                local onOff = "False"
                if CCKGconfig["killsHanger"] then
                    onOff = "True"
                end
                return 'Kills "Hanger" enemy: ' .. onOff
            end,
            OnChange = function(currentBool)
                CCKGconfig["killsHanger"] = currentBool
            end,
            Info = {'Kills "Hanger" enemies.'}
    })

    -- Kills Ultra Greed Coins option.
    ModConfigMenu.AddSetting(CCKG, "Settings", 
        {
            Type = ModConfigMenu.OptionType.BOOLEAN,
            CurrentSetting = function()
                return CCKGconfig["killsCoins"]
            end,
            Display = function()
                local onOff = "False"
                if CCKGconfig["killsCoins"] then
                    onOff = "True"
                end
                return 'Destroys Ultra Coins: ' .. onOff
            end,
            OnChange = function(currentBool)
                CCKGconfig["killsCoins"] = currentBool
            end,
            Info = {"Destroys the Ultra Coins summoned by Ultra Greed in Greed Mode."}
    })

    -- Kills Shopkeepers option.
    ModConfigMenu.AddSetting(CCKG, "Settings", 
        {
            Type = ModConfigMenu.OptionType.BOOLEAN,
            CurrentSetting = function()
                return CCKGconfig["killsShopkeepers"]
            end,
            Display = function()
                local onOff = "False"
                if CCKGconfig["killsShopkeepers"] then
                    onOff = "True"
                end
                return 'Destroys shopkeepers: ' .. onOff
            end,
            OnChange = function(currentBool)
                CCKGconfig["killsShopkeepers"] = currentBool
            end,
            Info = {"Destroys the shopkeepers."}
    })

    -- Kills Ultra Greed option.
    ModConfigMenu.AddSetting(CCKG, "Settings", 
        {
            Type = ModConfigMenu.OptionType.BOOLEAN,
            CurrentSetting = function()
                return CCKGconfig["killsUltraGreed"]
            end,
            Display = function()
                local onOff = "False"
                if CCKGconfig["killsUltraGreed"] then
                    onOff = "True"
                end
                return 'Kills Ultra Greed: ' .. onOff
            end,
            OnChange = function(currentBool)
                CCKGconfig["killsUltraGreed"] = currentBool
            end,
            Info = {"Kills one phase of Ultra Greed in Greed Mode."}
    })

    -- Kills Keeper (player) option.
    ModConfigMenu.AddSetting(CCKG, "Settings", 
        {
            Type = ModConfigMenu.OptionType.BOOLEAN,
            CurrentSetting = function()
                return CCKGconfig["killsPlayer"]
            end,
            Display = function()
                local onOff = "False"
                if CCKGconfig["killsPlayer"] then
                    onOff = "True"
                end
                return 'Kills player: ' .. onOff
            end,
            OnChange = function(currentBool)
                CCKGconfig["killsPlayer"] = currentBool
            end,
            Info = {"Kills the player when playing as Keeper or Tainted Keeper."}
    })
end

-- Killing entities with the card.
function CCKGmod:useCard(cardId)
    if cardId == Card.CARD_CREDIT then
        local entities = Isaac.GetRoomEntities()
        local player = Isaac.GetPlayer(0)
        local playerId = player:GetPlayerType()

        for _, entity in pairs(entities) do
            -- Kills Keeper and Super Keeper (mini-bosses)
            if entity.Type == EntityType.ENTITY_GREED and CCKGconfig["killsMiniBoss"] then
                entity:Kill()

            -- Kills Keeper (enemy)
            elseif entity.Type == EntityType.ENTITY_KEEPER and CCKGconfig["killsKeeper"] then
                entity:Kill()

            -- Kills Greed Gapper
            elseif entity.Type == EntityType.ENTITY_GREED_GAPER and CCKGconfig["killsGreedGaper"] then
                entity:Kill()

            -- Kills Hanger
            elseif entity.Type == EntityType.ENTITY_HANGER and CCKGconfig["killsHanger"] then
                entity:Kill()

            -- Destroys Ultra Greed Coins
            elseif entity.Type == EntityType.ENTITY_ULTRA_COIN and CCKGconfig["killsCoins"] then
                entity:Kill()

            -- Destroys shopkeepers
            elseif entity.Type == EntityType.ENTITY_SHOPKEEPER and CCKGconfig["killsShopkeepers"] then
                entity:Kill()

            -- Kills Ultra Greed (MCM option)
            elseif entity.Type == EntityType.ENTITY_ULTRA_GREED and CCKGconfig["killsUltraGreed"] then
                entity:Kill()

            end

        end

        -- Kills the player playing as Keeper or Tainted Keeper (MCM option)
        if (playerId == PlayerType.PLAYER_KEEPER or playerId == PlayerType.PLAYER_KEEPER_B) and CCKGconfig["killsPlayer"] then
            player:Kill()

        end

    end
end

CCKGmod:AddCallback(ModCallbacks.MC_USE_CARD, CCKGmod.useCard)

-- Save Mod Config Menu config
local SaveState = {}

function CCKGmod:SaveGame()
    SaveState.Settings = {}
    
    for i, v in pairs(CCKGconfig) do
        SaveState.Settings[i] = CCKGconfig[i]
    end

    CCKGmod:SaveData(json.encode(SaveState))
end

CCKGmod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, CCKGmod.SaveGame)

function CCKGmod:OnGameStart(_)
    if CCKGmod:HasData() then    
        SaveState = json.decode(CCKGmod:LoadData())    
        
        for i, v in pairs(SaveState.Settings) do
            CCKGconfig[i] = SaveState.Settings[i]
        end
    end
end

CCKGmod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, CCKGmod.OnGameStart)