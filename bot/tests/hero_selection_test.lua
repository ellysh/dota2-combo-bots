package.path = package.path .. ";../?.lua"

require("global_functions")

local hero_selection = require("hero_selection")
local luaunit = require('luaunit')

function test_GetBotNames()
  local bot_names = hero_selection.test_GetBotNames()

  luaunit.assertEquals(bot_names[1], "Alfa")
  luaunit.assertEquals(bot_names[2], "Bravo")
  luaunit.assertEquals(bot_names[3], "Charlie")
  luaunit.assertEquals(bot_names[4], "Delta")
  luaunit.assertEquals(bot_names[5], "Echo")
end

function test_IsIntersectionOfLists()
  local list1 = {1, 2, 3, 4, 5}
  local list2 = {3, 4, 5, 6}
  local list3 = {10, 11, 12}

  luaunit.assertTrue(
    hero_selection.test_IsIntersectionOfLists(list1, list2))

  luaunit.assertFalse(
    hero_selection.test_IsIntersectionOfLists(list1, list3))

  luaunit.assertFalse(
    hero_selection.test_IsIntersectionOfLists(list2, list3))
end

function test_IsHeroPickedByTeam()
  luaunit.assertTrue(
    hero_selection.test_IsHeroPickedByTeam("npc_dota_hero_venomancer",
    TEAM_RADIANT))

  luaunit.assertFalse(
    hero_selection.test_IsHeroPickedByTeam("npc_dota_hero_crystal_maiden",
    TEAM_RADIANT))
end

function test_IsHeroPicked()
  luaunit.assertTrue(
    hero_selection.test_IsHeroPicked("npc_dota_hero_venomancer"))

  luaunit.assertFalse(
    hero_selection.test_IsHeroPicked(
      "npc_dota_hero_crystal_maiden"))
end

function test_IsHeroPicked()
  luaunit.assertTrue(hero_selection.test_GetRandomTrue())
end

function test_GetRandomHero()
  luaunit.assertEquals(
    hero_selection.test_GetRandomHero(5),
    "npc_dota_hero_shadow_shaman")
end

function test_GetComboHero()
  luaunit.assertEquals(
    hero_selection.test_GetComboHero(4, {"npc_dota_hero_shadow_shaman"}),
    "npc_dota_hero_crystal_maiden")
end

function test_Think()
  Think()

  luaunit.assertEquals(SELECTED_HEROES[1], "npc_dota_hero_juggernaut")

  luaunit.assertEquals(
    SELECTED_HEROES[2],
    "npc_dota_hero_drow_ranger")

  luaunit.assertEquals(SELECTED_HEROES[3], "npc_dota_hero_ursa")
  luaunit.assertEquals(SELECTED_HEROES[4], "npc_dota_hero_crystal_maiden")
  luaunit.assertEquals(SELECTED_HEROES[5], "npc_dota_hero_shadow_shaman")
end

function test_UpdateLaneAssignments()
  local result = UpdateLaneAssignments()

  luaunit.assertEquals(result[1], LANE_BOT)
  luaunit.assertEquals(result[2], LANE_MID)
  luaunit.assertEquals(result[3], LANE_TOP)
  luaunit.assertEquals(result[4], LANE_BOT)
  luaunit.assertEquals(result[5], LANE_TOP)
end

os.exit(luaunit.LuaUnit.run())
