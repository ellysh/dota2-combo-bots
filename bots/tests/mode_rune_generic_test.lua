package.path = package.path .. ";../?.lua"

pcall(require, "luacov")
require("global_functions")

local mode_rune = require("mode_rune_generic")
local luaunit = require('luaunit')

function test_GetDesire()
  test_RefreshBot()

  luaunit.assertEquals(GetDesire(), 0.75)
end

os.exit(luaunit.LuaUnit.run())
