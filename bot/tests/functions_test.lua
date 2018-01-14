package.path = package.path .. ";../utility/?.lua"

require("global_functions")

local functions = require("functions")
local constants = require("constants")
local luaunit = require('luaunit')

function test_GetItems()
  test_RefreshBot()

  local empty_list = {"nil", "nil", "nil", "nil", "nil", "nil",
                      "nil", "nil", "nil"}

  local bot = GetBot()

  local size, list = functions.GetItems(
      bot,
      constants.INVENTORY_MAX_INDEX)

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
      constants.INVENTORY_MAX_INDEX)

  luaunit.assertEquals(size, 3)

  for i = 1, #list do
    luaunit.assertEquals(bot.inventory[i], list[i])
  end

end

function test_GetItemSlotsCount()
  test_RefreshBot()

  local bot = GetBot()

  luaunit.assertEquals(functions.test_GetItemSlotsCount(bot), 0)

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

  luaunit.assertEquals(functions.test_GetItemSlotsCount(bot), 3)
end

function test_IsInventoryFull()
  test_RefreshBot()

  local bot = GetBot()
  bot.inventory = {}

  luaunit.assertFalse(functions.IsInventoryFull(bot))

  table.insert(bot.inventory, "item_tango")

  luaunit.assertFalse(functions.IsInventoryFull(bot))

  for i = 1, constants.INVENTORY_SIZE - 1, 1 do
    table.insert(bot.inventory, "item_tango")
  end

  luaunit.assertTrue(functions.IsInventoryFull(bot))
end

function test_GetElementIndexInList()
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

function test_IsElementInList()
  local list = {1, 2, 3, 4, 5}

  luaunit.assertTrue(functions.IsElementInList(list, 1))
  luaunit.assertTrue(functions.IsElementInList(list, 2))
  luaunit.assertTrue(functions.IsElementInList(list, 3))
  luaunit.assertTrue(functions.IsElementInList(list, 4))
  luaunit.assertTrue(functions.IsElementInList(list, 5))
  luaunit.assertFalse(functions.IsElementInList(list, 6))
end

function test_IsIntersectionOfLists()
  local list1 = {1, 2, 3, 4, 5}
  local list2 = {3, 4, 5, 6}
  local list3 = {10, 11, 12}

  luaunit.assertTrue(functions.IsIntersectionOfLists(list1, list2))

  luaunit.assertFalse(functions.IsIntersectionOfLists(list1, list3))

  luaunit.assertFalse(functions.IsIntersectionOfLists(list2, list3))
end

function test_IsBotBusy()
  test_RefreshBot()

  local bot = GetBot()

  luaunit.assertFalse(functions.IsBotBusy(bot))

  UNIT_IS_CHANNELING = true
  luaunit.assertTrue(functions.IsBotBusy(bot))

  UNIT_IS_CHANNELING = false
  UNIT_IS_USING_ABILITY = true
  luaunit.assertTrue(functions.IsBotBusy(bot))

  UNIT_IS_USING_ABILITY = false
  UNIT_IS_CASTING_ABILITY = true
  luaunit.assertTrue(functions.IsBotBusy(bot))
end

function test_IsFlagSet()
  local mask = 0x15

  luaunit.assertTrue(functions.test_IsFlagSet(mask, 0x1))
  luaunit.assertTrue(functions.test_IsFlagSet(mask, 0x4))
  luaunit.assertTrue(functions.test_IsFlagSet(mask, 0x10))

  luaunit.assertFalse(functions.test_IsFlagSet(mask, 0x2))
  luaunit.assertFalse(functions.test_IsFlagSet(mask, 0x8))
end

function test_GetAbilityTargetType()
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

function test_GetRandomTrue()
  -- TODO: Improve this test
  luaunit.assertTrue(functions.GetRandomTrue(1.0))
end

function test_GetElementWith()
  test_RefreshBot()

  local unit = functions.GetElementWith(
    GetBot():GetNearbyHeroes(1200, true, BOT_MODE_NONE),
    function(t, a, b) return t[a]:GetHealth() < t[b]:GetHealth() end,
    function(unit) return unit:IsAlive() end)

  luaunit.assertEquals(unit:GetUnitName(), "unit1")
  luaunit.assertEquals(unit:GetHealth(), 10)
end

function test_GetUnitHealthLevel()
  test_RefreshBot()

  local bot = GetBot()

  luaunit.assertEquals(
    functions.GetUnitHealthLevel(bot),
    1.0)

  bot.health = bot.max_health / 2

  luaunit.assertEquals(
    functions.GetUnitHealthLevel(bot),
    0.5)

  bot.health = bot.max_health / 3

  luaunit.assertAlmostEquals(
    functions.GetUnitHealthLevel(bot),
    0.333,
    0.001)
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

os.exit(luaunit.LuaUnit.run())
