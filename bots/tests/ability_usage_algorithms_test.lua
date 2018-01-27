package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local ability_usage_algorithms = require("ability_usage_algorithms")
local functions = require("functions")
local constants = require("constants")
local luaunit = require('luaunit')

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

function test_min_hp_enemy_hero_to_kill_succeed()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT
  ABILITY_DAMAGE = 200

  local desire, target =
    ability_usage_algorithms.min_hp_enemy_hero_to_kill(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, true)
  luaunit.assertEquals(target, {10, 10})
end

function test_min_hp_enemy_hero_to_kill_not_enough_damage_fails()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT
  ABILITY_DAMAGE = 0

  local desire, target =
    ability_usage_algorithms.min_hp_enemy_hero_to_kill(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, false)
  luaunit.assertEquals(target, nil)
end

function test_channeling_enemy_hero()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  UNIT_IS_CHANNELING = true
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT

  local desire, target = ability_usage_algorithms.channeling_enemy_hero(
    GetBot(),
    ability)

  luaunit.assertEquals(desire, true)
  luaunit.assertEquals(target, {10, 10})
end

function test_attacked_enemy_hero()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_UNIT_TARGET
  UNIT_CAN_BE_SEEN = true
  UNIT_IS_HERO = true
  ATTACK_TARGET = Unit:new()

  local desire, target = ability_usage_algorithms.attacked_enemy_hero(
    GetBot(),
    ability)

  luaunit.assertEquals(desire, true)
  luaunit.assertEquals(
    target:GetUnitName(),
    "npc_dota_hero_crystal_maiden")
end

function test_attacked_enemy_hero_not_hero_fails()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_UNIT_TARGET
  UNIT_CAN_BE_SEEN = true
  UNIT_IS_HERO = false
  ATTACK_TARGET = Unit:new()

  local desire, target = ability_usage_algorithms.attacked_enemy_hero(
    GetBot(),
    ability)

  luaunit.assertEquals(desire, false)
  luaunit.assertEquals(target, nil)
end

function test_attacked_enemy_creep()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_UNIT_TARGET
  UNIT_CAN_BE_SEEN = true
  UNIT_IS_HERO = false
  ATTACK_TARGET = Unit:new()

  local desire, target = ability_usage_algorithms.attacked_enemy_creep(
    GetBot(),
    ability)

  luaunit.assertEquals(desire, true)
  luaunit.assertEquals(
    target:GetUnitName(),
    "npc_dota_hero_crystal_maiden")
end

function test_attacked_enemy_creep_not_creep_fails()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_UNIT_TARGET
  UNIT_CAN_BE_SEEN = true
  UNIT_IS_HERO = true
  ATTACK_TARGET = Unit:new()

  local desire, target = ability_usage_algorithms.attacked_enemy_creep(
    GetBot(),
    ability)

  luaunit.assertEquals(desire, false)
  luaunit.assertEquals(target, nil)
end

function test_attacked_enemy_building()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_UNIT_TARGET
  UNIT_CAN_BE_SEEN = true
  UNIT_IS_BUILDING = true
  ATTACK_TARGET = Unit:new()

  local desire, target = ability_usage_algorithms.attacked_enemy_building(
    GetBot(),
    ability)

  luaunit.assertEquals(desire, true)
  luaunit.assertEquals(
    target:GetUnitName(),
    "npc_dota_hero_crystal_maiden")
end

function test_attacked_enemy_building_not_building_fails()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_UNIT_TARGET
  UNIT_CAN_BE_SEEN = true
  UNIT_IS_BUILDING = false
  ATTACK_TARGET = Unit:new()

  local desire, target = ability_usage_algorithms.attacked_enemy_building(
    GetBot(),
    ability)

  luaunit.assertEquals(desire, false)
  luaunit.assertEquals(target, nil)
end

function test_three_and_more_enemy_heroes_aoe_succeed()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_freezing_field")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_NO_TARGET
  UNIT_CAN_BE_SEEN = true

  local desire, target =
    ability_usage_algorithms.three_and_more_enemy_heroes_aoe(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, true)
  luaunit.assertEquals(target, nil)
end

function test_three_and_more_enemy_heroes_aoe_not_targetable_fails()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_freezing_field")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_NO_TARGET
  UNIT_CAN_BE_SEEN = false

  local desire, target =
    ability_usage_algorithms.three_and_more_enemy_heroes_aoe(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, false)
  luaunit.assertEquals(target, nil)
end

function test_last_attacked_enemy_hero_succeed()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT
  UNIT_CAN_BE_SEEN = true

  local desire, target =
    ability_usage_algorithms.last_attacked_enemy_hero(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, true)
  luaunit.assertEquals(target, {10, 10})
end

function test_last_attacked_enemy_hero_not_targetable_fails()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT
  UNIT_CAN_BE_SEEN = false

  local desire, target =
    ability_usage_algorithms.last_attacked_enemy_hero(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, false)
  luaunit.assertEquals(target, nil)
end

function test_three_and_more_creeps_succeed()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT
  UNIT_CAN_BE_SEEN = true
  NEARBY_CREEPS_COUNT = 3

  local desire, target =
    ability_usage_algorithms.three_and_more_creeps(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, true)
  luaunit.assertEquals(target, {1.2, 3.4})
end

function test_three_and_more_creeps_not_targetable_fails()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT
  UNIT_CAN_BE_SEEN = false
  FIND_AOE_LOCATION_COUNT = 3

  local desire, target =
    ability_usage_algorithms.three_and_more_creeps(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, false)
  luaunit.assertEquals(target, nil)
end

function test_three_and_more_creeps_two_fails()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT
  UNIT_CAN_BE_SEEN = true
  FIND_AOE_LOCATION_COUNT = 2

  local desire, target =
    ability_usage_algorithms.three_and_more_creeps(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, false)
  luaunit.assertEquals(target, nil)
end

function test_three_and_more_enemy_heroes()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT
  FIND_AOE_LOCATION_COUNT = 3

  local desire, target =
    ability_usage_algorithms.three_and_more_enemy_heroes(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, true)
  luaunit.assertEquals(target, {1.2, 3.4})
end

function test_toggle_on_attack_enemy_hero()
  test_RefreshBot()

  local ability = Ability:new("drow_ranger_frost_arrows ")

  ABILITY_TOGGLE_STATE = false

  UNIT_IS_HERO = true

  local desire, target =
    ability_usage_algorithms.toggle_on_attack_enemy_hero(
      GetBot(),
      ability)

  luaunit.assertTrue(ABILITY_TOGGLE_STATE)

  UNIT_IS_HERO = false

  local desire, target =
    ability_usage_algorithms.toggle_on_attack_enemy_hero(
      GetBot(),
      ability)

  luaunit.assertFalse(ABILITY_TOGGLE_STATE)
end

function test_UseOnAttackEnemyUnit()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT

  ATTACK_TARGET = Unit:new()
  UNIT_IS_HERO = true

  local desire, target =
    ability_usage_algorithms.test_UseOnAttackEnemyUnit(
      GetBot(),
      ability,
      function(unit) return unit:IsHero() end,
      ability:GetAOERadius())

  luaunit.assertEquals(desire, true)
  luaunit.assertEquals(target, {10, 10})

  UNIT_IS_HERO = false

  local desire, target =
    ability_usage_algorithms.test_UseOnAttackEnemyUnit(
      GetBot(),
      ability,
      function(unit) return unit:IsHero() end,
      ability:GetAOERadius())

  luaunit.assertEquals(desire, false)
  luaunit.assertEquals(target, nil)
end

function test_use_on_attack_enemy_hero_aoe()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT

  UNIT_IS_HERO = true

  local desire, target =
    ability_usage_algorithms.use_on_attack_enemy_hero_aoe(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, true)
  luaunit.assertEquals(target, {10, 10})

  UNIT_IS_HERO = false

  local desire, target =
    ability_usage_algorithms.use_on_attack_enemy_hero_aoe(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, false)
  luaunit.assertEquals(target, nil)
end

function test_use_on_attack_enemy_hero_melee()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT

  UNIT_IS_HERO = true

  local desire, target =
    ability_usage_algorithms.use_on_attack_enemy_hero_melee(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, true)
  luaunit.assertEquals(target, {10, 10})

  UNIT_IS_HERO = false

  local desire, target =
    ability_usage_algorithms.use_on_attack_enemy_hero_melee(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, false)
  luaunit.assertEquals(target, nil)
end

function test_use_on_attack_enemy_hero_ranged()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT

  UNIT_IS_HERO = true

  local desire, target =
    ability_usage_algorithms.use_on_attack_enemy_hero_ranged(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, true)
  luaunit.assertEquals(target, {10, 10})

  UNIT_IS_HERO = false

  local desire, target =
    ability_usage_algorithms.use_on_attack_enemy_hero_ranged(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, false)
  luaunit.assertEquals(target, nil)
end

function test_use_on_attack_enemy_creep_aoe()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT

  UNIT_IS_HERO = false

  local desire, target =
    ability_usage_algorithms.use_on_attack_enemy_creep_aoe(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, true)
  luaunit.assertEquals(target, {10, 10})

  UNIT_IS_HERO = true

  local desire, target =
    ability_usage_algorithms.use_on_attack_enemy_creep_aoe(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, false)
  luaunit.assertEquals(target, nil)
end

function test_use_on_attack_enemy_creep_melee()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT

  UNIT_IS_HERO = false

  local desire, target =
    ability_usage_algorithms.use_on_attack_enemy_creep_melee(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, true)
  luaunit.assertEquals(target, {10, 10})

  UNIT_IS_HERO = true

  local desire, target =
    ability_usage_algorithms.use_on_attack_enemy_creep_melee(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, false)
  luaunit.assertEquals(target, nil)
end

function test_use_on_attack_enemy_with_mana_when_low_mp()
  test_RefreshBot()

  local bot = GetBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT

  local desire, target =
    ability_usage_algorithms.use_on_attack_enemy_with_mana_when_low_mp(
      bot,
      ability)

  luaunit.assertEquals(desire, false)
  luaunit.assertEquals(target, nil)

  bot.mana = bot.max_mana / 4

  local desire, target =
    ability_usage_algorithms.use_on_attack_enemy_with_mana_when_low_mp(
      bot,
      ability)

  luaunit.assertEquals(desire, true)
  luaunit.assertEquals(target, {10, 10})
end

function test_three_and_more_enemy_creeps_aoe()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_freezing_field")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_NO_TARGET

  local desire, target =
    ability_usage_algorithms.three_and_more_enemy_creeps_aoe(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, true)
  luaunit.assertEquals(target, nil)
end

function test_low_hp_self()
  test_RefreshBot()

  local bot = GetBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_UNIT_TARGET

  bot.health = 10

  local desire, target =
    ability_usage_algorithms.low_hp_self(
      bot,
      ability)

  luaunit.assertEquals(desire, true)
  luaunit.assertEquals(target:GetUnitName(), bot:GetUnitName())

  bot.health = bot.max_health

  local desire, target =
    ability_usage_algorithms.low_hp_self(
      bot,
      ability)

  luaunit.assertEquals(desire, false)
  luaunit.assertEquals(target, nil)
end

function test_low_hp_ally_hero()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_UNIT_TARGET

  local desire, target =
    ability_usage_algorithms.low_hp_ally_hero(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, true)
  luaunit.assertEquals(target:GetUnitName(), "unit1")
end

function test_low_hp_ally_creep()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_UNIT_TARGET

  local desire, target =
    ability_usage_algorithms.low_hp_ally_creep(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, true)
  luaunit.assertEquals(target:GetUnitName(), "creep1")
end

function test_three_and_more_ally_creeps_aoe_succeed()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_freezing_field")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_NO_TARGET

  local desire, target =
    ability_usage_algorithms.three_and_more_ally_creeps_aoe(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, true)
  luaunit.assertEquals(target, nil)
end

function test_three_and_more_ally_creeps_aoe_two_fails()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_freezing_field")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_NO_TARGET
  NEARBY_CREEPS_COUNT = 2

  local desire, target =
    ability_usage_algorithms.three_and_more_ally_creeps_aoe(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, false)
  luaunit.assertEquals(target, nil)
end

os.exit(luaunit.LuaUnit.run())
