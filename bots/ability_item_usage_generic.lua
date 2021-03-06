local ability_levelup = require(
  GetScriptDirectory() .."/utility/ability_levelup")

local ability_usage = require(
  GetScriptDirectory() .."/utility/ability_usage")

local inventory = require(
  GetScriptDirectory() .."/utility/inventory")

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
  inventory.PickUpItem()
end

function CourierUsageThink()
  courier.CourierUsageThink()
end
