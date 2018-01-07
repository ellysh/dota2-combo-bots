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

function test_TeamThink()
  BARRAK_HEALTH = 0
  team_desires.TeamThink()

  luaunit.assertEquals(
    team_desires.PUSH_LINES_DESIRE["PUSH_TOP_LINE_DESIRE"],
    -0.2)

  luaunit.assertEquals(
    team_desires.PUSH_LINES_DESIRE["PUSH_MID_LINE_DESIRE"],
    -0.2)

  luaunit.assertEquals(
    team_desires.PUSH_LINES_DESIRE["PUSH_BOT_LINE_DESIRE"],
    -0.2)
end

os.exit(luaunit.LuaUnit.run())
