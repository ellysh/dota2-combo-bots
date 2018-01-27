package.path = package.path .. ";../?.lua"

pcall(require, "luacov")
require("global_functions")

local mode_rune = require("mode_rune_generic")
local luaunit = require('luaunit')

function test_GetDesire_when_rune_missing_negative()
  test_RefreshBot()

  RUNE_STATUS = RUNE_STATUS_MISSING
  TIME = 0.4
  RUNE_LOCATION = {20, 20}

  luaunit.assertEquals(GetDesire(), 0)
end

function test_GetDesire_when_rune_too_far_negative()
  test_RefreshBot()

  RUNE_STATUS = RUNE_STATUS_MISSING
  TIME = 1.9
  RUNE_LOCATION = {4000, 4000}

  luaunit.assertEquals(GetDesire(), 0)
end

function test_GetDesire_when_rune_appear_soon_positive()
  test_RefreshBot()

  RUNE_STATUS = RUNE_STATUS_MISSING
  TIME = 1.9
  RUNE_LOCATION = {20, 20}

  luaunit.assertAlmostEquals(GetDesire(), 1.28, 0.01)
end

function test_GetDesire_on_beginning_positive()
  test_RefreshBot()

  RUNE_STATUS = RUNE_STATUS_MISSING
  TIME = -1.0
  RUNE_LOCATION = {20, 20}

  luaunit.assertEquals(GetDesire(), 0.75)
end

function test_GetDesire_when_rune_available_positive()
  test_RefreshBot()

  RUNE_STATUS = RUNE_STATUS_AVAILABLE
  RUNE_LOCATION = {20, 20}

  luaunit.assertEquals(GetDesire(), 0.75)
end

function test_Think_move_succeed()
  test_RefreshBot()

  RUNE_STATUS = RUNE_STATUS_AVAILABLE
  UNIT_MOVE_LOCATION = nil
  RUNE_LOCATION = {2000, 2000}

  Think()

  luaunit.assertEquals(UNIT_MOVE_LOCATION, RUNE_LOCATION)
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
