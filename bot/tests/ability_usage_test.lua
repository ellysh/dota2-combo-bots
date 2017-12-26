package.path = package.path .. ";../utility/?.lua"

require("global_functions")

local ability_usage = require("ability_usage")
local luaunit = require('luaunit')

function test_InitAbilities()
  test_RefreshBot()
end

os.exit(luaunit.LuaUnit.run())
