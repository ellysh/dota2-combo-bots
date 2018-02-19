package.path = package.path .. ";../?.lua"

pcall(require, "luacov")
require("global_functions")

local mode = require("mode_team_roam_generic")
local luaunit = require("luaunit")

function test_GetDesire_positive()
  test_RefreshBot()

  ROAM_DESIRE = 0.7

  luaunit.assertAlmostEquals(GetDesire(), 0.1, 0.01)
end

function test_GetDesire_low_hp_negative()
  test_RefreshBot()

  local bot = GetBot()
  bot.health = 10

  ROAM_DESIRE = 0

  luaunit.assertEquals(GetDesire(), -0.9)
end

function test_Think_attack_succeed()
  test_RefreshBot()

  IS_HERO_ALIVE = true
  ATTACK_TARGET = nil
  HERO_LAST_SEEN_INFO = { {location = {10, 10}, time_since_seen = 2} }

  Think()

  luaunit.assertNotEquals(ATTACK_TARGET, nil)
end

function test_Think_move_succeed()
  test_RefreshBot()

  IS_HERO_ALIVE = true
  UNIT_NO_NEARBY_UNITS = true
  UNIT_MOVE_LOCATION = nil
  HERO_LAST_SEEN_INFO = { {location = {10, 10}, time_since_seen = 2} }

  Think()

  luaunit.assertEquals(UNIT_MOVE_LOCATION, {10, 10})
end

function test_Think_no_alive_enemy_hero_fails()
  test_RefreshBot()

  IS_HERO_ALIVE = false
  UNIT_NO_NEARBY_UNITS = true
  UNIT_MOVE_LOCATION = nil
  HERO_LAST_SEEN_INFO = { {location = {10, 10}, time_since_seen = 2} }

  Think()

  luaunit.assertEquals(UNIT_MOVE_LOCATION, nil)
end

function test_Think_no_seen_enemy_hero_fails()
  test_RefreshBot()

  IS_HERO_ALIVE = true
  UNIT_NO_NEARBY_UNITS = true
  UNIT_MOVE_LOCATION = nil
  HERO_LAST_SEEN_INFO = {}

  Think()

  luaunit.assertEquals(UNIT_MOVE_LOCATION, nil)
end

os.exit(luaunit.LuaUnit.run())
