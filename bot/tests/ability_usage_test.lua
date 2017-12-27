package.path = package.path .. ";../utility/?.lua"

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
      BOT_MODE_ROAM))

  BOT_MODE = BOT_MODE_TEAM_ROAM

  luaunit.assertTrue(
    ability_usage.test_IsBotModeMatch(
      GetBot(),
      BOT_MODE_ROAM))

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
      BOT_MODE_ATTACK))
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

  local desire, target =
    ability_usage.test_CalculateDesireAndTarget(
      GetBot(),
      ability_usage_algorithms.low_hp_enemy_hero_to_kill,
      "any_mode")

  luaunit.assertEquals(desire, BOT_ACTION_DESIRE_HIGH)
  luaunit.assertEquals(target, {0, 0})
end

function test_CalculateDesireAndTarget_fails()
  test_RefreshBot()

  local desire, target =
    ability_usage.test_CalculateDesireAndTarget(
      GetBot(),
      nil,
      "any_mode")

  luaunit.assertEquals(desire, BOT_ACTION_DESIRE_NONE)
  luaunit.assertEquals(target, nil)

  BOT_MODE = BOT_MODE_ATTACK

  local desire, target =
    ability_usage.test_CalculateDesireAndTarget(
      GetBot(),
      ability_usage_algorithms.low_hp_enemy_hero_to_kill,
      BOT_MODE_LANING)

  luaunit.assertEquals(desire, BOT_ACTION_DESIRE_NONE)
  luaunit.assertEquals(target, nil)
end

function test_ChooseAbilityAndTarget()
  test_RefreshBot()

  local ability, target =
    ability_usage.test_ChooseAbilityAndTarget(GetBot())

  luaunit.assertEquals(
    ability,
    Ability:new("crystal_maiden_crystal_nova"))

  luaunit.assertEquals(target, {0, 0})
end

function test_AbilityUsageThink()
  test_RefreshBot()

  ability_usage.AbilityUsageThink()

  -- TODO: Check the used ability here
end

os.exit(luaunit.LuaUnit.run())