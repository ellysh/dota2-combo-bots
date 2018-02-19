local ability_levelup = require(
  GetScriptDirectory() .."/utility/ability_levelup")

local ability_usage = require(
  GetScriptDirectory() .."/utility/ability_usage")

local courier = require(
  GetScriptDirectory() .."/utility/courier")

ability_levelup.InitAbilities()

function AbilityLevelUpThink()
  ability_levelup.AbilityLevelUpThink()
end

function AbilityUsageThink()
  ability_usage.AbilityUsageThink()
end

function ItemUsageThink()
  -- This is a stub function to allow bots perform SKILL_USAGE algorithms
end

function CourierUsageThink()
  courier.CourierUsageThink()
end
