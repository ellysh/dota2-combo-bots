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
  ability_usage.AbilityUsageThink(ability_levelup.ABILITIES)
end

function CourierUsageThink()
  courier.CourierUsageThink()
end
