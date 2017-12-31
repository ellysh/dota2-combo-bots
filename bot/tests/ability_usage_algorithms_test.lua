package.path = package.path .. ";../utility/?.lua"

require("global_functions")

local ability_usage_algorithms = require("ability_usage_algorithms")
local luaunit = require('luaunit')

function test_GetEnemyHeroMinHp()
  test_RefreshBot()

  local unit = ability_usage_algorithms.test_GetEnemyHeroMinHp(
    GetBot(),
    1200)

  luaunit.assertEquals(unit:GetUnitName(), "unit1")
  luaunit.assertEquals(unit:GetHealth(), 150)
end

os.exit(luaunit.LuaUnit.run())
