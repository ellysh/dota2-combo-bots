package.path = package.path .. ";../?.lua"

pcall(require, "luacov")
require("global_functions")

local hero_selection = require("hero_selection")
local luaunit = require('luaunit')

function test_GetPickedHeroesList()
  SELECTED_HEROES = {}

  SelectHero(1, "npc_dota_hero_venomancer")
  SelectHero(2, "npc_dota_hero_crystal_maiden")

  luaunit.assertEquals(
    hero_selection.test_GetPickedHeroesList(TEAM_RADIANT),
    {"npc_dota_hero_venomancer", "npc_dota_hero_crystal_maiden"})
end

function test_IsHeroPickedByTeam()
  SELECTED_HEROES = {}

  SelectHero(1, "npc_dota_hero_venomancer")

  luaunit.assertTrue(
    hero_selection.test_IsHeroPickedByTeam("npc_dota_hero_venomancer",
    TEAM_RADIANT))

  luaunit.assertFalse(
    hero_selection.test_IsHeroPickedByTeam("npc_dota_hero_crystal_maiden",
    TEAM_RADIANT))
end

function test_IsHeroPicked()
  SELECTED_HEROES = {}

  SelectHero(1, "npc_dota_hero_venomancer")

  luaunit.assertTrue(
    hero_selection.test_IsHeroPicked("npc_dota_hero_venomancer"))

  luaunit.assertFalse(
    hero_selection.test_IsHeroPicked(
      "npc_dota_hero_crystal_maiden"))
end

function test_GetRandomHero_succeed()
  luaunit.assertEquals(
    hero_selection.test_GetRandomHero(5),
    "npc_dota_hero_lich")
end

function test_GetComboHero_succeed()
  hero_selection.test_ResetTeamComposition(GetTeam())

  SELECTED_HEROES = {}

  hero_selection.test_PickHero()

  luaunit.assertNotEquals(
    hero_selection.test_GetComboHero(4),
    nil)
end

function test_IsHumanPlayersPicked_succeed()
  luaunit.assertTrue(hero_selection.test_IsHumanPlayersPicked())
end

function test_FillTeamComposition_succeed()
  hero_selection.test_ResetTeamComposition(GetTeam())

  SELECTED_HEROES = {}

  hero_selection.test_FillTeamComposition(1, "npc_dota_hero_sven")

  local team_composition = hero_selection.test_GetTeamComposition(
    GetTeam())

  luaunit.assertEquals(team_composition.positions[1], 1)
  luaunit.assertEquals(team_composition.damage_type["physical"], 1)
  luaunit.assertEquals(team_composition.attack_range["melee"], 1)
  luaunit.assertEquals(team_composition.attribute["strength"], 1)
  luaunit.assertEquals(
    team_composition.available_skills,
    {"attack_damage", "stun", "aoe", "nil"})
  luaunit.assertEquals(team_composition.available_auras, {"armor"})
  luaunit.assertEquals(
    team_composition.required_skills,
    {"stun", "slow", "hex"})
  luaunit.assertEquals(
    team_composition.required_auras,
    {"heal", "nil", "nil"})
  luaunit.assertEquals(team_composition.is_human_applied, false)
end

function test_ApplyHumanPlayersHeroes_succeed()
  hero_selection.test_ResetTeamComposition(GetTeam())

  SELECTED_HEROES = { "npc_dota_hero_sven" }
  IS_PLAYER_BOT = false

  hero_selection.test_ApplyHumanPlayersHeroes()

  local team_composition = hero_selection.test_GetTeamComposition(
    GetTeam())

  luaunit.assertEquals(team_composition.positions[1], 1)
  luaunit.assertEquals(team_composition.damage_type["physical"], 1)
  luaunit.assertEquals(team_composition.attack_range["melee"], 1)
  luaunit.assertEquals(team_composition.attribute["strength"], 1)
  luaunit.assertEquals(
    team_composition.available_skills,
    {"attack_damage", "stun", "aoe", "nil"})
  luaunit.assertEquals(team_composition.available_auras, {"armor"})
  luaunit.assertEquals(
    team_composition.required_skills,
    {"stun", "slow", "hex"})
  luaunit.assertEquals(
    team_composition.required_auras,
    {"heal", "nil", "nil"})
  luaunit.assertEquals(team_composition.is_human_applied, true)
end

function test_IsPickRequired_succeed()
  hero_selection.test_ResetTeamComposition(GetTeam())

  luaunit.assertTrue(hero_selection.test_IsPickRequired())
end

function test_IsPickRequired_fails()
  hero_selection.test_ResetTeamComposition(GetTeam())

  SELECTED_HEROES = {}

  hero_selection.test_PickHero()
  hero_selection.test_PickHero()
  hero_selection.test_PickHero()
  hero_selection.test_PickHero()
  hero_selection.test_PickHero()

  luaunit.assertFalse(hero_selection.test_IsPickRequired())
end

function test_GetRequiredPosition_succeed()
  hero_selection.test_ResetTeamComposition(GetTeam())

  SELECTED_HEROES = {}

  luaunit.assertEquals(hero_selection.test_GetRequiredPosition(), 1)

  hero_selection.test_PickHero()

  luaunit.assertEquals(hero_selection.test_GetRequiredPosition(), 2)

  hero_selection.test_PickHero()

  luaunit.assertEquals(hero_selection.test_GetRequiredPosition(), 3)

  hero_selection.test_PickHero()

  luaunit.assertEquals(hero_selection.test_GetRequiredPosition(), 4)

  hero_selection.test_PickHero()

  luaunit.assertEquals(hero_selection.test_GetRequiredPosition(), 5)

  hero_selection.test_PickHero()

  luaunit.assertEquals(hero_selection.test_GetRequiredPosition(), nil)
end

function test_PickHero_succeed()
  hero_selection.test_ResetTeamComposition(GetTeam())

  SELECTED_HEROES = {}

  hero_selection.test_PickHero()
  hero_selection.test_PickHero()
  hero_selection.test_PickHero()
  hero_selection.test_PickHero()
  hero_selection.test_PickHero()

  luaunit.assertNotEquals(SELECTED_HEROES[1], nil)
  luaunit.assertNotEquals(SELECTED_HEROES[2], nil)
  luaunit.assertNotEquals(SELECTED_HEROES[3], nil)
  luaunit.assertNotEquals(SELECTED_HEROES[4], nil)
  luaunit.assertNotEquals(SELECTED_HEROES[5], nil)
end

function test_Think_succeed()
  hero_selection.test_ResetTeamComposition(GetTeam())

  SELECTED_HEROES = {}

  Think()
  Think()
  Think()
  Think()
  Think()

  luaunit.assertNotEquals(SELECTED_HEROES[1], nil)
  luaunit.assertNotEquals(SELECTED_HEROES[2], nil)
  luaunit.assertNotEquals(SELECTED_HEROES[3], nil)
  luaunit.assertNotEquals(SELECTED_HEROES[4], nil)
  luaunit.assertNotEquals(SELECTED_HEROES[5], nil)
end

function test_UpdateLaneAssignments()
  TEAM = TEAM_RADIANT
  local result = UpdateLaneAssignments()

  luaunit.assertEquals(result[1], LANE_BOT)
  luaunit.assertEquals(result[2], LANE_MID)
  luaunit.assertEquals(result[3], LANE_TOP)
  luaunit.assertEquals(result[4], LANE_BOT)
  luaunit.assertEquals(result[5], LANE_TOP)

  TEAM = TEAM_DIRE
  local result = UpdateLaneAssignments()

  luaunit.assertEquals(result[1], LANE_TOP)
  luaunit.assertEquals(result[2], LANE_MID)
  luaunit.assertEquals(result[3], LANE_BOT)
  luaunit.assertEquals(result[4], LANE_TOP)
  luaunit.assertEquals(result[5], LANE_BOT)
end

function test_GetBotNames()
  local bot_names = hero_selection.test_GetBotNames()

  luaunit.assertEquals(bot_names[1], "Alfa")
  luaunit.assertEquals(bot_names[2], "Bravo")
  luaunit.assertEquals(bot_names[3], "Charlie")
  luaunit.assertEquals(bot_names[4], "Delta")
  luaunit.assertEquals(bot_names[5], "Echo")
  luaunit.assertEquals(bot_names[6], "Foxtrot")
  luaunit.assertEquals(bot_names[7], "Mike")
  luaunit.assertEquals(bot_names[8], "Juliett")
  luaunit.assertEquals(bot_names[9], "Oscar")
  luaunit.assertEquals(bot_names[10], "Papa")
  luaunit.assertEquals(bot_names[11], "Romeo")
  luaunit.assertEquals(bot_names[12], "Sierra")
  luaunit.assertEquals(bot_names[13], "Tango")
  luaunit.assertEquals(bot_names[14], "Victor")
  luaunit.assertEquals(bot_names[15], "Yankee")
end

os.exit(luaunit.LuaUnit.run())
