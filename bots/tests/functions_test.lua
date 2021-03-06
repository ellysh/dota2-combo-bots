package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local functions = require("functions")
local constants = require("constants")
local luaunit = require('luaunit')

function test_GetTableSize_succeed()
  test_RefreshBot()

  local table = {
    test = 123,
    [1] = 1,
    [2] = 2
  }

  luaunit.assertEquals(functions.GetTableSize(table), 3)
  luaunit.assertNotEquals(functions.GetTableSize(table), #table)
end

function test_GetItems_succeed()
  test_RefreshBot()

  local empty_list = {"nil", "nil", "nil", "nil", "nil", "nil",
                      "nil", "nil", "nil"}

  local bot = GetBot()

  local size, list = functions.GetItems(
      bot,
      constants.INVENTORY_START_INDEX,
      constants.INVENTORY_END_INDEX)

  luaunit.assertEquals(size, 0)
  luaunit.assertEquals(list, empty_list)

  bot.inventory = {
    "item_tango",
    "item_branches",
    "item_tango",
    "nil",
    "nil",
    "nil",
    "nil",
    "nil",
    "nil"
  }

  size, list = functions.GetItems(
      bot,
      constants.INVENTORY_START_INDEX,
      constants.INVENTORY_END_INDEX,
      function(item) return item:GetName() end)

  luaunit.assertEquals(size, 3)

  for i = 1, #list do
    luaunit.assertEquals(bot.inventory[i], list[i])
  end
end

function test_GetItemSlotsCount_succeed()
  test_RefreshBot()

  local bot = GetBot()

  luaunit.assertEquals(
    functions.GetItemSlotsCount(
      bot,
      constants.INVENTORY_START_INDEX,
      constants.INVENTORY_END_INDEX),
    0)

  BOT.inventory = {
    "item_tango",
    "item_branches",
    "item_tango",
    "nil",
    "nil",
    "nil",
    "nil",
    "nil"
  }

  luaunit.assertEquals(
    functions.GetItemSlotsCount(
      bot,
      constants.INVENTORY_START_INDEX,
      constants.INVENTORY_END_INDEX),
    3)
end

function test_GetItem_succeed()
  test_RefreshBot()

  local bot = GetBot()
  bot.inventory = {"item_tango"}

  local item = functions.GetItem(
      bot,
      "item_tango",
      ITEM_SLOT_TYPE_MAIN)

  luaunit.assertEquals(item, Item:new("item_tango"))
end

function test_GetItem_no_item_fails()
  test_RefreshBot()

  local item = functions.GetItem(
      GetBot(),
      "item_tango",
      ITEM_SLOT_TYPE_MAIN)

  luaunit.assertEquals(item, nil)
end

function test_GetItem_wrong_slot_type_fails()
  test_RefreshBot()

  local bot = GetBot()
  bot.inventory = {"item_tango"}

  UNIT_ITEM_SLOT_TYPE = ITEM_SLOT_TYPE_BACKPACK

  local item = functions.GetItem(
      bot,
      "item_tango",
      ITEM_SLOT_TYPE_STASH)

  luaunit.assertEquals(item, nil)
end

function test_IsInventoryFull_succeed()
  test_RefreshBot()

  local bot = GetBot()
  bot.inventory = {}

  for i = 1, constants.INVENTORY_SIZE, 1 do
    table.insert(bot.inventory, "item_tango")
  end

  luaunit.assertTrue(functions.IsInventoryFull(bot))
end

function test_IsInventoryFull_fails()
  test_RefreshBot()

  local bot = GetBot()
  bot.inventory = {}

  luaunit.assertFalse(functions.IsInventoryFull(bot))

  table.insert(bot.inventory, "item_tango")

  luaunit.assertFalse(functions.IsInventoryFull(bot))
end

function test_IsStashFull_succeed()
  test_RefreshBot()

  local bot = GetBot()
  bot.inventory = {}

  local inventory_and_stash_size =
    constants.INVENTORY_SIZE + constants.STASH_SIZE

  for i = 1, inventory_and_stash_size, 1 do
    table.insert(bot.inventory, "item_tango")
  end

  luaunit.assertTrue(functions.IsStashFull(bot))
end


function test_GetElementIndexInList_succeed()
  local list = {5, 4, 3, 2, 1}

  luaunit.assertEquals(
    functions.GetElementIndexInList(list, 5),
    1)

  luaunit.assertEquals(
    functions.GetElementIndexInList(list, 4),
    2)

  luaunit.assertEquals(
    functions.GetElementIndexInList(list, 3),
    3)

  luaunit.assertEquals(
    functions.GetElementIndexInList(list, 2),
    4)

  luaunit.assertEquals(
    functions.GetElementIndexInList(list, 1),
    5)

  luaunit.assertEquals(
    functions.GetElementIndexInList(list, 0),
    -1)
end

function test_GetElementIndexInList_nil_list_fails()
  luaunit.assertEquals(
    functions.GetElementIndexInList(nil, 5),
    -1)
end

function test_IsElementInList()
  local list = {1, 2, 3, 4, 5}

  luaunit.assertTrue(functions.IsElementInList(list, 1))
  luaunit.assertTrue(functions.IsElementInList(list, 2))
  luaunit.assertTrue(functions.IsElementInList(list, 3))
  luaunit.assertTrue(functions.IsElementInList(list, 4))
  luaunit.assertTrue(functions.IsElementInList(list, 5))
  luaunit.assertFalse(functions.IsElementInList(list, 6))
end

function test_IsIntersectionOfLists_numbers_succeed()
  local list1 = {1, 2, 3, 4, 5}
  local list2 = {3, 4, 5, 6}
  local list3 = {10, 11, 12}

  luaunit.assertTrue(functions.IsIntersectionOfLists(list1, list2))

  luaunit.assertFalse(functions.IsIntersectionOfLists(list1, list3))

  luaunit.assertFalse(functions.IsIntersectionOfLists(list2, list3))
end

function test_IsIntersectionOfLists_strings_succeed()
  local list1 = {"one", "two", "three"}
  local list2 = {"three", "four", "five"}
  local list3 = {"ten", "eleven", "twelve"}

  luaunit.assertTrue(functions.IsIntersectionOfLists(list1, list2))

  luaunit.assertFalse(functions.IsIntersectionOfLists(list1, list3))

  luaunit.assertFalse(functions.IsIntersectionOfLists(list2, list3))
end

function test_IsIntersectionOfLists_nil_fails()
  local list1 = {"one", "two", "three", nil}
  local list2 = {"ten", "eleven", "twelve", nil}

  luaunit.assertFalse(functions.IsIntersectionOfLists(list1, list2))
end

function test_IsBotCasting_succeed()
  test_RefreshBot()

  local bot = GetBot()

  UNIT_IS_CHANNELING = true
  luaunit.assertTrue(functions.IsBotCasting(bot))

  UNIT_IS_CHANNELING = false
  UNIT_IS_USING_ABILITY = true
  luaunit.assertTrue(functions.IsBotCasting(bot))

  UNIT_IS_USING_ABILITY = false
  UNIT_IS_CASTING_ABILITY = true
  luaunit.assertTrue(functions.IsBotCasting(bot))
end

function test_IsBotCasting_fails()
  test_RefreshBot()

  local bot = GetBot()

  luaunit.assertFalse(functions.IsBotCasting(bot))
end

function test_IsFlagSet_succeed()
  local mask = 0x15

  luaunit.assertTrue(functions.test_IsFlagSet(mask, 0x1))
  luaunit.assertTrue(functions.test_IsFlagSet(mask, 0x4))
  luaunit.assertTrue(functions.test_IsFlagSet(mask, 0x10))

  luaunit.assertFalse(functions.test_IsFlagSet(mask, 0x2))
  luaunit.assertFalse(functions.test_IsFlagSet(mask, 0x8))
end

function test_IsFlagSet_with_zeroed_input_fails()
  luaunit.assertFalse(functions.test_IsFlagSet(0x10, 0))
  luaunit.assertFalse(functions.test_IsFlagSet(0, 0x10))
end

function test_GetAbilityTargetType_succeed()
  local ability = Ability:new("crystal_maiden_crystal_nova")

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT

  luaunit.assertEquals(
    functions.GetAbilityTargetType(ability),
    constants.ABILITY_LOCATION_TARGET)

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_NO_TARGET

  luaunit.assertEquals(
    functions.GetAbilityTargetType(ability),
    constants.ABILITY_NO_TARGET)

  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_UNIT_TARGET

  luaunit.assertEquals(
    functions.GetAbilityTargetType(ability),
    constants.ABILITY_UNIT_TARGET)
end

function test_GetAbilityTargetType_with_nil_input_fails()
  ABILITY_BEHAVIOR = ABILITY_BEHAVIOR_POINT

  luaunit.assertEquals(functions.GetAbilityTargetType(nil), nil)
end

function test_ternary()
  luaunit.assertFalse(functions.ternary(2 > 5, true, false))

  luaunit.assertTrue(functions.ternary(2 > 5, false, true))

  luaunit.assertEquals(functions.ternary(5 > 2, 5, 2), 5)
end

function test_GetInventoryItems()
  test_RefreshBot()

  local bot = GetBot()

  bot.inventory = {
    "item_tango",
    "item_branches",
    "nil",
    "nil",
    "nil",
    "nil",
    "nil",
    "nil",
    "nil",
  }

  local result = functions.GetInventoryItems(bot)

  luaunit.assertEquals(#bot.inventory, #result)

  for i = 1, #result do
    luaunit.assertEquals(bot.inventory[i], result[i])
  end
end

function test_PercentToDesire_succeed()
  luaunit.assertEquals(functions.PercentToDesire(100), 1.0)
  luaunit.assertEquals(functions.PercentToDesire(0), 0)
  luaunit.assertEquals(functions.PercentToDesire(50), 0.5)
end

function test_GetElementWith_succeed()
  test_RefreshBot()

  local unit = functions.GetElementWith(
    GetBot():GetNearbyHeroes(1200, true, BOT_MODE_NONE),
    function(t, a, b) return t[a]:GetHealth() < t[b]:GetHealth() end,
    function(unit) return unit:IsAlive() end)

  luaunit.assertEquals(unit:GetUnitName(), "unit1")
  luaunit.assertEquals(unit:GetHealth(), 10)
end

function test_GetElementWith_not_present_element_fails()
  test_RefreshBot()

  local unit = functions.GetElementWith(
    GetBot():GetNearbyHeroes(1200, true, BOT_MODE_NONE),
    function(t, a, b) return t[a]:GetHealth() < t[b]:GetHealth() end,
    function(unit) return not unit:IsAlive() end)

  luaunit.assertEquals(unit, nil)
end

function test_GetKeyAndElementWith_succeed()
  test_RefreshBot()

  local abilities = {
    ability1 = {"unit1", 0.2},
    ability2 = {"unit2", 0.9},
    ability3 = {"unit3", 0.7}
  }

  local ability, target_desire = functions.GetKeyAndElementWith(
    abilities,
    function(t, a, b) return t[b][2] < t[a][2] end,
    function(ability, params) return params[2] == 0.9 end)

  luaunit.assertEquals(ability, "ability2")
  luaunit.assertEquals(target_desire[1], "unit2")
  luaunit.assertEquals(target_desire[2], 0.9)
end

function test_GetKeyAndElementWith_not_present_element_fails()
  test_RefreshBot()

  local abilities = {
    ability1 = {"unit1", 0.2},
    ability2 = {"unit2", 0.9},
    ability3 = {"unit3", 0.7}
  }

  local ability, target_desire = functions.GetKeyAndElementWith(
    abilities,
    function(t, a, b) return t[b][2] < t[a][2] end,
    function(ability, params) return params[2] == 0.5 end)

  luaunit.assertEquals(ability, nil)
  luaunit.assertEquals(target_desire, nil)
end

function test_GetKeyWith_succeed()
  test_RefreshBot()

  local abilities = {
    ability1 = {"unit1", 0.2},
    ability2 = {"unit2", 0.9},
    ability3 = {"unit3", 0.7}
  }

  local ability = functions.GetKeyWith(
    abilities,
    function(t, a, b) return t[b][2] < t[a][2] end,
    function(ability, params) return params[2] == 0.9 end)

  luaunit.assertEquals(ability, "ability2")
end

function test_GetKeyWith_not_present_element_fails()
  test_RefreshBot()

  local abilities = {
    ability1 = {"unit1", 0.2},
    ability2 = {"unit2", 0.9},
    ability3 = {"unit3", 0.7}
  }

  local ability = functions.GetKeyWith(
    abilities,
    function(t, a, b) return t[b][2] < t[a][2] end,
    function(ability, params) return params[2] == 0.5 end)

  luaunit.assertEquals(ability, nil)
end

function test_GetNumberOfElementsWith()
  local unit = Unit:new()

  PLAYERS = { 1, 2, 3 }

  IS_HERO_ALIVE = true

  luaunit.assertEquals(
    functions.GetNumberOfElementsWith(
      PLAYERS,
      function(player) return IsHeroAlive(player) end),
    3)

  IS_HERO_ALIVE = false

  luaunit.assertEquals(
    functions.GetNumberOfElementsWith(
      PLAYERS,
      function(player) return IsHeroAlive(player) end),
    0)
end

function test_IsUnitHaveItems()
  test_RefreshBot()

  local unit = Unit:new()

  unit.inventory = { "item_tpscroll", "item_travel_boots_1" }

  luaunit.assertTrue(
    functions.IsUnitHaveItems(
      unit,
      {"item_travel_boots_1"}))

  luaunit.assertFalse(
    functions.IsUnitHaveItems(
      unit,
      {"item_tango"}))
end

function test_GetHeroPositions()
  luaunit.assertEquals(
    functions.GetHeroPositions("npc_dota_hero_shadow_shaman"),
    {5, 4})

  luaunit.assertEquals(
    functions.GetHeroPositions("npc_dota_hero_unknown"),
    {1, 2})
end

function test_IsBotModeMatch_succeed()
  test_RefreshBot()

  luaunit.assertTrue(
    functions.IsBotModeMatch(
      GetBot(),
      "any_mode"))

  luaunit.assertTrue(
    functions.IsBotModeMatch(
      GetBot(),
      "team_fight"))

  luaunit.assertTrue(
    functions.IsBotModeMatch(
      GetBot(),
      "team_fight"))

  UNIT_MODE = BOT_MODE_ROAM

  luaunit.assertTrue(
    functions.IsBotModeMatch(
      GetBot(),
      "BOT_MODE_ROAM"))

  UNIT_MODE = BOT_MODE_TEAM_ROAM

  luaunit.assertTrue(
    functions.IsBotModeMatch(
      GetBot(),
      "BOT_MODE_TEAM_ROAM"))

  UNIT_MODE = BOT_MODE_PUSH_TOWER_MID

  luaunit.assertTrue(
    functions.IsBotModeMatch(
      GetBot(),
      "BOT_MODE_PUSH_TOWER"))

  UNIT_MODE = BOT_MODE_DEFEND_TOWER_MID

  luaunit.assertTrue(
    functions.IsBotModeMatch(
      GetBot(),
      "BOT_MODE_DEFEND_TOWER"))

  UNIT_MODE = BOT_MODE_ATTACK

  luaunit.assertTrue(
    functions.IsBotModeMatch(
      GetBot(),
      "BOT_MODE_ATTACK"))
end

function test_IsBotModeMatch_fails()
  test_RefreshBot()

  UNIT_MODE = BOT_MODE_ATTACK

  luaunit.assertFalse(
    functions.IsBotModeMatch(
      GetBot(),
      BOT_MODE_ROAM))

  UNIT_MODE = BOT_MODE_DEFEND_TOWER_MID

  luaunit.assertFalse(
    functions.IsBotModeMatch(
      GetBot(),
      "BOT_MODE_PUSH_TOWER"))

  UNIT_MODE = BOT_MODE_PUSH_TOWER_MID

  luaunit.assertFalse(
    functions.IsBotModeMatch(
      GetBot(),
      "BOT_MODE_DEFEND_TOWER"))

  UNIT_MODE = BOT_MODE_NONE

  luaunit.assertFalse(
    functions.IsBotModeMatch(
      GetBot(),
      BOT_MODE_ATTACK))
end

function test_IsBotInFightingMode_succeed()
  test_RefreshBot()

  local bot = GetBot()

  local test_modes = {
    BOT_MODE_ATTACK,
    BOT_MODE_PUSH_TOWER_TOP,
    BOT_MODE_PUSH_TOWER_MID,
    BOT_MODE_PUSH_TOWER_BOT,
    BOT_MODE_DEFEND_ALLY,
    BOT_MODE_RETREAT,
    BOT_MODE_ROSHAN,
    BOT_MODE_DEFEND_TOWER_TOP,
    BOT_MODE_DEFEND_TOWER_MID,
    BOT_MODE_DEFEND_TOWER_BOT,
    BOT_MODE_EVASIVE_MANEUVERS
  }

  for _, mode in pairs(test_modes) do
    UNIT_MODE = mode
    luaunit.assertTrue(functions.IsBotInFightingMode(bot))
  end
end

function test_IsBotInFightingMode_fails()
  test_RefreshBot()

  local bot = GetBot()

  local test_modes = {
    BOT_MODE_NONE,
    BOT_MODE_LANING,
    BOT_MODE_SECRET_SHOP,
    BOT_MODE_SIDE_SHOP,
    BOT_MODE_ASSEMBLE,
    BOT_MODE_FARM,
    BOT_MODE_ITEM,
    BOT_MODE_WARD
  }

  for _, mode in pairs(test_modes) do
    UNIT_MODE = mode
    luaunit.assertFalse(functions.IsBotInFightingMode(bot))
  end
end

function test_DistanceToDesire_succeed()
  luaunit.assertAlmostEquals(
    functions.DistanceToDesire(2500, 3000, 0.3),
    0.46,
    0.01)

  luaunit.assertAlmostEquals(
    functions.DistanceToDesire(2000, 3000, 0.3),
    0.63,
    0.01)

  luaunit.assertAlmostEquals(
    functions.DistanceToDesire(2999, 3000, 0.3),
    0.3,
    0.01)
end

function test_GetNearestLocation_succeed()
  test_RefreshBot()

  local bot = GetBot()
  local location_1 = {20, 10}
  local location_2 = {10, 10}

  luaunit.assertEquals(
    functions.GetNearestLocation(
      bot,
      {location_1,
       location_2}),
    location_2)
end

function test_GetNormalizedDesire()
  luaunit.assertEquals(functions.GetNormalizedDesire(0.6, 0.7), 0.6)
  luaunit.assertEquals(functions.GetNormalizedDesire(0.8, 0.7), 0.7)
  luaunit.assertEquals(functions.GetNormalizedDesire(0.0, 0.7), 0.0)
end

function test_ComplementOfLists_number_lists_succeed()
  local list1 = {1, 2, 3, 4, 5}
  local list2 = {2, 3, 4}

  luaunit.assertEquals(
    functions.ComplementOfLists(list1, list2),
    {1, 5})
end

function test_ComplementOfLists_unit_lists_succeed()
  test_RefreshBot()

  local bot = GetBot()

  local enemy_creeps = bot:GetNearbyCreeps(1600, true)
  local neutral_creeps = bot:GetNearbyNeutralCreeps(1600)

  local units = functions.ComplementOfLists(
    enemy_creeps,
    neutral_creeps,
    true)

  luaunit.assertEquals(units[1]:GetUnitName(), "creep1")
  luaunit.assertEquals(units[2]:GetUnitName(), "creep2")
  luaunit.assertEquals(units[3]:GetUnitName(), "creep3")
  luaunit.assertEquals(units[4], nil)
end

function test_DoWithKeysAndElements_succeed()
  local list = {1, 2, 3, 4, 5}

  local sum = 0

  functions.DoWithKeysAndElements(
    list,
    function(element) sum = sum + element end)

  luaunit.assertEquals(sum, 15)
end

os.exit(luaunit.LuaUnit.run())
