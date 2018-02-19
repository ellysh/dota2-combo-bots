package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local algorithms = require("ability_usage_algorithms")
local functions = require("functions")
local constants = require("constants")
local luaunit = require('luaunit')

function test_IsTargetable()
  local unit = Unit:new()

  luaunit.assertTrue(algorithms.test_IsTargetable(unit))

  UNIT_CAN_BE_SEEN = false

  luaunit.assertFalse(algorithms.test_IsTargetable(unit))

  UNIT_CAN_BE_SEEN = true
  UNIT_IS_MAGIC_IMMUNE = true

  luaunit.assertFalse(algorithms.test_IsTargetable(unit))

  UNIT_IS_MAGIC_IMMUNE = false
  UNIT_IS_INVULNERABLE = true

  luaunit.assertFalse(algorithms.test_IsTargetable(unit))

  UNIT_IS_INVULNERABLE = false
  UNIT_IS_ILLUSION = true

  luaunit.assertFalse(algorithms.test_IsTargetable(unit))

  UNIT_IS_ILLUSION = false
end

function test_NumberOfTargetableUnits_succeed()
  local units = { Unit:new(), Unit:new(), Unit:new() }

  luaunit.assertEquals(
    algorithms.test_NumberOfTargetableUnits(units),
    3)
end

function test_NumberOfTargetableUnits_when_targets_immune_fails()
  local units = { Unit:new(), Unit:new(), Unit:new() }

  UNIT_IS_MAGIC_IMMUNE = true

  luaunit.assertEquals(
    algorithms.test_NumberOfTargetableUnits(units),
    0)
end

function test_IsEnoughDamageToKill_succeed()
  local unit = Unit:new()
  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_DAMAGE = 400

  luaunit.assertTrue(
    algorithms.test_IsEnoughDamageToKill(
      unit,
      ability))
end

function test_IsEnoughDamageToKill_fails()
  local unit = Unit:new()
  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_DAMAGE = 150

  luaunit.assertFalse(
    algorithms.test_IsEnoughDamageToKill(
      unit,
      ability))
end

function test_GetTarget_succeed()
  local unit = Unit:new()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_UNIT_TARGET

  luaunit.assertEquals(
    algorithms.test_GetTarget(unit, ability),
    unit)

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT

  luaunit.assertEquals(
    algorithms.test_GetTarget(unit, ability),
    unit:GetLocation())

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_NO_TARGET

  luaunit.assertEquals(
    algorithms.test_GetTarget(unit, ability),
    nil)
end

local function test_algorithm_pattern_succeed(algorithm, expect_target)
  local ability = Ability:new("crystal_maiden_crystal_nova")

  local desire, target = algorithms[algorithm](
    GetBot(),
    ability)

  luaunit.assertTrue(desire)
  luaunit.assertEquals(target, expect_target)
end

local function test_algorithm_pattern_fails(algorithm)
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  local desire, target = algorithms[algorithm](
    GetBot(),
    ability)

  luaunit.assertFalse(desire)
  luaunit.assertEquals(target, nil)
end

function test_min_hp_enemy_hero_to_kill_succeed()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT
  ABILITY_DAMAGE = 200
  UNIT_NO_NEARBY_UNITS = false

  test_algorithm_pattern_succeed("min_hp_enemy_hero_to_kill", {10, 10})
end

function test_min_hp_enemy_hero_to_kill_not_enough_damage_fails()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT
  ABILITY_DAMAGE = 0

  test_algorithm_pattern_fails("min_hp_enemy_hero_to_kill")
end

function test_channeling_enemy_hero_succeed()
  UNIT_IS_CHANNELING = true
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT
  UNIT_NO_NEARBY_UNITS = false

  test_algorithm_pattern_succeed("channeling_enemy_hero", {10, 10})
end

function test_channeling_enemy_hero_no_hero_fails()
  UNIT_IS_CHANNELING = true
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT
  UNIT_NO_NEARBY_UNITS = true

  test_algorithm_pattern_fails("channeling_enemy_hero")
end

function test_attacked_enemy_hero_succeed()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_UNIT_TARGET
  UNIT_CAN_BE_SEEN = true
  UNIT_IS_HERO = true
  ATTACK_TARGET = Unit:new()

  test_algorithm_pattern_succeed("attacked_enemy_hero", ATTACK_TARGET)
end

function test_attacked_enemy_hero_not_hero_fails()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_UNIT_TARGET
  UNIT_CAN_BE_SEEN = true
  UNIT_IS_HERO = false
  ATTACK_TARGET = Unit:new()

  test_algorithm_pattern_fails("attacked_enemy_hero")
end

function test_attacked_enemy_creep_succeed()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_UNIT_TARGET
  UNIT_CAN_BE_SEEN = true
  UNIT_IS_HERO = false
  ATTACK_TARGET = Unit:new()

  test_algorithm_pattern_succeed("attacked_enemy_creep", ATTACK_TARGET)
end

function test_attacked_enemy_creep_not_creep_fails()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_UNIT_TARGET
  UNIT_CAN_BE_SEEN = true
  UNIT_IS_HERO = true
  ATTACK_TARGET = Unit:new()

  test_algorithm_pattern_fails("attacked_enemy_creep")
end

function test_attacked_enemy_building_succeed()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_UNIT_TARGET
  UNIT_CAN_BE_SEEN = true
  UNIT_IS_BUILDING = true
  UNIT_IS_MAGIC_IMMUNE = false
  ATTACK_TARGET = Unit:new()

  test_algorithm_pattern_succeed("attacked_enemy_building", ATTACK_TARGET)
end

function test_attacked_enemy_building_not_building_fails()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_UNIT_TARGET
  UNIT_CAN_BE_SEEN = true
  UNIT_IS_BUILDING = false
  ATTACK_TARGET = Unit:new()

  test_algorithm_pattern_fails("attacked_enemy_building")
end

function test_three_and_more_enemy_heroes_aoe_succeed()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_NO_TARGET
  UNIT_CAN_BE_SEEN = true

  test_algorithm_pattern_succeed(
    "three_and_more_enemy_heroes_aoe",
    nil)
end

function test_three_and_more_enemy_heroes_aoe_not_targetable_fails()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_NO_TARGET
  UNIT_CAN_BE_SEEN = false

  test_algorithm_pattern_fails("three_and_more_enemy_heroes_aoe")
end

function test_last_attacked_enemy_hero_succeed()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT
  UNIT_CAN_BE_SEEN = true

  test_algorithm_pattern_succeed("last_attacked_enemy_hero", {10, 10})
end

function test_last_attacked_enemy_hero_not_targetable_fails()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT
  UNIT_CAN_BE_SEEN = false

  test_algorithm_pattern_fails("last_attacked_enemy_hero")
end

function test_three_and_more_enemy_creeps_succeed()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT
  UNIT_CAN_BE_SEEN = true
  NEARBY_CREEPS_COUNT = 3

  test_algorithm_pattern_succeed(
    "three_and_more_enemy_creeps",
    {1.2, 3.4})
end

function test_three_and_more_enemy_creeps_not_targetable_fails()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT
  UNIT_CAN_BE_SEEN = false
  FIND_AOE_LOCATION_COUNT = 3

  test_algorithm_pattern_fails("three_and_more_enemy_creeps")
end

function test_three_and_more_enemy_creeps_two_fails()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT
  UNIT_CAN_BE_SEEN = true
  FIND_AOE_LOCATION_COUNT = 2

  test_algorithm_pattern_fails("three_and_more_enemy_creeps")
end

function test_three_and_more_neutral_creeps_succeed()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT
  UNIT_CAN_BE_SEEN = true
  UNIT_IS_MAGIC_IMMUNE = false

  test_algorithm_pattern_succeed(
    "three_and_more_neutral_creeps",
    {1.2, 3.4})
end

function test_three_and_more_enemy_heroes_succeed()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT
  FIND_AOE_LOCATION_COUNT = 3
  UNIT_IS_MAGIC_IMMUNE = false

  test_algorithm_pattern_succeed(
    "three_and_more_enemy_heroes",
    {1.2, 3.4})
end

function test_three_and_more_enemy_heroes_when_targets_immune_fails()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT
  FIND_AOE_LOCATION_COUNT = 3
  UNIT_IS_MAGIC_IMMUNE = true

  test_algorithm_pattern_fails("three_and_more_enemy_heroes")
end

function test_three_and_more_enemy_heroes_when_hits_only_2_fails()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT
  FIND_AOE_LOCATION_COUNT = 2
  UNIT_IS_MAGIC_IMMUNE = false

  test_algorithm_pattern_fails("three_and_more_enemy_heroes")
end
local function test_toggle_on_attack_enemy_hero_pattern(expected_state)
  test_RefreshBot()

  local ability = Ability:new("drow_ranger_frost_arrows")

  local desire, target =
    algorithms.toggle_on_attack_enemy_hero(
      GetBot(),
      ability)

  luaunit.assertEquals(ABILITY_TOGGLE_STATE, expected_state)
end

function test_toggle_on_attack_enemy_hero_activate_succeed()
  ATTACK_TARGET = Unit:new()
  ABILITY_TOGGLE_STATE = false
  UNIT_IS_HERO = true

  test_toggle_on_attack_enemy_hero_pattern(true)
end

function test_toggle_on_attack_enemy_hero_deactivate_succeed()
  ATTACK_TARGET = Unit:new()
  ABILITY_TOGGLE_STATE = true
  UNIT_IS_HERO = false

  test_toggle_on_attack_enemy_hero_pattern(false)
end

function test_toggle_on_attack_enemy_hero_no_target_fails()
  ATTACK_TARGET = nil
  ABILITY_TOGGLE_STATE = false
  UNIT_IS_HERO = true

  test_toggle_on_attack_enemy_hero_pattern(false)
end

local function test_UseOnAttackEnemyUnit_pattern(
  expect_desire,
  expect_target)

  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT
  ATTACK_TARGET = Unit:new()

  local desire, target =
    algorithms.test_UseOnAttackEnemyUnit(
      GetBot(),
      ability,
      function(unit) return unit:IsHero() end,
      ability:GetAOERadius())

  luaunit.assertEquals(desire, expect_desire)
  luaunit.assertEquals(target, expect_target)
end

function test_UseOnAttackEnemyUnit_succeed()
  UNIT_IS_HERO = true

  test_UseOnAttackEnemyUnit_pattern(true, {10, 10})
end

function test_UseOnAttackEnemyUnit_fails()
  UNIT_IS_HERO = false

  test_UseOnAttackEnemyUnit_pattern(false, nil)
end

function test_use_on_attack_enemy_hero_aoe_succeed()
  ATTACK_TARGET = Unit:new()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT
  UNIT_IS_HERO = true

  test_algorithm_pattern_succeed("use_on_attack_enemy_hero_aoe", {10, 10})
end

function test_use_on_attack_enemy_hero_aoe_no_hero_fails()
  ATTACK_TARGET = Unit:new()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT
  UNIT_IS_HERO = false

  test_algorithm_pattern_fails("use_on_attack_enemy_hero_aoe")
end

function test_use_on_attack_enemy_hero_melee_succeed()
  ATTACK_TARGET = Unit:new()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT
  UNIT_IS_HERO = true

  test_algorithm_pattern_succeed(
    "use_on_attack_enemy_hero_melee",
    {10, 10})
end

function test_use_on_attack_enemy_hero_no_hero_fails()
  UNIT_IS_HERO = false

  test_algorithm_pattern_fails("use_on_attack_enemy_hero_melee")
end

function test_use_on_attack_enemy_hero_ranged_succeed()
  ATTACK_TARGET = Unit:new()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT
  UNIT_IS_HERO = true

  test_algorithm_pattern_succeed(
    "use_on_attack_enemy_hero_ranged",
    {10, 10})
end

function test_use_on_attack_enemy_hero_ranged_no_hero_fails()
  UNIT_IS_HERO = false

  test_algorithm_pattern_fails("use_on_attack_enemy_hero_ranged")
end

function test_use_on_attack_enemy_creep_aoe_succeed()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT
  ATTACK_TARGET = Unit:new()
  UNIT_IS_HERO = false
  UNIT_EXTRAPOLATED_LOCATION = {10, 10}

  test_algorithm_pattern_succeed(
    "use_on_attack_enemy_creep_aoe",
    {10, 10})
end

function test_use_on_attack_enemy_creep_aoe_no_creep_fails()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT
  ATTACK_TARGET = Unit:new()
  UNIT_IS_HERO = true

  test_algorithm_pattern_fails("use_on_attack_enemy_creep_aoe")
end

function test_use_on_attack_enemy_creep_melee_succeed()
  ATTACK_TARGET = Unit:new()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT
  UNIT_IS_HERO = false

  test_algorithm_pattern_succeed(
    "use_on_attack_enemy_creep_melee",
    {10, 10})
end

function test_use_on_attack_enemy_creep_melee_no_creep_fails()
  ATTACK_TARGET = Unit:new()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT
  UNIT_IS_HERO = true

  test_algorithm_pattern_fails("use_on_attack_enemy_creep_melee")
end

function test_use_on_attack_enemy_with_mana_when_low_mp_succeed()
  ATTACK_TARGET = Unit:new()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT

  local bot = GetBot()
  bot.mana = bot.max_mana / 4

  test_algorithm_pattern_succeed(
    "use_on_attack_enemy_with_mana_when_low_mp",
    {10, 10})
end

function test_use_on_attack_enemy_with_mana_when_low_mp_high_mp_fails()
  ATTACK_TARGET = Unit:new()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT

  test_algorithm_pattern_fails(
    "use_on_attack_enemy_with_mana_when_low_mp")
end

function test_three_and_more_enemy_creeps_aoe_succeed()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_NO_TARGET
  NEARBY_CREEPS_COUNT = 3

  test_algorithm_pattern_succeed("three_and_more_enemy_creeps_aoe", nil)
end

function test_three_and_more_neutral_creeps_aoe_succeed()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_NO_TARGET
  NEARBY_CREEPS_COUNT = 3
  UNIT_IS_MAGIC_IMMUNE = false

  test_algorithm_pattern_succeed("three_and_more_neutral_creeps_aoe", nil)
end

function test_low_hp_self_succeed()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_UNIT_TARGET

  local bot = GetBot()
  bot.health = 10

  test_algorithm_pattern_succeed("low_hp_self", bot)
end

function test_low_hp_self_full_hp_fails()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_UNIT_TARGET

  local bot = GetBot()
  bot.health = bot.max_health

  test_algorithm_pattern_fails("low_hp_self")
end

local function test_algorithm_unit_pattern_succeed(
  algorithm,
  expect_target)

  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  -- TODO: Rename the "algorithms" variable to "algorithms"
  local desire, target = algorithms[algorithm](
    GetBot(),
    ability)

  luaunit.assertTrue(desire)
  luaunit.assertEquals(target:GetUnitName(), expect_target)
end

function test_low_hp_ally_hero_succeed()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_UNIT_TARGET
  UNIT_NO_NEARBY_UNITS = false

  test_algorithm_unit_pattern_succeed(
    "low_hp_ally_hero",
    "unit1")
end

function test_low_hp_ally_hero_no_unit_fails()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_UNIT_TARGET
  UNIT_NO_NEARBY_UNITS = true

  test_algorithm_pattern_fails("low_hp_ally_hero")
end

function test_low_hp_ally_creep_succeed()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_UNIT_TARGET

  test_algorithm_unit_pattern_succeed(
    "low_hp_ally_creep",
    "creep1")
end

function test_three_and_more_ally_creeps_aoe_succeed()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_NO_TARGET

  test_algorithm_pattern_succeed("three_and_more_ally_creeps_aoe", nil)
end

function test_three_and_more_ally_creeps_aoe_two_fails()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_NO_TARGET
  NEARBY_CREEPS_COUNT = 2

  test_algorithm_pattern_fails("three_and_more_ally_creeps_aoe")
end

function test_IsDisabled_succeed()
  local unit = Unit:new()

  UNIT_IS_STUNNED = true
  luaunit.assertTrue(algorithms.test_IsDisabled(unit))

  UNIT_IS_STUNNED = false
  UNIT_IS_HEXED = true
  luaunit.assertTrue(algorithms.test_IsDisabled(unit))

  UNIT_IS_HEXED = false
  UNIT_IS_ROOTED = true
  luaunit.assertTrue(algorithms.test_IsDisabled(unit))

  UNIT_IS_ROOTED = false
  UNIT_IS_SILENCED = true
  luaunit.assertTrue(algorithms.test_IsDisabled(unit))

  UNIT_IS_SILENCED = false
  UNIT_IS_NIGHTMARED = true
  luaunit.assertTrue(algorithms.test_IsDisabled(unit))

  UNIT_IS_NIGHTMARED = false
  UNIT_IS_DISARMED = true
  luaunit.assertTrue(algorithms.test_IsDisabled(unit))

  UNIT_IS_DISARMED = false
  UNIT_IS_BLIND = true
  luaunit.assertTrue(algorithms.test_IsDisabled(unit))

  UNIT_IS_BLIND = false
  UNIT_IS_MUTED = true
  luaunit.assertTrue(algorithms.test_IsDisabled(unit))
end

function test_IsDisabled_fails()
  local unit = Unit:new()

  UNIT_IS_MUTED = false
  luaunit.assertFalse(algorithms.test_IsDisabled(unit))
end

function test_attacked_not_disabled_enemy_hero_succeed()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_UNIT_TARGET
  UNIT_CAN_BE_SEEN = true
  UNIT_IS_HERO = true
  UNIT_IS_MUTED = false
  UNIT_IS_STUNNED = false
  ATTACK_TARGET = Unit:new()

  test_algorithm_pattern_succeed(
    "attacked_not_disabled_enemy_hero",
    ATTACK_TARGET)
end

function test_attacked_not_disabled_enemy_hero_fails()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_UNIT_TARGET
  UNIT_CAN_BE_SEEN = true
  UNIT_IS_HERO = true
  UNIT_IS_STUNNED = true
  ATTACK_TARGET = Unit:new()

  test_algorithm_pattern_fails("attacked_not_disabled_enemy_hero")
end

function test_last_hit_enemy_creep_succeed()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_UNIT_TARGET
  UNIT_CAN_BE_SEEN = true

  test_algorithm_unit_pattern_succeed(
    "last_hit_enemy_creep",
    "creep1")
end

function test_always_self_succeed()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_NO_TARGET

  test_algorithm_pattern_succeed("always_self", nil)
end

os.exit(luaunit.LuaUnit.run())
