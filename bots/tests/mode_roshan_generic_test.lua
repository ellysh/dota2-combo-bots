package.path = package.path .. ";../?.lua"

pcall(require, "luacov")
require("global_functions")

local mode = require("mode_roshan_generic")
local luaunit = require("luaunit")

function test_GetDesire_positive()
  test_RefreshBot()

  ROSHAN_DESIRE = 0.7

  luaunit.assertAlmostEquals(GetDesire(), 0.55, 0.01)
end

function test_GetDesire_low_hp_negative()
  test_RefreshBot()

  local bot = GetBot()
  bot.health = 10

  ROSHAN_DESIRE = 0

  luaunit.assertAlmostEquals(GetDesire(), -0.65, 0.01)
end

function test_Think_attack_succeed()
  test_RefreshBot()

  local bot = GetBot()
  bot.location = {-2190, 1650}

  Think()

  luaunit.assertNotEquals(ATTACK_TARGET, nil)
end

function test_Think_move_succeed()
  test_RefreshBot()

  UNIT_HAS_NEARBY_UNITS = false
  UNIT_MOVE_LOCATION = nil

  Think()

  luaunit.assertEquals(UNIT_MOVE_LOCATION, {-2190, 1650})
end

os.exit(luaunit.LuaUnit.run())
