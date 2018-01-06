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
    abilities[GetBot():GetUnitName()][1])

  luaunit.assertEquals(
    BOT_ABILITIES[2],
    abilities[GetBot():GetUnitName()][2])

  luaunit.assertEquals(
    BOT_ABILITIES[3],
    abilities[GetBot():GetUnitName()][3])

  luaunit.assertEquals(
    BOT_ABILITIES[6],
    abilities[GetBot():GetUnitName()][4])

  luaunit.assertEquals(
    BOT_ABILITIES[7],
    talents[GetBot():GetUnitName()][1])

  luaunit.assertEquals(
    BOT_ABILITIES[8],
    talents[GetBot():GetUnitName()][2])

  luaunit.assertEquals(
    BOT_ABILITIES[9],
    talents[GetBot():GetUnitName()][3])

  luaunit.assertEquals(
    BOT_ABILITIES[10],
    talents[GetBot():GetUnitName()][4])

  luaunit.assertEquals(
    BOT_ABILITIES[11],
    talents[GetBot():GetUnitName()][5])

  luaunit.assertEquals(
    BOT_ABILITIES[12],
    talents[GetBot():GetUnitName()][6])

  luaunit.assertEquals(
    BOT_ABILITIES[13],
    talents[GetBot():GetUnitName()][7])

  luaunit.assertEquals(
    BOT_ABILITIES[14],
    talents[GetBot():GetUnitName()][8])
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

  local npc_bot = GetBot()
  npc_bot.level = 1
  npc_bot.ability_points = 1

  ability_levelup.test_SetAbilities(
    {
      npc_dota_hero_crystal_maiden = {
        Ability:new("crystal_maiden_crystal_nova"),
        Ability:new("crystal_maiden_frostbite"),
        Ability:new("crystal_maiden_brilliance_aura")
      }
    })

  ability_levelup.test_SetTalents(
    {
      npc_dota_hero_crystal_maiden = {
        Ability:new("special_bonus_magic_resistance_15"),
        Ability:new("special_bonus_attack_damage_60"),
        Ability:new("special_bonus_cast_range_125")
      }
    })

  ABILITY_CAN_BE_UPGRADED = true
  BOT_LEVELUP_ABILITY = nil

  ability_levelup.AbilityLevelUpThink()

  luaunit.assertEquals(BOT_LEVELUP_ABILITY, "crystal_maiden_frostbite")
end

os.exit(luaunit.LuaUnit.run())
