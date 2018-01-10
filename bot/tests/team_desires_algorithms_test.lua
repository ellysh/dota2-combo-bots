package.path = package.path .. ";../utility/?.lua"

require("global_functions")

local algorithms = require("team_desires_algorithms")
local luaunit = require('luaunit')

function test_ally_mega_creeps()
  BARRAK_HEALTH = 100
  luaunit.assertFalse(algorithms.ally_mega_creeps())

  BARRAK_HEALTH = 0
  luaunit.assertTrue(algorithms.ally_mega_creeps())
end

function test_IsAllyHaveItem()
  local test_item = "item_enchanted_mango"

  luaunit.assertFalse(algorithms.test_IsAllyHaveItem(test_item))

  local unit = Unit:new()
  unit.inventory = { test_item }

  UNITS = { unit }

  luaunit.assertTrue(algorithms.test_IsAllyHaveItem(test_item))
end

function test_ally_have_aegis()
  luaunit.assertFalse(algorithms.ally_have_aegis())

  local unit = Unit:new()
  unit.inventory = { "item_aegis" }

  UNITS = { unit }

  luaunit.assertTrue(algorithms.ally_have_aegis())
end

function test_ally_have_cheese()
  luaunit.assertFalse(algorithms.ally_have_cheese())

  local unit = Unit:new()
  unit.inventory = { "item_cheese" }

  UNITS = { unit }

  luaunit.assertTrue(algorithms.ally_have_cheese())
end

function test_max_kills_enemy_hero_alive()
  luaunit.assertTrue(algorithms.max_kills_enemy_hero_alive())
end

function test_max_kills_ally_hero_alive()
  luaunit.assertTrue(algorithms.max_kills_ally_hero_alive())
end

function test_time_is_more_5_minutes()
  TIME = 1 * 60
  luaunit.assertFalse(algorithms.time_is_more_5_minutes())

  TIME = 6 * 60
  luaunit.assertTrue(algorithms.time_is_more_5_minutes())
end

function test_time_is_more_15_minutes()
  luaunit.assertFalse(algorithms.time_is_more_15_minutes())

  TIME = 16 * 60
  luaunit.assertTrue(algorithms.time_is_more_15_minutes())
end

function test_ThreeAndMoreUnitsOnLane()
  local unit = Unit:new()

  UNITS = { unit, unit, unit }

  luaunit.assertTrue(
    algorithms.test_ThreeAndMoreUnitsOnLane(
      UNIT_LIST_ALLIED_HEROES,
      LANE_TOP))

  UNITS = { unit, unit }

  luaunit.assertFalse(
    algorithms.test_ThreeAndMoreUnitsOnLane(
      UNIT_LIST_ALLIED_HEROES,
      LANE_TOP))
end

function test_three_and_more_ally_heroes_on_top()
  luaunit.assertFalse(algorithms.three_and_more_ally_heroes_on_top())
end

function test_three_and_more_ally_heroes_on_mid()
  luaunit.assertFalse(algorithms.three_and_more_ally_heroes_on_mid())
end

function test_three_and_more_ally_heroes_on_bot()
  luaunit.assertFalse(algorithms.three_and_more_ally_heroes_on_bot())
end

function test_three_and_more_enemy_heroes_on_top()
  luaunit.assertFalse(algorithms.three_and_more_enemy_heroes_on_top())
end

function test_three_and_more_enemy_heroes_on_mid()
  luaunit.assertFalse(algorithms.three_and_more_enemy_heroes_on_mid())
end

function test_three_and_more_enemy_heroes_on_bot()
  luaunit.assertFalse(algorithms.three_and_more_enemy_heroes_on_bot())
end

function test_more_ally_heroes_alive_then_enemy()
  luaunit.assertFalse(algorithms.more_ally_heroes_alive_then_enemy())
end

os.exit(luaunit.LuaUnit.run())