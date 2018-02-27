package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local mode_push = require("mode_push")
local constants = require("constants")
local luaunit = require("luaunit")

function test_Think_attack_succeed()
  test_RefreshBot()

  ATTACK_TARGET = nil
  mode_push.Think(LANE_TOP)

  luaunit.assertNotEquals(ATTACK_TARGET, nil)
end

function test_Think_move_succeed()
  test_RefreshBot()

  UNIT_HAS_NEARBY_UNITS = false
  UNIT_MOVE_LOCATION = nil
  mode_push.Think(LANE_TOP)

  luaunit.assertEquals(UNIT_MOVE_LOCATION, {10, 10})
end

os.exit(luaunit.LuaUnit.run())
