package.path = package.path .. ";../utility/?.lua"

require("global_functions")

local ability_usage = require("ability_usage")
local luaunit = require('luaunit')

function test_IsBotModeMatch_success()
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

function test_IsBotModeMatch_failes()
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

function test_ChooseAbilityAndTarget()
  test_RefreshBot()

  local ability, target =
    ability_usage.test_ChooseAbilityAndTarget(GetBot())

  luaunit.assertEquals(
    ability,
    Ability:new("crystal_maiden_crystal_nova"))

  luaunit.assertEquals(target, {0, 0})
end

os.exit(luaunit.LuaUnit.run())
