package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local minions = require("minions")
local luaunit = require('luaunit')

function test_MinionThink()
  -- TODO: Implement this test

  minions.MinionThink(Unit:new())
end

os.exit(luaunit.LuaUnit.run())
