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

function test_IsTargetable()
  local unit = Unit:new()

  luaunit.assertTrue(ability_usage_algorithms.test_IsTargetable(unit))

  UNIT_CAN_BE_SEEN = false

  luaunit.assertFalse(ability_usage_algorithms.test_IsTargetable(unit))

  UNIT_CAN_BE_SEEN = true
  UNIT_IS_MAGIC_IMMUNE = true

  luaunit.assertFalse(ability_usage_algorithms.test_IsTargetable(unit))

  UNIT_IS_MAGIC_IMMUNE = false
  UNIT_IS_INVULNERABLE = true

  luaunit.assertFalse(ability_usage_algorithms.test_IsTargetable(unit))

  UNIT_IS_INVULNERABLE = false
  UNIT_IS_ILLUSION = true

  luaunit.assertFalse(ability_usage_algorithms.test_IsTargetable(unit))

  UNIT_IS_ILLUSION = false
end

os.exit(luaunit.LuaUnit.run())
