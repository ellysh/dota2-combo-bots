-- TODO: Move this code to the ability_item_usage_generic.lua script.
-- Remove this file.

local ability_levelup = require(
    GetScriptDirectory() .."/utility/ability_levelup")

ability_levelup.InitAbilities()

function AbilityLevelUpThink()
  ability_levelup.AbilityLevelUpThink()
end
