package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local mode_push = require("mode_push")
local constants = require("constants")
local luaunit = require('luaunit')

function test_Think()
  test_RefreshBot()

  ATTACK_TARGET = nil
  mode_push.Think(LANE_TOP)

  luaunit.assertNotEquals(ATTACK_TARGET, nil)
end

os.exit(luaunit.LuaUnit.run())
