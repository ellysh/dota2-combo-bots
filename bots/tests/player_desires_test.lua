package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local player_desires = require("player_desires")
local constants = require("constants")
local luaunit = require('luaunit')

function test_GetDesire()
  test_RefreshBot()

  luaunit.assertAlmostEquals(
    player_desires.GetDesire("BOT_MODE_PUSH_TOWER_TOP"),
    0.0,
    0.001)

  luaunit.assertAlmostEquals(
    player_desires.GetDesire("BOT_MODE_PUSH_TOWER_MID"),
    0.0,
    0.001)

  luaunit.assertAlmostEquals(
    player_desires.GetDesire("BOT_MODE_PUSH_TOWER_BOT"),
    0.0,
    0.001)
end

os.exit(luaunit.LuaUnit.run())
