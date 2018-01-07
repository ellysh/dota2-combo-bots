package.path = package.path .. ";../utility/?.lua"

require("global_functions")

local team_desires = require("team_desires")
local luaunit = require('luaunit')

function test_ally_mega_creeps()
  BARRAK_HEALTH = 100
  luaunit.assertFalse(team_desires.ally_mega_creeps())

  BARRAK_HEALTH = 0
  luaunit.assertTrue(team_desires.ally_mega_creeps())
end

function test_IsAllyHaveItem()
  local test_item = "item_enchanted_mango"

  luaunit.assertFalse(team_desires.test_IsAllyHaveItem(test_item))

  local unit = Unit:new()
  unit.inventory = { test_item }

  UNITS = { unit }

  luaunit.assertTrue(team_desires.test_IsAllyHaveItem(test_item))
end

function test_ally_have_aegis()
  luaunit.assertFalse(team_desires.ally_have_aegis())

  local unit = Unit:new()
  unit.inventory = { "item_aegis" }

  UNITS = { unit }

  luaunit.assertTrue(team_desires.ally_have_aegis())
end

function test_ally_have_cheese()
  luaunit.assertFalse(team_desires.ally_have_cheese())

  local unit = Unit:new()
  unit.inventory = { "item_cheese" }

  UNITS = { unit }

  luaunit.assertTrue(team_desires.ally_have_cheese())
end

function test_max_kills_enemy_hero_alive()
  luaunit.assertTrue(team_desires.max_kills_enemy_hero_alive())
end

function test_max_kills_ally_hero_alive()
  luaunit.assertTrue(team_desires.max_kills_ally_hero_alive())
end

function test_time_is_more_5_minutes()
  TIME = 1 * 60
  luaunit.assertFalse(team_desires.time_is_more_5_minutes())

  TIME = 6 * 60
  luaunit.assertTrue(team_desires.time_is_more_5_minutes())
end

function test_time_is_more_15_minutes()
  luaunit.assertFalse(team_desires.time_is_more_15_minutes())

  TIME = 16 * 60
  luaunit.assertTrue(team_desires.time_is_more_15_minutes())
end

function test_three_and_more_ally_heroes_on_top()
  luaunit.assertFalse(team_desires.three_and_more_ally_heroes_on_top())
end

function test_three_and_more_ally_heroes_on_mid()
  luaunit.assertFalse(team_desires.three_and_more_ally_heroes_on_mid())
end

function test_three_and_more_ally_heroes_on_bot()
  luaunit.assertFalse(team_desires.three_and_more_ally_heroes_on_bot())
end

function test_three_and_more_enemy_heroes_on_top()
  luaunit.assertFalse(team_desires.three_and_more_enemy_heroes_on_top())
end

function test_three_and_more_enemy_heroes_on_mid()
  luaunit.assertFalse(team_desires.three_and_more_enemy_heroes_on_mid())
end

function test_three_and_more_enemy_heroes_on_bot()
  luaunit.assertFalse(team_desires.three_and_more_enemy_heroes_on_bot())
end

function test_ThreeAndMoreUnitsOnLane()
  local unit = Unit:new()

  UNITS = { unit, unit, unit }

  luaunit.assertTrue(
    team_desires.test_ThreeAndMoreUnitsOnLane(
      UNIT_LIST_ALLIED_HEROES,
      LANE_TOP))

  UNITS = { unit, unit }

  luaunit.assertFalse(
    team_desires.test_ThreeAndMoreUnitsOnLane(
      UNIT_LIST_ALLIED_HEROES,
      LANE_TOP))
end

function test_TeamThink()
  BARRAK_HEALTH = 0
  team_desires.TeamThink()

  luaunit.assertAlmostEquals(
    team_desires.PUSH_LINES_DESIRE["PUSH_TOP_LINE_DESIRE"],
    -0.1,
    0.01)

  luaunit.assertAlmostEquals(
    team_desires.PUSH_LINES_DESIRE["PUSH_MID_LINE_DESIRE"],
    -0.1,
    0.01)

  luaunit.assertAlmostEquals(
    team_desires.PUSH_LINES_DESIRE["PUSH_BOT_LINE_DESIRE"],
    -0.2,
    0.01)
end

function test_UpdatePushLaneDesires()
  local result = team_desires.UpdatePushLaneDesires()

  luaunit.assertAlmostEquals(result[1], -0.1, 0.01)
  luaunit.assertAlmostEquals(result[2], -0.1, 0.01)
  luaunit.assertAlmostEquals(result[3], -0.2, 0.01)
end

os.exit(luaunit.LuaUnit.run())
