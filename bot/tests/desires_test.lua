package.path = package.path .. ";../utility/?.lua"

require("global_functions")

local desires = require("desires")
local luaunit = require('luaunit')

function test_Think()
  BARRAK_HEALTH = 0
  desires.Think()

  luaunit.assertAlmostEquals(
    desires.PUSH_LINES_DESIRE["PUSH_TOP_LINE_DESIRE"],
    -0.1,
    0.01)

  luaunit.assertAlmostEquals(
    desires.PUSH_LINES_DESIRE["PUSH_MID_LINE_DESIRE"],
    -0.1,
    0.01)

  luaunit.assertAlmostEquals(
    desires.PUSH_LINES_DESIRE["PUSH_BOT_LINE_DESIRE"],
    -0.1,
    0.01)
end

function test_UpdatePushLaneDesires()
  local result = desires.UpdatePushLaneDesires()

  luaunit.assertAlmostEquals(result[1], -0.1, 0.01)
  luaunit.assertAlmostEquals(result[2], -0.1, 0.01)
  luaunit.assertAlmostEquals(result[3], -0.1, 0.01)
end

os.exit(luaunit.LuaUnit.run())
