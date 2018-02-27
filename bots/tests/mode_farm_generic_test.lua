package.path = package.path .. ";../?.lua;../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local mode_farm = require("mode_farm_generic")
local memory = require("memory")
local luaunit = require("luaunit")

NEUTRAL_CAMP_LOCATION = {15, 15}

memory.InitNeutralCampList()

function test_GetDesire_when_level_six_and_high_hp_damage_positive()
  test_RefreshBot()

  local bot = GetBot()
  bot.level = 6
  bot.health = 1000
  bot.damage = 100

  luaunit.assertEquals(GetDesire(), 0.5)
end

function test_GetDesire_when_low_level_negative()
  test_RefreshBot()

  local bot = GetBot()
  bot.level = 1

  luaunit.assertEquals(GetDesire(), -0.7)
end

function test_GetEnemyFrontLocations_succeed()
  FRONT_LOCATION = {10, 10}

  local front_lanes = mode_farm.test_GetEnemyFrontLocations()

  luaunit.assertEquals(#front_lanes, 3)

  luaunit.assertEquals(
    front_lanes[1],
    {is_full=true, location={10, 10}, type=1})

  luaunit.assertEquals(
    front_lanes[2],
    {is_full=true, location={10, 10}, type=3})

  luaunit.assertEquals(
    front_lanes[3],
    {is_full=true, location={10, 10}, type=2})
end

function test_GetClosestFarmSpot_neutral_camp_succeed()
  test_RefreshBot()

  local bot = GetBot()
  bot.locaton = {10, 10}

  FRONT_LOCATION = {20, 20}

  luaunit.assertEquals(mode_farm.test_GetClosestFarmSpot(), {15, 15})
end

function test_GetClosestFarmSpot_front_lane_succeed()
  test_RefreshBot()

  local bot = GetBot()
  bot.locaton = {10, 10}

  FRONT_LOCATION = {10, 10}

  luaunit.assertEquals(mode_farm.test_GetClosestFarmSpot(), {10, 10})
end

function test_Think_attack_succeed()
  test_RefreshBot()

  local bot = GetBot()
  bot.location = {15, 15}

  FRONT_LOCATION = {15, 15}
  NEUTRAL_CAMP_LOCATION = {2000, 2000}

  Think()

  luaunit.assertNotEquals(ATTACK_TARGET, nil)
end

function test_Think_move_succeed()
  test_RefreshBot()

  local bot = GetBot()
  bot.location = {1200, 1200}

  UNIT_HAS_NEARBY_UNITS = false
  UNIT_MOVE_LOCATION = nil
  FRONT_LOCATION = {1000, 1000}

  Think()

  luaunit.assertEquals(UNIT_MOVE_LOCATION, {1000, 1000})
end

os.exit(luaunit.LuaUnit.run())
