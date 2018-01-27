package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local algorithms = require("attack_algorithms")
local luaunit = require('luaunit')

function test_IsTargetable()
  local unit = Unit:new()

  luaunit.assertTrue(algorithms.test_IsTargetable(unit))

  UNIT_CAN_BE_SEEN = false

  luaunit.assertFalse(algorithms.test_IsTargetable(unit))

  UNIT_CAN_BE_SEEN = true
  UNIT_IS_MAGIC_IMMUNE = true

  luaunit.assertTrue(algorithms.test_IsTargetable(unit))

  UNIT_IS_MAGIC_IMMUNE = false
  UNIT_IS_INVULNERABLE = true

  luaunit.assertFalse(algorithms.test_IsTargetable(unit))

  UNIT_IS_INVULNERABLE = false
  UNIT_IS_ILLUSION = true

  luaunit.assertFalse(algorithms.test_IsTargetable(unit))

  UNIT_IS_ILLUSION = false
end

function test_max_kills_enemy_hero_succeed()
  test_RefreshBot()

  UNIT_CAN_BE_SEEN = true

  local desire, target = algorithms.max_kills_enemy_hero(
    GetBot(),
    1200)

  luaunit.assertEquals(desire, true)
  luaunit.assertEquals(target:GetUnitName(), "unit1")
end

function test_max_kills_enemy_hero_not_targetable_fails()
  test_RefreshBot()

  UNIT_CAN_BE_SEEN = false

  local desire, target = algorithms.max_kills_enemy_hero(
    GetBot(),
    1200)

  luaunit.assertEquals(desire, false)
  luaunit.assertEquals(target, nil)
end

function test_max_estimated_damage_enemy_hero_succeed()
  test_RefreshBot()

  UNIT_CAN_BE_SEEN = true

  local desire, target = algorithms.max_estimated_damage_enemy_hero(
    GetBot(),
    1200)

  luaunit.assertEquals(desire, true)
  luaunit.assertEquals(target:GetUnitName(), "unit2")
end

function test_max_estimated_damage_enemy_hero_not_targetable_fails()
  test_RefreshBot()

  UNIT_CAN_BE_SEEN = false

  local desire, target = algorithms.max_estimated_damage_enemy_hero(
    GetBot(),
    1200)

  luaunit.assertEquals(desire, false)
  luaunit.assertEquals(target, nil)
end

function test_max_hp_creep_succeed()
  test_RefreshBot()

  UNIT_CAN_BE_SEEN = true

  local desire, target = algorithms.max_hp_creep(
    GetBot(),
    1200)

  luaunit.assertEquals(desire, true)
  luaunit.assertEquals(target:GetUnitName(), "creep2")
end

function test_last_hit_creep_succeed()
  test_RefreshBot()

  UNIT_CAN_BE_SEEN = true

  local desire, target = algorithms.last_hit_creep(
    GetBot(),
    1200)

  luaunit.assertEquals(desire, true)
  luaunit.assertEquals(target:GetUnitName(), "creep1")
end

function test_min_hp_enemy_building_succeed()
  test_RefreshBot()

  UNIT_CAN_BE_SEEN = true

  local desire, target = algorithms.min_hp_enemy_building(
    GetBot(),
    1200)

  luaunit.assertEquals(desire, true)
  luaunit.assertEquals(target:GetUnitName(), "tower1")
end

function test_low_hp_enemy_hero_succeed()
  test_RefreshBot()

  UNIT_CAN_BE_SEEN = true

  local desire, target = algorithms.low_hp_enemy_hero(
    GetBot(),
    1200)

  luaunit.assertEquals(desire, true)
  luaunit.assertEquals(target:GetUnitName(), "unit1")
end

function test_low_hp_enemy_building_succeed()
  test_RefreshBot()

  UNIT_CAN_BE_SEEN = true
  UNIT_IS_NEARBY_TOWERS = true

  local desire, target = algorithms.low_hp_enemy_building(
    GetBot(),
    1200)

  luaunit.assertEquals(desire, true)
  luaunit.assertEquals(target:GetUnitName(), "tower1")
end

os.exit(luaunit.LuaUnit.run())
