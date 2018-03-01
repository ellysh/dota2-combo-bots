package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local algorithms = require("common_algorithms")
local constants = require("constants")
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

function test_GetMaxKillsPlayer_succeed()
  IS_HERO_ALIVE = true

  luaunit.assertEquals(
    algorithms.GetMaxKillsPlayer(
      GetOpposingTeam(),
      function(p) return IsHeroAlive(p) end),
    1)
end

function test_GetMaxKillsPlayer_hero_dead_fails()
  IS_HERO_ALIVE = false

  luaunit.assertEquals(
    algorithms.GetMaxKillsPlayer(
      GetOpposingTeam(),
      function(p) return IsHeroAlive(p) end),
    nil)
end

function test_GetNormalizedRadius_succeed()
  luaunit.assertEquals(
    algorithms.test_GetNormalizedRadius(1200),
    1200)

  luaunit.assertEquals(
    algorithms.test_GetNormalizedRadius(0),
    constants.DEFAULT_ABILITY_USAGE_RADIUS)

  luaunit.assertEquals(
    algorithms.test_GetNormalizedRadius(nil),
    constants.DEFAULT_ABILITY_USAGE_RADIUS)

  luaunit.assertEquals(
    algorithms.test_GetNormalizedRadius(2000),
    constants.MAX_ABILITY_USAGE_RADIUS)
end

function test_GetEnemyHeroes_succeed()
  test_RefreshBot()

  local units = algorithms.GetEnemyHeroes(
    GetBot(),
    1200)

  luaunit.assertEquals(units[1]:GetUnitName(), "unit1")
  luaunit.assertEquals(units[2]:GetUnitName(), "unit2")
  luaunit.assertEquals(units[3]:GetUnitName(), "unit3")
end

function test_GetAllyHeroes_succeed()
  test_RefreshBot()

  local bot = GetBot()
  local units = algorithms.GetAllyHeroes(
    bot,
    1200)

  luaunit.assertEquals(units[1]:GetUnitName(), bot:GetUnitName())
  luaunit.assertEquals(units[2]:GetUnitName(), "unit1")
  luaunit.assertEquals(units[3]:GetUnitName(), "unit2")
  luaunit.assertEquals(units[4]:GetUnitName(), "unit3")
end

function test_GetEnemyCreeps_succeed()
  test_RefreshBot()

  UNIT_HAS_NEARBY_UNITS = true

  local units = algorithms.GetEnemyCreeps(
    GetBot(),
    1200)

  luaunit.assertEquals(units[1]:GetUnitName(), "creep1")
  luaunit.assertEquals(units[2]:GetUnitName(), "creep2")
  luaunit.assertEquals(units[3]:GetUnitName(), "creep3")
  luaunit.assertEquals(units[4], nil)
end

function test_GetEnemyCreeps_no_enemy_fails()
  test_RefreshBot()

  UNIT_HAS_NEARBY_UNITS = false

  local units = algorithms.GetEnemyCreeps(
    GetBot(),
    1200)

  luaunit.assertEquals(units, {})
end

function test_GetAllyCreeps_succeed()
  test_RefreshBot()

  local units = algorithms.GetAllyCreeps(
    GetBot(),
    1200)

  luaunit.assertEquals(units[1]:GetUnitName(), "creep1")
  luaunit.assertEquals(units[2]:GetUnitName(), "creep2")
  luaunit.assertEquals(units[3]:GetUnitName(), "creep3")
end

function test_GetEnemyBuildings_succeed()
  test_RefreshBot()

  UNIT_HAS_NEARBY_TOWERS = true

  local units = algorithms.GetEnemyBuildings(
    GetBot(),
    1200)

  luaunit.assertEquals(units[1]:GetUnitName(), "tower1")
  luaunit.assertEquals(units[2]:GetUnitName(), "tower2")
  luaunit.assertEquals(units[3]:GetUnitName(), "tower3")

  UNIT_HAS_NEARBY_TOWERS = false

  units = algorithms.GetEnemyBuildings(
    GetBot(),
    1200)

  luaunit.assertEquals(units[1]:GetUnitName(), "barrak1")
  luaunit.assertEquals(units[2]:GetUnitName(), "barrak2")
end

function test_IsEnemyOnTheWay_succeed()
  test_RefreshBot()

  local bot = GetBot()
  bot.location = {10, 10}

  UNIT_HAS_NEARBY_UNITS = true

  luaunit.assertTrue(algorithms.IsEnemyHeroOnTheWay(bot, {100, 100}))
end

function test_IsEnemyOnTheWay_no_enemy_fails()
  test_RefreshBot()

  local bot = GetBot()
  bot.location = {95, 84}

  UNIT_HAS_NEARBY_UNITS = true

  luaunit.assertFalse(algorithms.IsEnemyHeroOnTheWay(bot, {100, 100}))
end

function test_GetLastPlayerLocation_succeed()
  IS_HERO_ALIVE = true
  HERO_LAST_SEEN_INFO = { {location = {10, 10}, time_since_seen = 2} }

  luaunit.assertEquals(algorithms.GetLastPlayerLocation(1), {10, 10})
end

function test_GetLastPlayerLocation_no_player_fails()
  IS_HERO_ALIVE = true
  HERO_LAST_SEEN_INFO = { {location = {10, 10}, time_since_seen = 2} }

  luaunit.assertEquals(algorithms.GetLastPlayerLocation(nil), nil)
end

function test_GetLastPlayerLocation_no_last_seen_info_fails()
  IS_HERO_ALIVE = true
  HERO_LAST_SEEN_INFO = nil

  luaunit.assertEquals(algorithms.GetLastPlayerLocation(1), nil)
end

function test_GetUnitHealthLevel_succeed()
  test_RefreshBot()

  local bot = GetBot()

  luaunit.assertEquals(
    algorithms.test_GetUnitHealthLevel(bot),
    1.0)

  bot.health = bot.max_health / 2

  luaunit.assertEquals(
    algorithms.test_GetUnitHealthLevel(bot),
    0.5)

  bot.health = bot.max_health / 3

  luaunit.assertAlmostEquals(
    algorithms.test_GetUnitHealthLevel(bot),
    0.333,
    0.001)
end

function test_GetUnitManaLevel_succeed()
  test_RefreshBot()

  local bot = GetBot()

  luaunit.assertEquals(
    algorithms.test_GetUnitManaLevel(bot),
    1.0)

  bot.mana = bot.max_mana / 2

  luaunit.assertEquals(
    algorithms.test_GetUnitManaLevel(bot),
    0.5)

  bot.mana = bot.max_mana / 3

  luaunit.assertAlmostEquals(
    algorithms.test_GetUnitManaLevel(bot),
    0.333,
    0.001)
end

function test_IsUnitLowHp_succeed()
  test_RefreshBot()

  local bot = GetBot()
  bot.health = 10

  luaunit.assertTrue(algorithms.IsUnitLowHp(bot))
end

function test_IsUnitLowHp_full_hp_fails()
  test_RefreshBot()

  local bot = GetBot()
  bot.health = bot.max_health

  luaunit.assertFalse(algorithms.IsUnitLowHp(bot))
end

function test_IsUnitHalfHp_succeed()
  test_RefreshBot()

  local bot = GetBot()
  bot.health = (bot.max_health / 2) - 1

  luaunit.assertTrue(algorithms.IsUnitHalfHp(bot))
end

function test_IsUnitHalfHp_full_hp_fails()
  test_RefreshBot()

  local bot = GetBot()
  bot.health = bot.max_health

  luaunit.assertFalse(algorithms.IsUnitHalfHp(bot))
end

function test_GetBuilding_tower_succeed()
  local unit = algorithms.test_GetBuilding(
      TOWER_TOP_1,
      "TYPE_TOWER")

  luaunit.assertEquals(unit:GetUnitName(), "tower0")

  unit = algorithms.test_GetBuilding(
      TOWER_BOT_1,
      "TYPE_TOWER")

  luaunit.assertEquals(unit:GetUnitName(), "tower6")

  unit = algorithms.test_GetBuilding(
      TOWER_MID_1,
      "TYPE_TOWER")

  luaunit.assertEquals(unit:GetUnitName(), "tower3")
end

function test_GetBuilding_barracks_succeed()
  local unit = algorithms.test_GetBuilding(
      BARRACKS_TOP_MELEE,
      "TYPE_BARRACKS")

  luaunit.assertEquals(unit:GetUnitName(), "barrack0")

  unit = algorithms.test_GetBuilding(
      BARRACKS_BOT_MELEE,
      "TYPE_BARRACKS")

  luaunit.assertEquals(unit:GetUnitName(), "barrack4")

  unit = algorithms.test_GetBuilding(
      BARRACKS_MID_MELEE,
      "TYPE_BARRACKS")

  luaunit.assertEquals(unit:GetUnitName(), "barrack2")
end

function test_GetBuilding_ancient_succeed()
  local unit = algorithms.test_GetBuilding(
      nil,
      "TYPE_ANCIENT")

  luaunit.assertEquals(unit:GetUnitName(), "ancient")
end

function test_GetNearestFrontBuilding_succeed()
  local unit = algorithms.GetNearestFrontBuilding(LANE_TOP)

  luaunit.assertEquals(unit:GetUnitName(), "tower2")

  local unit = algorithms.GetNearestFrontBuilding(LANE_BOT)

  luaunit.assertEquals(unit:GetUnitName(), "tower8")

  local unit = algorithms.GetNearestFrontBuilding(LANE_MID)

  luaunit.assertEquals(unit:GetUnitName(), "tower10")
end

function test_GetTotalDamage_succeed()
  local units = { Unit:new(), Unit:new() }
  local target = Unit:new()

  ATTACK_TARGET = target

  luaunit.assertEquals(algorithms.GetTotalDamage(units, target), 200)
end

function test_GetTotalDamage_no_attacking_units_fails()
  local target = Unit:new()

  ATTACK_TARGET = target

  luaunit.assertEquals(algorithms.GetTotalDamage({}, target), 0)
  luaunit.assertEquals(algorithms.GetTotalDamage(nil, target), 0)
end

function test_GetTotalDamage_no_target_fails()
  local units = { Unit:new(), Unit:new() }

  ATTACK_TARGET = nil

  luaunit.assertEquals(algorithms.GetTotalDamage(units, nil), 0)
end

function test_CompareMaxHealth_succeed()
  local unit1 = Unit:new()
  local unit2 = Unit:new()
  unit2.max_health = 10

  local table = {unit1, unit2}

  luaunit.assertTrue(algorithms.CompareMaxHealth(table, 1, 2))
end

function test_CompareMinHealth_succeed()
  local unit1 = Unit:new()
  unit1.health = 10

  local unit2 = Unit:new()
  local table = {unit1, unit2}

  luaunit.assertTrue(algorithms.CompareMinHealth(table, 1, 2))
end

function test_CompareMaxHeroKills_equals_fails()
  local unit1 = Unit:new()
  local unit2 = Unit:new()
  local table = {unit1, unit2}

  luaunit.assertFalse(algorithms.CompareMaxHeroKills(table, 1, 2))
end

function test_GetNeutralCreeps_succeed()
  test_RefreshBot()

  UNIT_HAS_NEARBY_UNITS = true
  local units = algorithms.GetNeutralCreeps(GetBot(), 1600)

  luaunit.assertEquals(units[1]:GetUnitName(), "neutral1")
  luaunit.assertEquals(units[2]:GetUnitName(), "neutral2")
  luaunit.assertEquals(units[3]:GetUnitName(), "npc_dota_roshan")
end

function test_GetGroupHeroes_succeed()
  test_RefreshBot()

  local bot = GetBot()
  local units = algorithms.GetGroupHeroes(bot)

  luaunit.assertEquals(units[1]:GetUnitName(), bot:GetUnitName())
  luaunit.assertEquals(units[2]:GetUnitName(), "unit1")
  luaunit.assertEquals(units[3]:GetUnitName(), "unit2")
  luaunit.assertEquals(units[4]:GetUnitName(), "unit3")
end

function test_GetSumParameter_succeed()
  local units = {Unit:new(), Unit:new()}

  luaunit.assertEquals(
    algorithms.test_GetSumParameter(units, units[1].GetHealth),
    800)
end

function test_GetSumParameter_empty_list_fails()
  local unit = Unit:new()

  luaunit.assertEquals(
    algorithms.test_GetSumParameter(nil, unit.GetHealth),
    0)

  luaunit.assertEquals(
    algorithms.test_GetSumParameter({}, unit.GetHealth),
    0)
end

function test_IsWeakerTargetImpl_succeed()
  local unit_health = 200
  local unit_damage = 50
  local target_health = 180
  local target_damage = 40

  luaunit.assertTrue(
    algorithms.test_IsWeakerTargetImpl(
      unit_health,
      unit_damage,
      target_health,
      target_damage))
end

function test_IsWeakerTargetImpl_fails()
  local unit_health = 180
  local unit_damage = 40
  local target_health = 200
  local target_damage = 50

  luaunit.assertFalse(
    algorithms.test_IsWeakerTargetImpl(
      unit_health,
      unit_damage,
      target_health,
      target_damage))
end

function test_IsWeakerGroup_succeed()
  local units = { Unit:new(), Unit:new() }
  local target_group = { Unit:new() }

  luaunit.assertTrue(
    algorithms.IsWeakerGroup(units, target_group))
end

function test_IsWeakerGroup_fails()
  local units = { Unit:new() }
  local target_group = { Unit:new(), Unit:new() }

  luaunit.assertFalse(
    algorithms.IsWeakerGroup(units, target_group))
end

function test_IsWeakerTarget_succeed()
  local units = { Unit:new(), Unit:new() }

  local target_health = 180
  local target_damage = 40

  luaunit.assertTrue(
    algorithms.IsWeakerTarget(
      units,
      target_health,
      target_damage))
end

function test_IsWeakerTarget_when_target_strong_fails()
  local units = { Unit:new(), Unit:new() }

  local target_health = 5500
  local target_damage = 65

  luaunit.assertFalse(
    algorithms.IsWeakerTarget(
      units,
      target_health,
      target_damage))
end

function test_IsWeakerTarget_when_empty_units_fails()
  local units = {}

  local target_health = 180
  local target_damage = 40

  luaunit.assertFalse(
    algorithms.IsWeakerTarget(
      units,
      target_health,
      target_damage))
end

os.exit(luaunit.LuaUnit.run())
