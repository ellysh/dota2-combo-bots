package.path = package.path .. ";../?.lua"

pcall(require, "luacov")
require("global_functions")

local mode_farm = require("mode_farm_generic")
local luaunit = require("luaunit")

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

--[[
function test_Think_move_succeed()
  test_RefreshBot()

  RUNE_STATUS = RUNE_STATUS_AVAILABLE
  UNIT_MOVE_LOCATION = nil
  RUNE_LOCATION = {2000, 2000}

  Think()

  luaunit.assertEquals(UNIT_MOVE_LOCATION, RUNE_LOCATION)
end

function test_Think_move_rune_too_far_fails()
  test_RefreshBot()

  RUNE_STATUS = RUNE_STATUS_AVAILABLE
  UNIT_MOVE_LOCATION = nil
  RUNE_LOCATION = {9000, 9000}

  Think()

  luaunit.assertEquals(UNIT_MOVE_LOCATION, nil)
end

function test_Think_pickup_succeed()
  test_RefreshBot()

  RUNE_STATUS = RUNE_STATUS_AVAILABLE
  UNIT_PICKUP_RUNE = nil
  RUNE_LOCATION = {20, 20}

  Think()

  luaunit.assertNotEquals(UNIT_PICKUP_RUNE, nil)
end
--]]
os.exit(luaunit.LuaUnit.run())
