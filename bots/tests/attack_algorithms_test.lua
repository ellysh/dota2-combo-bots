package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local algorithms = require("attack_algorithms")
local luaunit = require('luaunit')

local function test_algorithm_pattern_succeed(algorithm, expect_target)
  local desire, target = algorithms[algorithm](
    GetBot(),
    1200)

  luaunit.assertTrue(desire)
  luaunit.assertEquals(target:GetUnitName(), expect_target)
end

local function test_algorithm_pattern_fails(algorithm)
  local desire, target = algorithms[algorithm](
    GetBot(),
    1200)

  luaunit.assertFalse(desire)
  luaunit.assertEquals(target, nil)
end

function test_max_kills_enemy_hero_succeed()
  test_RefreshBot()

  UNIT_IS_INVULNERABLE = false

  test_algorithm_pattern_succeed("max_kills_enemy_hero", "unit1")
end

function test_max_kills_enemy_hero_not_targetable_fails()
  test_RefreshBot()

  UNIT_IS_INVULNERABLE = true

  test_algorithm_pattern_fails("max_kills_enemy_hero")
end

function test_max_hp_enemy_creep_succeed()
  test_RefreshBot()

  UNIT_CAN_BE_SEEN = true
  UNIT_HAS_NEARBY_UNITS = true

  test_algorithm_pattern_succeed("max_hp_enemy_creep", "creep2")
end

function test_max_hp_enemy_creep_no_unit_fails()
  test_RefreshBot()

  UNIT_CAN_BE_SEEN = true
  UNIT_HAS_NEARBY_UNITS = false

  test_algorithm_pattern_fails("max_hp_enemy_creep")
end

function test_last_hit_enemy_creep_succeed()
  test_RefreshBot()

  UNIT_CAN_BE_SEEN = true
  UNIT_HAS_NEARBY_UNITS = true

  test_algorithm_pattern_succeed("last_hit_enemy_creep", "creep1")
end

function test_last_hit_enemy_creep_no_unit_fails()
  test_RefreshBot()

  UNIT_CAN_BE_SEEN = true
  UNIT_HAS_NEARBY_UNITS = false

  test_algorithm_pattern_fails("last_hit_enemy_creep")
end

function test_max_hp_neutral_creep_succeed()
  test_RefreshBot()

  UNIT_CAN_BE_SEEN = true
  UNIT_HAS_NEARBY_UNITS = true

  test_algorithm_pattern_succeed("max_hp_neutral_creep", "neutral2")
end

function test_max_hp_neutral_creep_no_unit_fails()
  test_RefreshBot()

  UNIT_CAN_BE_SEEN = true
  UNIT_HAS_NEARBY_UNITS = false

  test_algorithm_pattern_fails("max_hp_neutral_creep")
end

function test_min_hp_enemy_building_succeed()
  test_RefreshBot()

  UNIT_CAN_BE_SEEN = true
  UNIT_HAS_NEARBY_UNITS = true

  test_algorithm_pattern_succeed("min_hp_enemy_building", "tower1")
end

function test_min_hp_enemy_building_no_unit_fails()
  test_RefreshBot()

  UNIT_CAN_BE_SEEN = true
  UNIT_HAS_NEARBY_UNITS = false

  test_algorithm_pattern_fails("min_hp_enemy_building")
end

function test_low_hp_enemy_hero_succeed()
  test_RefreshBot()

  UNIT_CAN_BE_SEEN = true
  UNIT_HAS_NEARBY_UNITS = true

  test_algorithm_pattern_succeed("low_hp_enemy_hero", "unit1")
end

function test_low_hp_enemy_hero_no_unit_fails()
  test_RefreshBot()

  UNIT_CAN_BE_SEEN = true
  UNIT_HAS_NEARBY_UNITS = false

  test_algorithm_pattern_fails("low_hp_enemy_hero")
end

function test_low_hp_enemy_building_succeed()
  test_RefreshBot()

  UNIT_CAN_BE_SEEN = true
  UNIT_HAS_NEARBY_TOWERS = true
  UNIT_HAS_NEARBY_UNITS = true

  test_algorithm_pattern_succeed("low_hp_enemy_building", "tower1")
end

function test_low_hp_enemy_building_no_unit_fails()
  test_RefreshBot()

  UNIT_CAN_BE_SEEN = true
  UNIT_HAS_NEARBY_TOWERS = true
  UNIT_HAS_NEARBY_UNITS = false

  test_algorithm_pattern_fails("low_hp_enemy_building")
end

function test_attacking_enemy_hero_succeed()
  test_RefreshBot()

  ATTACK_TARGET = GetBot()
  UNIT_HAS_NEARBY_UNITS = true
  UNIT_IS_HERO = true

  test_algorithm_pattern_succeed(
    "attacking_enemy_hero",
    "unit1")
end

function test_attacking_enemy_hero_no_heroes_fails()
  test_RefreshBot()

  ATTACK_TARGET = GetBot()
  UNIT_HAS_NEARBY_UNITS = false
  UNIT_IS_HERO = true

  test_algorithm_pattern_fails("attacking_enemy_hero")
end

function test_attacking_enemy_hero_not_attacking_fails()
  test_RefreshBot()

  ATTACK_TARGET = nil
  UNIT_HAS_NEARBY_UNITS = true
  UNIT_IS_HERO = true

  test_algorithm_pattern_fails("attacking_enemy_hero")
end

function test_attacking_enemy_creep_succeed()
  test_RefreshBot()

  ATTACK_TARGET = GetBot()
  UNIT_HAS_NEARBY_UNITS = true
  UNIT_IS_HERO = true

  test_algorithm_pattern_succeed(
    "attacking_enemy_creep",
    "creep1")
end

function test_attacking_enemy_creep_no_creeps_fails()
  test_RefreshBot()

  ATTACK_TARGET = GetBot()
  UNIT_HAS_NEARBY_UNITS = false
  UNIT_IS_HERO = true

  test_algorithm_pattern_fails("attacking_enemy_creep")
end

function test_attacking_enemy_creep_not_attacking_fails()
  test_RefreshBot()

  ATTACK_TARGET = nil
  UNIT_HAS_NEARBY_UNITS = true
  UNIT_IS_HERO = true

  test_algorithm_pattern_fails("attacking_enemy_creep")
end

function test_roshan_succeed()
  test_RefreshBot()

  UNIT_CAN_BE_SEEN = true
  UNIT_HAS_NEARBY_UNITS = true

  test_algorithm_pattern_succeed("roshan", "npc_dota_roshan")
end

function test_deny_ally_tower_succeed()
  test_RefreshBot()

  UNIT_CAN_BE_SEEN = true
  UNIT_HAS_NEARBY_UNITS = true
  UNIT_HAS_NEARBY_TOWERS = true

  test_algorithm_pattern_succeed("deny_ally_tower", "tower1")
end

os.exit(luaunit.LuaUnit.run())
