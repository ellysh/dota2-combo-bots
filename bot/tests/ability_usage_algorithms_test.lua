package.path = package.path .. ";../utility/?.lua"

require("global_functions")

local ability_usage_algorithms = require("ability_usage_algorithms")
local luaunit = require('luaunit')

function test_GetEnemyHeroMinHp()
  test_RefreshBot()

  -- TODO: Implement this test
end

os.exit(luaunit.LuaUnit.run())
