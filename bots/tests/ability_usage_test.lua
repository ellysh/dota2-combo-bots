package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local ability_usage = require("ability_usage")
local ability_usage_algorithms = require("ability_usage_algorithms")
local luaunit = require('luaunit')

function test_GetDesiredAbilitiesList_with_not_castable_fails()
  test_RefreshBot()

  ABILITY_IS_FULLY_CASTABLE = false

  luaunit.assertEquals(
    ability_usage.test_GetDesiredAbilitiesList(GetBot()),
    {})
end

function test_CalculateDesireAndTarget_succeed()
  test_RefreshBot()

  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_DAMAGE = 200
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT

  local desire, target =
    ability_usage.test_CalculateDesireAndTarget(
      GetBot(),
      ability_usage_algorithms.min_hp_enemy_hero_to_kill,
      "any_mode",
      ability)

  luaunit.assertEquals(desire, true)
  luaunit.assertEquals(target, {10, 10})
end

function test_CalculateDesireAndTarget_fails()
  test_RefreshBot()

  local ability = Ability:new()

  local desire, target =
    ability_usage.test_CalculateDesireAndTarget(
      GetBot(),
      nil,
      "any_mode",
      ability)

  luaunit.assertEquals(desire, false)
  luaunit.assertEquals(target, nil)

  UNIT_MODE = BOT_MODE_ATTACK

  local desire, target =
    ability_usage.test_CalculateDesireAndTarget(
      GetBot(),
      ability_usage_algorithms.min_hp_enemy_hero_to_kill,
      BOT_MODE_LANING,
      ability)

  luaunit.assertEquals(desire, false)
  luaunit.assertEquals(target, nil)
end

function test_ChooseAbilityAndTarget_succeed()
  test_RefreshBot()

  UNIT_ABILITIES = { Ability:new("crystal_maiden_crystal_nova") }
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT
  ABILITY_DAMAGE = 200
  UNIT_HAS_NEARBY_UNITS = true

  local ability, target =
    ability_usage.test_ChooseAbilityAndTarget(GetBot())

  luaunit.assertNotEquals(ability, nil)
  luaunit.assertNotEquals(target, nil)
end

function test_ChooseAbilityAndTarget_with_not_castable_fails()
  test_RefreshBot()

  UNIT_ABILITIES = { Ability:new("crystal_maiden_crystal_nova") }
  ABILITY_IS_FULLY_CASTABLE = false
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT
  ABILITY_DAMAGE = 200

  local ability, target =
    ability_usage.test_ChooseAbilityAndTarget(GetBot())

  luaunit.assertEquals(ability, nil)
  luaunit.assertEquals(target, nil)
end

function test_UseAbility_behavior_point_succeed()
  test_RefreshBot()

  UNIT_ABILITIES = { Ability:new("crystal_maiden_crystal_nova") }
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT
  UNIT_ABILITY = nil
  UNIT_ABILITY_LOCATION = nil

  local ability = Ability:new("crystal_maiden_crystal_nova")
  local location =  {15, 25}

  ability_usage.test_UseAbility(GetBot(), ability, location)

  luaunit.assertEquals(UNIT_ABILITY, ability)
  luaunit.assertEquals(UNIT_ABILITY_LOCATION, location)
end

function test_UseAbility_behavior_no_target_succeed()
  test_RefreshBot()

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_NO_TARGET
  UNIT_ABILITY = nil
  UNIT_ABILITY_LOCATION = nil

  local ability = Ability:new("crystal_maiden_crystal_nova")
  local location =  {15, 25}

  ability_usage.test_UseAbility(GetBot(), ability, location)

  luaunit.assertEquals(UNIT_ABILITY, ability)
  luaunit.assertEquals(UNIT_ABILITY_LOCATION, nil)
end

function test_UseAbility_behavior_unit_target_succeed()
  test_RefreshBot()

  UNIT_ABILITIES = { Ability:new("crystal_maiden_crystal_nova") }
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_UNIT_TARGET
  UNIT_ABILITY = nil
  UNIT_ABILITY_LOCATION = nil

  local ability = Ability:new("crystal_maiden_crystal_nova")
  local location =  {15, 25}

  ability_usage.test_UseAbility(GetBot(), ability, location)

  luaunit.assertEquals(UNIT_ABILITY, ability)
  luaunit.assertEquals(UNIT_ABILITY_LOCATION, nil)
end

function test_UseAbility_nil_fails()
  test_RefreshBot()

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_NO_TARGET
  UNIT_ABILITY = nil
  UNIT_ABILITY_LOCATION = nil

  local location =  {15, 25}

  ability_usage.test_UseAbility(GetBot(), nil, location)

  luaunit.assertEquals(UNIT_ABILITY, nil)
  luaunit.assertEquals(UNIT_ABILITY_LOCATION, nil)
end

function test_CancelAbility_succeed()
  test_RefreshBot()

  UNIT_IS_CHANNELING = true
  UNIT_CLEAR_ACTIONS = false
  UNIT_HAS_NEARBY_UNITS = false

  ability_usage.test_CancelAbility(GetBot())
  luaunit.assertTrue(UNIT_CLEAR_ACTIONS)
end

function test_AbilityUsageThink_succeed()
  test_RefreshBot()

  UNIT_ABILITY = nil
  UNIT_ABILITY_LOCATION = nil

  UNIT_ABILITIES = { Ability:new("crystal_maiden_crystal_nova") }
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT
  ABILITY_DAMAGE = 200

  ABILITY_CASTABLE_NAME = "crystal_maiden_crystal_nova"

  ability_usage.AbilityUsageThink()

  luaunit.assertEquals(
    UNIT_ABILITY,
    Ability:new("crystal_maiden_crystal_nova"))

  luaunit.assertNotEquals(UNIT_ABILITY_LOCATION, nil)
end

function test_AbilityUsageThink_when_UNIT_channeling_fails()
  test_RefreshBot()

  UNIT_ABILITIES = { Ability:new("crystal_maiden_crystal_nova") }
  UNIT_ABILITY = nil
  UNIT_ABILITY_LOCATION = nil
  UNIT_IS_CHANNELING = true

  ABILITY_DAMAGE = 200
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT

  ability_usage.AbilityUsageThink()

  luaunit.assertEquals(
    UNIT_ABILITY,
    nil)

  luaunit.assertEquals(UNIT_ABILITY_LOCATION, nil)
end

os.exit(luaunit.LuaUnit.run())
