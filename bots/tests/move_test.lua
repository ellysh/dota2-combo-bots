package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local move = require("move")
local luaunit = require('luaunit')

function test_Move_action_move_succeed()
  test_RefreshBot()

  local target_location = {150, 150}
  UNIT_MOVE_LOCATION = nil

  move.Move(GetBot(), target_location)

  luaunit.assertEquals(UNIT_MOVE_LOCATION, target_location)
end

function test_GetTpScrollAbility_succeed()
  test_RefreshBot()

  local ability = Ability:new("item_tpscroll")

  luaunit.assertEquals(move.test_GetTpScrollAbility(GetBot()), ability)
end

function test_CanUseTpScroll_succeed()
  test_RefreshBot()

  local target_location = {3000, 3000}
  ABILITY_IS_FULLY_CASTABLE = true

  luaunit.assertTrue(
    move.test_CanUseTpScroll(GetBot(), target_location))
end

function test_Move_use_tp_scroll_succeed()
  test_RefreshBot()

  local ability = Ability:new("item_tpscroll")
  local target_location = {3000, 3000}

  UNIT_ABILITY = nil
  UNIT_ABILITY_LOCATION = nil
  ABILITY_IS_FULLY_CASTABLE = true

  move.Move(GetBot(), target_location)

  luaunit.assertEquals(UNIT_ABILITY, ability)
  luaunit.assertEquals(UNIT_ABILITY_LOCATION, target_location)
end

os.exit(luaunit.LuaUnit.run())
