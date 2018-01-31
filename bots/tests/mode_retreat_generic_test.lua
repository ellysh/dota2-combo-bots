package.path = package.path .. ";../?.lua"

pcall(require, "luacov")
require("global_functions")

local mode_retreat = require("mode_retreat_generic")
local luaunit = require('luaunit')

function test_GetDesire_with_normal_hp_negative()
  test_RefreshBot()

  luaunit.assertEquals(GetDesire(), 0)
end

function test_GetDesire_when_low_hp_positive()
  test_RefreshBot()

  local bot = GetBot()
  bot.health = 50

  luaunit.assertEquals(GetDesire(), 0.85)
end

function test_Think_move_succeed()
  test_RefreshBot()

  UNIT_MOVE_LOCATION = nil

  Think()

  luaunit.assertEquals(UNIT_MOVE_LOCATION, {1, 1})
end

os.exit(luaunit.LuaUnit.run())
