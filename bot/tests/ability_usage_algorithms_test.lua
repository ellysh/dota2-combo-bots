package.path = package.path .. ";../utility/?.lua"

require("global_functions")

local ability_usage_algorithms = require("ability_usage_algorithms")
local luaunit = require('luaunit')

function test_GetEnemyHeroMinHp()
  test_RefreshBot()

  local units = ability_usage_algorithms.test_GetEnemyHeroes(
    GetBot(),
    1200)

  luaunit.assertEquals(units[1]:GetUnitName(), "unit1")
  luaunit.assertEquals(units[2]:GetUnitName(), "unit2")
end

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

function test_IsEnoughDamageToKill()
  local unit = Unit:new()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_DAMAGE = 200

  luaunit.assertTrue(
    ability_usage_algorithms.test_IsEnoughDamageToKill(
      unit,
      ability))

  ABILITY_DAMAGE = 150

  luaunit.assertFalse(
    ability_usage_algorithms.test_IsEnoughDamageToKill(
      unit,
      ability))
end

function test_GetTarget()
  local unit = Unit:new()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_UNIT_TARGET

  luaunit.assertEquals(
    ability_usage_algorithms.test_GetTarget(unit, ability),
    unit)

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT

  luaunit.assertEquals(
    ability_usage_algorithms.test_GetTarget(unit, ability),
    unit:GetLocation())

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_NO_TARGET

  luaunit.assertEquals(
    ability_usage_algorithms.test_GetTarget(unit, ability),
    nil)
end

function test_low_hp_enemy_hero_to_kill()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT
  ABILITY_DAMAGE = 200

  local desire, target =
    ability_usage_algorithms.low_hp_enemy_hero_to_kill(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, BOT_MODE_DESIRE_VERYHIGH)
  luaunit.assertEquals(target, {20, 20})
end

function test_channeling_enemy_hero()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  UNIT_IS_CHANNELING = true
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT

  local desire, target = ability_usage_algorithms.channeling_enemy_hero(
    GetBot(),
    ability)

  luaunit.assertEquals(desire, BOT_MODE_DESIRE_VERYHIGH)
  luaunit.assertEquals(target, {20, 20})
end

os.exit(luaunit.LuaUnit.run())