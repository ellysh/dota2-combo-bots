package.path = package.path .. ";../?.lua"

pcall(require, "luacov")
require("global_functions")

local mode = require("mode_laning_generic")
local luaunit = require("luaunit")

function test_GetDesire_positive()
  test_RefreshBot()

  luaunit.assertEquals(GetDesire(), 0.5)
end

os.exit(luaunit.LuaUnit.run())
