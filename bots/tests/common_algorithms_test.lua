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

  local units = algorithms.GetAllyHeroes(
    GetBot(),
    1200)

  luaunit.assertEquals(units[1]:GetUnitName(), "unit1")
  luaunit.assertEquals(units[2]:GetUnitName(), "unit2")
  luaunit.assertEquals(units[3]:GetUnitName(), "unit3")
end

function test_GetEnemyCreeps_succeed()
  test_RefreshBot()

  local units = algorithms.GetEnemyCreeps(
    GetBot(),
    1200)

  luaunit.assertEquals(units[1]:GetUnitName(), "creep1")
  luaunit.assertEquals(units[2]:GetUnitName(), "creep2")
  luaunit.assertEquals(units[3]:GetUnitName(), "creep3")
  luaunit.assertEquals(units[4], nil)
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

  UNIT_IS_NEARBY_TOWERS = true

  local units = algorithms.GetEnemyBuildings(
    GetBot(),
    1200)

  luaunit.assertEquals(units[1]:GetUnitName(), "tower1")
  luaunit.assertEquals(units[2]:GetUnitName(), "tower2")
  luaunit.assertEquals(units[3]:GetUnitName(), "tower3")

  UNIT_IS_NEARBY_TOWERS = false

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

  UNIT_NO_NEARBY_UNITS = false

  luaunit.assertTrue(algorithms.IsEnemyHeroOnTheWay(bot, {100, 100}))
end

function test_IsEnemyOnTheWay_no_enemy_fails()
  test_RefreshBot()

  local bot = GetBot()
  bot.location = {95, 84}

  UNIT_NO_NEARBY_UNITS = false

  luaunit.assertFalse(algorithms.IsEnemyHeroOnTheWay(bot, {100, 100}))
end

function test_GetLastPlayerLocation_succeed()
  IS_HERO_ALIVE = true
  HERO_LAST_SEEN_INFO = { {location = {10, 10}, time_since_seen = 2} }

  luaunit.assertEquals(algorithms.GetLastPlayerLocation(1), {10, 10})
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

os.exit(luaunit.LuaUnit.run())
