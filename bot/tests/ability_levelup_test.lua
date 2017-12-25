package.path = package.path .. ";../utility/?.lua"

require("global_functions")

local ability_levelup = require("ability_levelup")
local luaunit = require('luaunit')

function test_InitAbilities()
  test_RefreshBot()

  BOT_ABILITIES = {
    Ability:new("crystal_maiden_crystal_nova"),
    Ability:new("crystal_maiden_frostbite"),
    Ability:new("crystal_maiden_brilliance_aura"),
    Ability:new("generic_hidden"),
    Ability:new("generic_hidden"),
    Ability:new("crystal_maiden_freezing_field"),
    Ability:new("special_bonus_hp_200"),
    Ability:new("special_bonus_cast_range_100"),
    Ability:new("special_bonus_unique_crystal_maiden_4"),
    Ability:new("special_bonus_gold_income_15"),
    Ability:new("special_bonus_attack_speed_250"),
    Ability:new("special_bonus_unique_crystal_maiden_3"),
    Ability:new("special_bonus_unique_crystal_maiden_1"),
    Ability:new("special_bonus_unique_crystal_maiden_2"),
  }

  ability_levelup.ABILITIES = {}

  ability_levelup.InitAbilities()

  luaunit.assertEquals(
    BOT_ABILITIES[1],
    ability_levelup.ABILITIES[1])

  luaunit.assertEquals(
    BOT_ABILITIES[2],
    ability_levelup.ABILITIES[2])

  luaunit.assertEquals(
    BOT_ABILITIES[3],
    ability_levelup.ABILITIES[3])

  luaunit.assertEquals(
    BOT_ABILITIES[6],
    ability_levelup.ABILITIES[4])

  luaunit.assertEquals(
    BOT_ABILITIES[7],
    ability_levelup.TALENTS[1])

  luaunit.assertEquals(
    BOT_ABILITIES[8],
    ability_levelup.TALENTS[2])

  luaunit.assertEquals(
    BOT_ABILITIES[9],
    ability_levelup.TALENTS[3])

  luaunit.assertEquals(
    BOT_ABILITIES[10],
    ability_levelup.TALENTS[4])

  luaunit.assertEquals(
    BOT_ABILITIES[11],
    ability_levelup.TALENTS[5])

  luaunit.assertEquals(
    BOT_ABILITIES[12],
    ability_levelup.TALENTS[6])

  luaunit.assertEquals(
    BOT_ABILITIES[13],
    ability_levelup.TALENTS[7])

  luaunit.assertEquals(
    BOT_ABILITIES[14],
    ability_levelup.TALENTS[8])
end

function test_AbilityLevelUp()
  test_RefreshBot()

  luaunit.assertTrue(
    ability_levelup.test_AbilityLevelUp(
      GetBot(),
      Ability:new("crystal_maiden_crystal_nova")))

  luaunit.assertEquals(BOT_LEVELUP_ABILITY, "crystal_maiden_crystal_nova")

  luaunit.assertFalse(
    ability_levelup.test_AbilityLevelUp(
      GetBot(),
      nil))

  ABILITY_CAN_BE_UPGRADED = false

  luaunit.assertFalse(
    ability_levelup.test_AbilityLevelUp(
      GetBot(),
      Ability:new("crystal_maiden_crystal_nova")))
end

function test_AbilityLevelUpThink()
  test_RefreshBot()

  ability_levelup.ABILITIES = {
    Ability:new("crystal_maiden_crystal_nova")
  }

  ABILITY_CAN_BE_UPGRADED = true

  ability_levelup.AbilityLevelUpThink()
end

os.exit(luaunit.LuaUnit.run())
