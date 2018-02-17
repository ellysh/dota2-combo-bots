package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local algorithms = require("common_algorithms")
local luaunit = require('luaunit')

function test_IsAttackTargetable_default_succeed()
  local unit = Unit:new()

  luaunit.assertTrue(algorithms.IsAttackTargetable(unit))
end

function test_IsAttackTargetable_not_seen_fails()
  local unit = Unit:new()

  UNIT_CAN_BE_SEEN = false

  luaunit.assertFalse(algorithms.IsAttackTargetable(unit))
end

function test_IsAttackTargetable_magic_immune_succeed()
  local unit = Unit:new()

  UNIT_CAN_BE_SEEN = true
  UNIT_IS_MAGIC_IMMUNE = true
  UNIT_IS_ILLUSION = false
  UNIT_IS_INVULNERABLE = false

  luaunit.assertTrue(algorithms.IsAttackTargetable(unit))
end

function test_IsAttackTargetable_invulnerable_fails()
  local unit = Unit:new()

  UNIT_IS_MAGIC_IMMUNE = false
  UNIT_IS_INVULNERABLE = true

  luaunit.assertFalse(algorithms.IsAttackTargetable(unit))
end

function test_IsAttackTargetable_illusion_fails()
  local unit = Unit:new()

  UNIT_IS_INVULNERABLE = false
  UNIT_IS_ILLUSION = true

  luaunit.assertFalse(algorithms.IsAttackTargetable(unit))
end

os.exit(luaunit.LuaUnit.run())
