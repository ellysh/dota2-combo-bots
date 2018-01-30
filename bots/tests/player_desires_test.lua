package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local player_desires = require("player_desires")
local constants = require("constants")
local luaunit = require('luaunit')

function test_GetDesire()
  test_RefreshBot()

  PUSH_LANE_DESIRE = 0
  luaunit.assertAlmostEquals(
    player_desires.GetDesire(
      "BOT_MODE_PUSH_TOWER_TOP",
      BOT_MODE_PUSH_TOWER_TOP),
    -0.05,
    0.001)

  PUSH_LANE_DESIRE = 0.5
  luaunit.assertAlmostEquals(
    player_desires.GetDesire(
      "BOT_MODE_PUSH_TOWER_MID",
      BOT_MODE_PUSH_TOWER_MIT),
    0.45,
    0.001)

  PUSH_LANE_DESIRE = 0.7
  luaunit.assertAlmostEquals(
    player_desires.GetDesire(
      "BOT_MODE_PUSH_TOWER_BOT",
      BOT_MODE_PUSH_TOWER_BOT),
    0.65,
    0.001)
end

os.exit(luaunit.LuaUnit.run())
