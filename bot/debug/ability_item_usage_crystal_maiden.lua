-- TODO: Move this code to the ability_item_usage_generic.lua script.
-- Remove this file.

local ability_levelup = require(
  GetScriptDirectory() .."/utility/ability_levelup")

local ability_usage = require(
  GetScriptDirectory() .."/utility/ability_usage")

ability_levelup.InitAbilities()

function AbilityLevelUpThink()
  ability_levelup.AbilityLevelUpThink()
end

function AbilityUsageThink()
  ability_usage.AbilityUsageThink(ability_levelup.ABILITIES)
end
