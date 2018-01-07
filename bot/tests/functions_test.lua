package.path = package.path .. ";../utility/?.lua"

require("global_functions")

local functions = require("functions")
local constants = require("constants")
local luaunit = require('luaunit')

function test_GetItems()
  test_RefreshBot()

  local empty_list = {"nil", "nil", "nil", "nil", "nil", "nil",
                      "nil", "nil", "nil"}

  local size, list = functions.GetItems(
      GetBot(),
      constants.INVENTORY_SIZE)

  luaunit.assertEquals(size, 0)
  luaunit.assertEquals(list, empty_list)

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

  size, list = functions.GetItems(
      GetBot(),
      constants.INVENTORY_SIZE)

  luaunit.assertEquals(size, 3)

  for i = 1, #list - 1 do
    luaunit.assertEquals(BOT.inventory[i], list[i + 1])
  end

end

function test_GetItemSlotsCount()
  test_RefreshBot()

  luaunit.assertEquals(functions.test_GetItemSlotsCount(GetBot()), 0)

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

  luaunit.assertEquals(functions.test_GetItemSlotsCount(GetBot()), 3)
end

function test_IsItemSlotsFull()
  test_RefreshBot()

  luaunit.assertFalse(functions.IsItemSlotsFull(GetBot()))

  table.insert(GetBot().inventory, "item_tango")

  luaunit.assertFalse(functions.IsItemSlotsFull(GetBot()))

  for i = 0, constants.INVENTORY_SIZE, 1 do
    table.insert(GetBot().inventory, "item_tango")
  end

  luaunit.assertTrue(functions.IsItemSlotsFull(GetBot()))
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

function test_IsBotBusy()
  test_RefreshBot()

  luaunit.assertFalse(functions.IsBotBusy(GetBot()))

  UNIT_IS_CHANNELING = true
  luaunit.assertTrue(functions.IsBotBusy(GetBot()))

  UNIT_IS_CHANNELING = false
  UNIT_IS_USING_ABILITY = true
  luaunit.assertTrue(functions.IsBotBusy(GetBot()))

  UNIT_IS_USING_ABILITY = false
  UNIT_IS_CASTING_ABILITY = true
  luaunit.assertTrue(functions.IsBotBusy(GetBot()))
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

  BOT.inventory = {
    "item_tango",
    "item_branches",
    "nil",
    "nil",
    "nil",
    "nil",
    "nil",
    "nil",
    "nil",
    "nil",
    "nil",
    "nil",
    "nil",
    "item_tango",
    "nil",
    "item_branches",
  }

  local result = functions.GetInventoryItems(GetBot())

  for i = 1, #result - 1 do
    luaunit.assertEquals(BOT.inventory[i], result[i + 1])
  end
end

function test_GetRandomTrue()
  -- TODO: Improve this test
  luaunit.assertTrue(functions.GetRandomTrue(1.0))
end

os.exit(luaunit.LuaUnit.run())
