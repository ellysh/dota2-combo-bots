package.path = package.path .. ";../utility/?.lua"

require("global_functions")

local functions = require("functions")
local luaunit = require('luaunit')

function test_IsElementInList()
  local list = {1, 2, 3, 4, 5}

  luaunit.assertTrue(functions.IsElementInList(1, list))
  luaunit.assertTrue(functions.IsElementInList(2, list))
  luaunit.assertTrue(functions.IsElementInList(3, list))
  luaunit.assertTrue(functions.IsElementInList(4, list))
  luaunit.assertTrue(functions.IsElementInList(5, list))
  luaunit.assertFalse(functions.IsElementInList(6, list))
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

function test_GetItemSlotsCount()
  test_RefreshBot()

  luaunit.assertEquals(functions.test_GetItemSlotsCount(GetBot()), 0)

  table.insert(GetBot().inventory, "item_tango")
  table.insert(GetBot().inventory, "item_branches")
  table.insert(GetBot().inventory, "item_tango")

  luaunit.assertEquals(functions.test_GetItemSlotsCount(GetBot()), 3)
end

function test_IsItemSlotsFull()
  test_RefreshBot()

  luaunit.assertFalse(functions.IsItemSlotsFull(GetBot()))

  table.insert(GetBot().inventory, "item_tango")

  luaunit.assertFalse(functions.IsItemSlotsFull(GetBot()))

  for i = 0, 8, 1 do
    table.insert(GetBot().inventory, "item_tango")
  end

  luaunit.assertTrue(functions.IsItemSlotsFull(GetBot()))
end

os.exit(luaunit.LuaUnit.run())
