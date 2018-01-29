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
    team_desires.PUSH_TOP_LINE_DESIRE,
    -0.5,
    0.01)

  luaunit.assertAlmostEquals(
    team_desires.PUSH_MID_LINE_DESIRE,
    -0.5,
    0.01)

  luaunit.assertAlmostEquals(
    team_desires.PUSH_BOT_LINE_DESIRE,
    -0.5,
    0.01)
end

os.exit(luaunit.LuaUnit.run())
