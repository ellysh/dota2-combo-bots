package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
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
    Ability:new("special_bonus_unique_crystal_maiden_2")
  }

  ability_levelup.test_SetAbilities({})

  ability_levelup.InitAbilities()

  abilities = ability_levelup.test_GetAbilities()
  talents = ability_levelup.test_GetTalents()

  luaunit.assertEquals(
    BOT_ABILITIES[1]:GetName(),
    abilities[GetBot():GetUnitName()][1])

  luaunit.assertEquals(
    BOT_ABILITIES[2]:GetName(),
    abilities[GetBot():GetUnitName()][2])

  luaunit.assertEquals(
    BOT_ABILITIES[3]:GetName(),
    abilities[GetBot():GetUnitName()][3])

  luaunit.assertEquals(
    BOT_ABILITIES[6]:GetName(),
    abilities[GetBot():GetUnitName()][4])

  luaunit.assertEquals(
    BOT_ABILITIES[7]:GetName(),
    talents[GetBot():GetUnitName()][1])

  luaunit.assertEquals(
    BOT_ABILITIES[8]:GetName(),
    talents[GetBot():GetUnitName()][2])

  luaunit.assertEquals(
    BOT_ABILITIES[9]:GetName(),
    talents[GetBot():GetUnitName()][3])

  luaunit.assertEquals(
    BOT_ABILITIES[10]:GetName(),
    talents[GetBot():GetUnitName()][4])

  luaunit.assertEquals(
    BOT_ABILITIES[11]:GetName(),
    talents[GetBot():GetUnitName()][5])

  luaunit.assertEquals(
    BOT_ABILITIES[12]:GetName(),
    talents[GetBot():GetUnitName()][6])

  luaunit.assertEquals(
    BOT_ABILITIES[13]:GetName(),
    talents[GetBot():GetUnitName()][7])

  luaunit.assertEquals(
    BOT_ABILITIES[14]:GetName(),
    talents[GetBot():GetUnitName()][8])
end

function test_AbilityLevelUp()
  test_RefreshBot()

  BOT_LEVELUP_ABILITY = nil

  luaunit.assertTrue(
    ability_levelup.test_AbilityLevelUp(
      GetBot(),
      "crystal_maiden_crystal_nova"))

  luaunit.assertEquals(BOT_LEVELUP_ABILITY, "crystal_maiden_crystal_nova")

  luaunit.assertFalse(
    ability_levelup.test_AbilityLevelUp(
      GetBot(),
      nil))

  ABILITY_CAN_BE_UPGRADED = false

  luaunit.assertFalse(
    ability_levelup.test_AbilityLevelUp(
      GetBot(),
      "crystal_maiden_crystal_nova"))

  ABILITY_CAN_BE_UPGRADED = true
  ABILITY_IS_NULL = true

  luaunit.assertFalse(
    ability_levelup.test_AbilityLevelUp(
      GetBot(),
      Ability:new("crystal_maiden_crystal_nova")))
end

function test_AbilityLevelUpThink_without_ability_points_fails()
  test_RefreshBot()

  local bot = GetBot()
  bot.level = 1
  bot.ability_points = 0

  ability_levelup.test_SetAbilities(
    {
      npc_dota_hero_crystal_maiden = {
        "crystal_maiden_crystal_nova",
        "crystal_maiden_frostbite",
        "crystal_maiden_brilliance_aura"
      }
    })

  ability_levelup.test_SetTalents(
    {
      npc_dota_hero_crystal_maiden = {
        "special_bonus_magic_resistance_15",
        "special_bonus_attack_damage_60",
        "special_bonus_cast_range_125"
      }
    })

  ABILITY_IS_NULL = false
  ABILITY_CAN_BE_UPGRADED = true
  BOT_LEVELUP_ABILITY = nil

  ability_levelup.AbilityLevelUpThink()

  luaunit.assertEquals(BOT_LEVELUP_ABILITY, nil)
end

-- Succeed AbilityLevelUpThink should be done in one function
-- becuase this function changes the Database.

function test_AbilityLevelUpThink_from_1_to_25_level_succeed()
  test_RefreshBot()

  local bot = GetBot()
  bot.level = 25
  bot.ability_points = 18

  ability_levelup.test_SetAbilities(
    {
      npc_dota_hero_crystal_maiden = {
        "crystal_maiden_crystal_nova",
        "crystal_maiden_frostbite",
        "crystal_maiden_brilliance_aura",
        "crystal_maiden_freezing_field"
      }
    })

  ability_levelup.test_SetTalents(
    {
      npc_dota_hero_crystal_maiden = {
        "special_bonus_hp_200",
        "special_bonus_cast_range_100",
        "special_bonus_unique_crystal_maiden_4",
        "special_bonus_gold_income_15",
        "special_bonus_attack_speed_250",
        "special_bonus_unique_crystal_maiden_3",
        "special_bonus_unique_crystal_maiden_1",
        "special_bonus_unique_crystal_maiden_2"
      }
    })

  ABILITY_CAN_BE_UPGRADED = true
  ABILITY_IS_NULL = false
  BOT_LEVELUP_ABILITY = nil

  ability_levelup.AbilityLevelUpThink()
  luaunit.assertEquals(
    BOT_LEVELUP_ABILITY,
    "crystal_maiden_frostbite")

  ability_levelup.AbilityLevelUpThink()
  luaunit.assertEquals(
    BOT_LEVELUP_ABILITY,
    "crystal_maiden_brilliance_aura")

  BOT_LEVELUP_ABILITY = nil
  ability_levelup.AbilityLevelUpThink()

  luaunit.assertEquals(
    BOT_LEVELUP_ABILITY,
    "crystal_maiden_brilliance_aura")

  BOT_LEVELUP_ABILITY = nil
  ability_levelup.AbilityLevelUpThink()

  luaunit.assertEquals(
    BOT_LEVELUP_ABILITY,
    "crystal_maiden_crystal_nova")

  BOT_LEVELUP_ABILITY = nil
  ability_levelup.AbilityLevelUpThink()

  luaunit.assertEquals(
    BOT_LEVELUP_ABILITY,
    "crystal_maiden_brilliance_aura")

  BOT_LEVELUP_ABILITY = nil
  ability_levelup.AbilityLevelUpThink()

  luaunit.assertEquals(
    BOT_LEVELUP_ABILITY,
    "crystal_maiden_freezing_field")

  BOT_LEVELUP_ABILITY = nil
  ability_levelup.AbilityLevelUpThink()

  luaunit.assertEquals(
    BOT_LEVELUP_ABILITY,
    "crystal_maiden_brilliance_aura")

  BOT_LEVELUP_ABILITY = nil
  ability_levelup.AbilityLevelUpThink()

  luaunit.assertEquals(
    BOT_LEVELUP_ABILITY,
    "crystal_maiden_crystal_nova")

  BOT_LEVELUP_ABILITY = nil
  ability_levelup.AbilityLevelUpThink()

  luaunit.assertEquals(
    BOT_LEVELUP_ABILITY,
    "crystal_maiden_crystal_nova")

  BOT_LEVELUP_ABILITY = nil
  ability_levelup.AbilityLevelUpThink()

  luaunit.assertEquals(
    BOT_LEVELUP_ABILITY,
    "special_bonus_cast_range_100")

  BOT_LEVELUP_ABILITY = nil
  ability_levelup.AbilityLevelUpThink()

  luaunit.assertEquals(
    BOT_LEVELUP_ABILITY,
    "crystal_maiden_crystal_nova")

  BOT_LEVELUP_ABILITY = nil
  ability_levelup.AbilityLevelUpThink()

  luaunit.assertEquals(
    BOT_LEVELUP_ABILITY,
    "crystal_maiden_freezing_field")

  BOT_LEVELUP_ABILITY = nil
  ability_levelup.AbilityLevelUpThink()

  luaunit.assertEquals(
    BOT_LEVELUP_ABILITY,
    "crystal_maiden_frostbite")

  BOT_LEVELUP_ABILITY = nil
  ability_levelup.AbilityLevelUpThink()

  luaunit.assertEquals(
    BOT_LEVELUP_ABILITY,
    "crystal_maiden_frostbite")

  BOT_LEVELUP_ABILITY = nil
  ability_levelup.AbilityLevelUpThink()

  luaunit.assertEquals(
    BOT_LEVELUP_ABILITY,
    "special_bonus_unique_crystal_maiden_4")

  BOT_LEVELUP_ABILITY = nil
  ability_levelup.AbilityLevelUpThink()

  luaunit.assertEquals(
    BOT_LEVELUP_ABILITY,
    "crystal_maiden_frostbite")

  BOT_LEVELUP_ABILITY = nil
  ability_levelup.AbilityLevelUpThink()

  luaunit.assertEquals(
    BOT_LEVELUP_ABILITY,
    "crystal_maiden_freezing_field")

  BOT_LEVELUP_ABILITY = nil
  ability_levelup.AbilityLevelUpThink()

  luaunit.assertEquals(
    BOT_LEVELUP_ABILITY,
    "special_bonus_unique_crystal_maiden_3")

  BOT_LEVELUP_ABILITY = nil
  ability_levelup.AbilityLevelUpThink()

  luaunit.assertEquals(
    BOT_LEVELUP_ABILITY,
    "special_bonus_unique_crystal_maiden_2")
end

os.exit(luaunit.LuaUnit.run())
