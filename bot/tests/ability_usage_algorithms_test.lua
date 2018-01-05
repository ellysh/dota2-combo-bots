package.path = package.path .. ";../utility/?.lua"

require("global_functions")

local ability_usage_algorithms = require("ability_usage_algorithms")
local constants = require("constants")
local luaunit = require('luaunit')

function test_SetDefaultRadius()
  luaunit.assertEquals(
    ability_usage_algorithms.test_SetDefaultRadius(1200),
    1200)

  luaunit.assertEquals(
    ability_usage_algorithms.test_SetDefaultRadius(0),
    constants.DEFAULT_ABILITY_USAGE_RADIUS)

  luaunit.assertEquals(
    ability_usage_algorithms.test_SetDefaultRadius(nil),
    constants.DEFAULT_ABILITY_USAGE_RADIUS)

  luaunit.assertEquals(
    ability_usage_algorithms.test_SetDefaultRadius(2000),
    constants.MAX_ABILITY_USAGE_RADIUS)
end

function test_GetEnemyHeroes()
  test_RefreshBot()

  local units = ability_usage_algorithms.test_GetEnemyHeroes(
    GetBot(),
    1200)

  luaunit.assertEquals(units[1]:GetUnitName(), "unit1")
  luaunit.assertEquals(units[2]:GetUnitName(), "unit2")
  luaunit.assertEquals(units[3]:GetUnitName(), "unit3")
end

function test_GetAllyHeroes()
  test_RefreshBot()

  local units = ability_usage_algorithms.test_GetEnemyHeroes(
    GetBot(),
    1200)

  luaunit.assertEquals(units[1]:GetUnitName(), "unit1")
  luaunit.assertEquals(units[2]:GetUnitName(), "unit2")
  luaunit.assertEquals(units[3]:GetUnitName(), "unit3")
end

function test_GetEnemyCreeps()
  test_RefreshBot()

  local units = ability_usage_algorithms.test_GetEnemyCreeps(
    GetBot(),
    1200)

  luaunit.assertEquals(units[1]:GetUnitName(), "creep1")
  luaunit.assertEquals(units[2]:GetUnitName(), "creep2")
  luaunit.assertEquals(units[3]:GetUnitName(), "creep3")
end

function test_GetAllyCreeps()
  test_RefreshBot()

  local units = ability_usage_algorithms.test_GetEnemyCreeps(
    GetBot(),
    1200)

  luaunit.assertEquals(units[1]:GetUnitName(), "creep1")
  luaunit.assertEquals(units[2]:GetUnitName(), "creep2")
  luaunit.assertEquals(units[3]:GetUnitName(), "creep3")
end

function test_GetEnemyBuildings()
  test_RefreshBot()

  BOT_IS_NEARBY_TOWERS = true

  local units = ability_usage_algorithms.test_GetEnemyBuildings(
    GetBot(),
    1200)

  luaunit.assertEquals(units[1]:GetUnitName(), "tower1")
  luaunit.assertEquals(units[2]:GetUnitName(), "tower2")
  luaunit.assertEquals(units[3]:GetUnitName(), "tower3")

  BOT_IS_NEARBY_TOWERS = false

  units = ability_usage_algorithms.test_GetEnemyBuildings(
    GetBot(),
    1200)

  luaunit.assertEquals(units[1]:GetUnitName(), "barrak1")
  luaunit.assertEquals(units[2]:GetUnitName(), "barrak2")
end

function test_GetUnitHealth()
  test_RefreshBot()

  luaunit.assertEquals(
    ability_usage_algorithms.test_GetUnitHealth(GetBot()),
    200)
end

function test_GetUnitWith()
  test_RefreshBot()

  local unit = ability_usage_algorithms.test_GetUnitWith(
    ability_usage_algorithms.test_MIN,
    ability_usage_algorithms.test_GetUnitHealth,
    GetBot():GetNearbyHeroes(1200, true, BOT_MODE_NONE))

  luaunit.assertEquals(unit:GetUnitName(), "unit1")
  luaunit.assertEquals(unit:GetHealth(), 10)
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

function test_min_hp_enemy_hero_to_kill()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT
  ABILITY_DAMAGE = 200

  local desire, target =
    ability_usage_algorithms.min_hp_enemy_hero_to_kill(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, BOT_MODE_DESIRE_VERYHIGH)
  luaunit.assertEquals(target, {10, 10})
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
  luaunit.assertEquals(target, {10, 10})
end

function test_max_kills_enemy_hero()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT

  local desire, target = ability_usage_algorithms.max_kills_enemy_hero(
    GetBot(),
    ability)

  luaunit.assertEquals(desire, BOT_MODE_DESIRE_HIGH)
  luaunit.assertEquals(target, {10, 10})
end

function test_three_and_more_enemy_heroes_aoe()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_freezing_field")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_NO_TARGET

  local desire, target =
    ability_usage_algorithms.three_and_more_enemy_heroes_aoe(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, BOT_MODE_DESIRE_HIGH)
  luaunit.assertEquals(target, nil)
end

function test_GetLastAttackedEnemyHero()
  test_RefreshBot()

  local unit =
    ability_usage_algorithms.test_GetLastAttackedEnemyHero(
      GetBot(),
      1200)

  luaunit.assertEquals(unit:GetUnitName(), "unit1")
end

function test_last_attacked_enemy_hero()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT

  local desire, target =
    ability_usage_algorithms.last_attacked_enemy_hero(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, BOT_MODE_DESIRE_HIGH)
  luaunit.assertEquals(target, {10, 10})
end

function test_three_and_more_creeps()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT

  local desire, target =
    ability_usage_algorithms.three_and_more_creeps(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, BOT_MODE_DESIRE_LOW)
  luaunit.assertEquals(target, {1.2, 3.4})
end

function test_max_hp_creep()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT

  local desire, target =
    ability_usage_algorithms.max_hp_creep(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, BOT_MODE_DESIRE_LOW)
  luaunit.assertEquals(target, {20, 20})
end

function test_three_and_more_enemy_heroes()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT

  local desire, target =
    ability_usage_algorithms.three_and_more_enemy_heroes(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, BOT_MODE_DESIRE_HIGH)
  luaunit.assertEquals(target, {1.2, 3.4})
end

function test_toggle_on_attack_enemy_hero()
  test_RefreshBot()

  local ability = Ability:new("drow_ranger_frost_arrows ")

  ABILITY_TOGGLE_STATE = false

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

function test_max_estimated_damage_enemy_hero()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT

  local desire, target =
    ability_usage_algorithms.max_estimated_damage_enemy_hero(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, BOT_MODE_DESIRE_HIGH)
  luaunit.assertEquals(target, {20, 20})
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

  luaunit.assertEquals(desire, BOT_MODE_DESIRE_HIGH)
  luaunit.assertEquals(target, {10, 10})

  UNIT_IS_HERO = false

  local desire, target =
    ability_usage_algorithms.use_on_attack_enemy_hero_aoe(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, BOT_MODE_DESIRE_NONE)
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

  luaunit.assertEquals(desire, BOT_MODE_DESIRE_HIGH)
  luaunit.assertEquals(target, {10, 10})

  UNIT_IS_HERO = false

  local desire, target =
    ability_usage_algorithms.use_on_attack_enemy_hero_melee(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, BOT_MODE_DESIRE_NONE)
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

  luaunit.assertEquals(desire, BOT_MODE_DESIRE_HIGH)
  luaunit.assertEquals(target, {10, 10})

  UNIT_IS_HERO = true

  local desire, target =
    ability_usage_algorithms.use_on_attack_enemy_creep_aoe(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, BOT_MODE_DESIRE_NONE)
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

  luaunit.assertEquals(desire, BOT_MODE_DESIRE_HIGH)
  luaunit.assertEquals(target, {10, 10})

  UNIT_IS_HERO = true

  local desire, target =
    ability_usage_algorithms.use_on_attack_enemy_creep_melee(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, BOT_MODE_DESIRE_NONE)
  luaunit.assertEquals(target, nil)
end

function test_three_and_more_enemy_creeps_aoe()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_freezing_field")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_NO_TARGET

  local desire, target =
    ability_usage_algorithms.three_and_more_enemy_creeps_aoe(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, BOT_MODE_DESIRE_HIGH)
  luaunit.assertEquals(target, nil)
end

function test_low_hp_self()
  test_RefreshBot()

  local npc_bot = GetBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_UNIT_TARGET

  npc_bot.health = 10

  local desire, target =
    ability_usage_algorithms.low_hp_self(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, BOT_MODE_DESIRE_HIGH)
  luaunit.assertEquals(target:GetUnitName(), npc_bot:GetUnitName())

  npc_bot.health = npc_bot.max_health

  local desire, target =
    ability_usage_algorithms.low_hp_self(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, BOT_MODE_DESIRE_NONE)
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

  luaunit.assertEquals(desire, BOT_MODE_DESIRE_HIGH)
  luaunit.assertEquals(target:GetUnitName(), "unit1")
end

function test_three_and_more_ally_creeps_aoe()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_freezing_field")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_NO_TARGET

  local desire, target =
    ability_usage_algorithms.three_and_more_ally_creeps_aoe(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, BOT_MODE_DESIRE_HIGH)
  luaunit.assertEquals(target, nil)
end

function test_min_hp_enemy_building()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_UNIT_TARGET

  BOT_IS_NEARBY_TOWERS = true

  local desire, target =
    ability_usage_algorithms.min_hp_enemy_building(
      GetBot(),
      ability)

  luaunit.assertEquals(desire, BOT_MODE_DESIRE_HIGH)
  luaunit.assertEquals(target:GetUnitName(), "tower1")
  luaunit.assertEquals(target:GetHealth(), 10)
end

os.exit(luaunit.LuaUnit.run())
