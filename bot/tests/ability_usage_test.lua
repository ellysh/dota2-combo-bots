package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local ability_usage = require("ability_usage")
local ability_usage_algorithms = require("ability_usage_algorithms")
local luaunit = require('luaunit')

function test_IsBotModeMatch_succeed()
  test_RefreshBot()

  luaunit.assertTrue(
    ability_usage.test_IsBotModeMatch(
      GetBot(),
      "any_mode"))

  luaunit.assertTrue(
    ability_usage.test_IsBotModeMatch(
      GetBot(),
      "team_fight"))

  luaunit.assertTrue(
    ability_usage.test_IsBotModeMatch(
      GetBot(),
      "team_fight"))

  BOT_MODE = BOT_MODE_ROAM

  luaunit.assertTrue(
    ability_usage.test_IsBotModeMatch(
      GetBot(),
      "BOT_MODE_ROAM"))

  BOT_MODE = BOT_MODE_TEAM_ROAM

  luaunit.assertTrue(
    ability_usage.test_IsBotModeMatch(
      GetBot(),
      "BOT_MODE_TEAM_ROAM"))

  BOT_MODE = BOT_MODE_PUSH_TOWER_MID

  luaunit.assertTrue(
    ability_usage.test_IsBotModeMatch(
      GetBot(),
      "BOT_MODE_PUSH_TOWER"))

  BOT_MODE = BOT_MODE_DEFEND_TOWER_MID

  luaunit.assertTrue(
    ability_usage.test_IsBotModeMatch(
      GetBot(),
      "BOT_MODE_DEFEND_TOWER"))

  BOT_MODE = BOT_MODE_ATTACK

  luaunit.assertTrue(
    ability_usage.test_IsBotModeMatch(
      GetBot(),
      "BOT_MODE_ATTACK"))
end

function test_IsBotModeMatch_fails()
  test_RefreshBot()

  BOT_MODE = BOT_MODE_ATTACK

  luaunit.assertFalse(
    ability_usage.test_IsBotModeMatch(
      GetBot(),
      BOT_MODE_ROAM))

  BOT_MODE = BOT_MODE_DEFEND_TOWER_MID

  luaunit.assertFalse(
    ability_usage.test_IsBotModeMatch(
      GetBot(),
      "BOT_MODE_PUSH_TOWER"))

  BOT_MODE = BOT_MODE_PUSH_TOWER_MID

  luaunit.assertFalse(
    ability_usage.test_IsBotModeMatch(
      GetBot(),
      "BOT_MODE_DEFEND_TOWER"))

  BOT_MODE = BOT_MODE_NONE

  luaunit.assertFalse(
    ability_usage.test_IsBotModeMatch(
      GetBot(),
      BOT_MODE_ATTACK))
end

function test_CalculateDesireAndTarget_succeed()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_DAMAGE = 200
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT

  local desire, target =
    ability_usage.test_CalculateDesireAndTarget(
      GetBot(),
      ability_usage_algorithms.min_hp_enemy_hero_to_kill,
      "any_mode",
      ability)

  luaunit.assertEquals(desire, true)
  luaunit.assertEquals(target, {10, 10})
end

function test_CalculateDesireAndTarget_fails()
  test_RefreshBot()

  local desire, target =
    ability_usage.test_CalculateDesireAndTarget(
      GetBot(),
      nil,
      "any_mode")

  luaunit.assertEquals(desire, false)
  luaunit.assertEquals(target, nil)

  BOT_MODE = BOT_MODE_ATTACK

  local desire, target =
    ability_usage.test_CalculateDesireAndTarget(
      GetBot(),
      ability_usage_algorithms.min_hp_enemy_hero_to_kill,
      BOT_MODE_LANING)

  luaunit.assertEquals(desire, false)
  luaunit.assertEquals(target, nil)
end

function test_ChooseAbilityAndTarget()
  test_RefreshBot()

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT
  ABILITY_DAMAGE = 200

  local ability, target =
    ability_usage.test_ChooseAbilityAndTarget(GetBot())

  luaunit.assertNotEquals(ability, nil)
  luaunit.assertNotEquals(target, nil)
end

function test_UseAbility()
  test_RefreshBot()

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT
  BOT_ABILITY = nil
  BOT_ABILITY_LOCATION = nil

  local ability = Ability:new("crystal_maiden_crystal_nova")
  local location =  {15, 25}

  ability_usage.test_UseAbility(GetBot(), ability, location)

  luaunit.assertEquals(BOT_ABILITY, ability)
  luaunit.assertEquals(BOT_ABILITY_LOCATION, location)
end

function test_AbilityUsageThink_succeed()
  test_RefreshBot()

  BOT_ABILITY = nil
  BOT_ABILITY_LOCATION = nil

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT
  ABILITY_DAMAGE = 200

  ability_usage.AbilityUsageThink()

  luaunit.assertEquals(
    BOT_ABILITY,
    Ability:new("crystal_maiden_crystal_nova"))

  luaunit.assertNotEquals(BOT_ABILITY_LOCATION, nil)
end

function test_AbilityUsageThink_when_bot_channeling_fails()
  test_RefreshBot()

  BOT_ABILITY = nil
  BOT_ABILITY_LOCATION = nil
  UNIT_IS_CHANNELING = true

  ABILITY_DAMAGE = 200
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT

  ability_usage.AbilityUsageThink()

  luaunit.assertEquals(
    BOT_ABILITY,
    nil)

  luaunit.assertEquals(BOT_ABILITY_LOCATION, nil)
end

os.exit(luaunit.LuaUnit.run())
