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

  ability_levelup.test_SetAbilities({})

  ability_levelup.InitAbilities()

  abilities = ability_levelup.test_GetAbilities()
  talents = ability_levelup.test_GetTalents()

  luaunit.assertEquals(
    BOT_ABILITIES[1],
    abilities[1])

  luaunit.assertEquals(
    BOT_ABILITIES[2],
    abilities[2])

  luaunit.assertEquals(
    BOT_ABILITIES[3],
    abilities[3])

  luaunit.assertEquals(
    BOT_ABILITIES[6],
    abilities[4])

  luaunit.assertEquals(
    BOT_ABILITIES[7],
    talents[1])

  luaunit.assertEquals(
    BOT_ABILITIES[8],
    talents[2])

  luaunit.assertEquals(
    BOT_ABILITIES[9],
    talents[3])

  luaunit.assertEquals(
    BOT_ABILITIES[10],
    talents[4])

  luaunit.assertEquals(
    BOT_ABILITIES[11],
    talents[5])

  luaunit.assertEquals(
    BOT_ABILITIES[12],
    talents[6])

  luaunit.assertEquals(
    BOT_ABILITIES[13],
    talents[7])

  luaunit.assertEquals(
    BOT_ABILITIES[14],
    talents[8])
end

function test_AbilityLevelUp()
  test_RefreshBot()

  BOT_LEVELUP_ABILITY = nil

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

  ability_levelup.test_SetAbilities(
    {
      Ability:new("crystal_maiden_crystal_nova"),
      Ability:new("crystal_maiden_frostbite"),
      Ability:new("crystal_maiden_brilliance_aura")
    })

  ABILITY_CAN_BE_UPGRADED = true
  BOT_LEVELUP_ABILITY = nil

  ability_levelup.AbilityLevelUpThink()

  luaunit.assertEquals(BOT_LEVELUP_ABILITY, "crystal_maiden_frostbite")
end

os.exit(luaunit.LuaUnit.run())
