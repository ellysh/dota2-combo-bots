local ability_levelup = require(
  GetScriptDirectory() .."/utility/ability_levelup")

local courier = require(
  GetScriptDirectory() .."/utility/courier")

ability_levelup.InitAbilities()

function AbilityLevelUpThink()
  ability_levelup.AbilityLevelUpThink()
end

function CourierUsageThink()
  courier.CourierUsageThink()
end
