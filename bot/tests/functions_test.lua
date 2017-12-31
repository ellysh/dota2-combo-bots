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
    functions.GetElementIndexInList(5, list),
    1)

  luaunit.assertEquals(
    functions.GetElementIndexInList(4, list),
    2)

  luaunit.assertEquals(
    functions.GetElementIndexInList(3, list),
    3)

  luaunit.assertEquals(
    functions.GetElementIndexInList(2, list),
    4)

  luaunit.assertEquals(
    functions.GetElementIndexInList(1, list),
    5)

  luaunit.assertEquals(
    functions.GetElementIndexInList(0, list),
    -1)
end

function test_IsElementInList()
  local list = {1, 2, 3, 4, 5}

  luaunit.assertTrue(functions.IsElementInList(1, list))
  luaunit.assertTrue(functions.IsElementInList(2, list))
  luaunit.assertTrue(functions.IsElementInList(3, list))
  luaunit.assertTrue(functions.IsElementInList(4, list))
  luaunit.assertTrue(functions.IsElementInList(5, list))
  luaunit.assertFalse(functions.IsElementInList(6, list))
end

function test_IsBotBusy()
  test_RefreshBot()

  luaunit.assertFalse(functions.IsBotBusy(GetBot()))

  IS_CHANNELING = true
  luaunit.assertTrue(functions.IsBotBusy(GetBot()))

  IS_CHANNELING = false
  IS_USING_ABILITY = true
  luaunit.assertTrue(functions.IsBotBusy(GetBot()))

  IS_USING_ABILITY = false
  IS_CASTING_ABILITY = true
  luaunit.assertTrue(functions.IsBotBusy(GetBot()))
end

function test_IsFlagSet()
  local mask = 0x15

  luaunit.assertTrue(functions.IsFlagSet(mask, 0x1))
  luaunit.assertTrue(functions.IsFlagSet(mask, 0x4))
  luaunit.assertTrue(functions.IsFlagSet(mask, 0x10))

  luaunit.assertFalse(functions.IsFlagSet(mask, 0x2))
  luaunit.assertFalse(functions.IsFlagSet(mask, 0x8))
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

os.exit(luaunit.LuaUnit.run())
