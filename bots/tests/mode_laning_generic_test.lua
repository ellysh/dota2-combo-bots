package.path = package.path .. ";../?.lua"

pcall(require, "luacov")
require("global_functions")

local mode = require("mode_laning_generic")
local luaunit = require("luaunit")

function test_GetDesire_below_level_six_positive()
  test_RefreshBot()

  luaunit.assertEquals(GetDesire(), 0.5)
end

function test_GetDesire_after_level_six_positive()
  test_RefreshBot()

  local bot = GetBot()
  bot.level = 7

  luaunit.assertEquals(GetDesire(), 0.25)
end

os.exit(luaunit.LuaUnit.run())
