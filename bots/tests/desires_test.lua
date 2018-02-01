package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local luaunit = require("luaunit")
local desires = require("desires")
local team_desires = require("database/team_desires")
local algorithms = require("utility/team_desires_algorithms")


function test_Think()
  BARRAK_HEALTH = 0

  local team_desires = desires.Think(
    team_desires.TEAM_DESIRES,
    algorithms)

  luaunit.assertAlmostEquals(
    team_desires.BOT_MODE_PUSH_TOWER_TOP,
    -0.7,
    0.01)

  luaunit.assertAlmostEquals(
    team_desires.BOT_MODE_PUSH_TOWER_MID,
    -0.7,
    0.01)

  luaunit.assertAlmostEquals(
    team_desires.BOT_MODE_PUSH_TOWER_BOT,
    -0.7,
    0.01)
end

os.exit(luaunit.LuaUnit.run())
