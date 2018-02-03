package.path = package.path .. ";../?.lua"

pcall(require, "luacov")
require("global_functions")

local mode_rune = require("mode_rune_generic")
local luaunit = require('luaunit')

function test_GetDesire_when_rune_missing_negative()
  test_RefreshBot()

  RUNE_STATUS = RUNE_STATUS_MISSING
  TIME = 40
  RUNE_LOCATION = {20, 20}

  luaunit.assertEquals(GetDesire(), 0)
end

function test_GetDesire_when_bot_fighting_negative()
  test_RefreshBot()

  RUNE_STATUS = RUNE_STATUS_AVAILABLE
  RUNE_LOCATION = {500, 500}
  UNIT_MODE = BOT_MODE_ATTACK

  luaunit.assertEquals(GetDesire(), 0)
end

function test_GetDesire_when_bot_fighting_but_rune_close_positive()
  test_RefreshBot()

  RUNE_STATUS = RUNE_STATUS_AVAILABLE
  RUNE_LOCATION = {100, 100}
  UNIT_MODE = BOT_MODE_ATTACK
  RUNE_TYPE = RUNE_BOUNTY_1

  luaunit.assertEquals(GetDesire(), 0.6)
end

function test_GetDesire_when_rune_too_far_negative()
  test_RefreshBot()

  RUNE_STATUS = RUNE_STATUS_MISSING
  TIME = 1 * 60 + 50
  RUNE_LOCATION = {4000, 4000}

  luaunit.assertEquals(GetDesire(), 0)
end

function test_GetDesire_when_rune_appear_soon_positive()
  test_RefreshBot()

  RUNE_STATUS = RUNE_STATUS_MISSING
  TIME = 1 * 60 + 50
  RUNE_LOCATION = {20, 20}
  UNIT_MODE = BOT_MODE_NONE

  luaunit.assertAlmostEquals(GetDesire(), 0.6, 0.01)
end

function test_GetDesire_when_rune_appear_soon_and_fight_negative()
  test_RefreshBot()

  RUNE_STATUS = RUNE_STATUS_MISSING
  TIME = 1 * 60 + 50
  RUNE_LOCATION = {20, 20}
  UNIT_MODE = BOT_MODE_ATTACK

  luaunit.assertEquals(GetDesire(), 0)
end

function test_GetDesire_on_beginning_bounty_rune_positive()
  test_RefreshBot()

  RUNE_STATUS = RUNE_STATUS_MISSING
  TIME = -60
  RUNE_LOCATION = {20, 20}
  RUNE_TYPE = RUNE_BOUNTY_1

  luaunit.assertEquals(GetDesire(), 0.6)
end

function test_GetDesire_on_beginning_power_rune_negative()
  test_RefreshBot()

  RUNE_STATUS = RUNE_STATUS_MISSING
  TIME = -60
  RUNE_LOCATION = {20, 20}
  RUNE_TYPE = RUNE_POWERUP_1

  luaunit.assertEquals(GetDesire(), 0.0)
end

function test_GetDesire_when_rune_available_positive()
  test_RefreshBot()

  RUNE_STATUS = RUNE_STATUS_AVAILABLE
  RUNE_LOCATION = {20, 20}

  luaunit.assertEquals(GetDesire(), 0.6)
end

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

os.exit(luaunit.LuaUnit.run())
