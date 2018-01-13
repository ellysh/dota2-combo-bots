package.path = package.path .. ";../utility/?.lua"

require("global_functions")

local mode_push = require("mode_push")
local constants = require("constants")
local luaunit = require('luaunit')

function test_GetDesire()
  test_RefreshBot()

  luaunit.assertEquals(mode_push.GetDesire(LANE_TOP), 0)
end

os.exit(luaunit.LuaUnit.run())
