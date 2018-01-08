package.path = package.path .. ";../utility/?.lua"

require("global_functions")

local desires = require("desires")
local luaunit = require('luaunit')

function test_Think()
  BARRAK_HEALTH = 0

  local team_desires = desires.Think()

  luaunit.assertAlmostEquals(
    team_desires.PUSH_TOP_LINE_DESIRE,
    -0.1,
    0.01)

  luaunit.assertAlmostEquals(
    team_desires.PUSH_MID_LINE_DESIRE,
    -0.1,
    0.01)

  luaunit.assertAlmostEquals(
    team_desires.PUSH_BOT_LINE_DESIRE,
    -0.1,
    0.01)
end

os.exit(luaunit.LuaUnit.run())
