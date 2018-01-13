package.path = package.path .. ";../utility/?.lua"

require("global_functions")

local mode_push = require("mode_push")
local constants = require("constants")
local luaunit = require('luaunit')

function test_GetDesire()
  test_RefreshBot()

  PUSH_LANE_DESIRE = 0
  luaunit.assertEquals(mode_push.GetDesire(LANE_TOP), 0)

  PUSH_LANE_DESIRE = 0.5
  luaunit.assertEquals(mode_push.GetDesire(LANE_MID), 0.5)

  PUSH_LANE_DESIRE = 0.7
  luaunit.assertEquals(mode_push.GetDesire(LANE_BOT), 0.7)
end

function test_GetDesire()
  test_RefreshBot()

  mode_push.Think(LANE_TOP)

  luaunit.assertEquals(ATTACK_MOVE_LOCATION, FRONT_LOCATION)
end

os.exit(luaunit.LuaUnit.run())
