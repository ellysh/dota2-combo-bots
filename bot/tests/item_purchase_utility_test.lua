package.path = package.path .. ";../utility/?.lua"

require("global_functions")

local item_purchase = require("item_purchase_utility")
local luaunit = require('luaunit')

function test_IsTpScrollPresent()
  test_RefreshBot()

  luaunit.assertFalse(item_purchase.test_IsTpScrollPresent(GetBot()))
end

function test_PurchaseCourier()
  test_RefreshBot()

  item_purchase.test_PurchaseCourier(GetBot())

  luaunit.assertEquals(
    GetBot():GetItemInSlot(1):GetName(),
    "item_courier")
end

function test_PurchaseTpScroll()
  test_RefreshBot()

  item_purchase.test_PurchaseTpScroll(GetBot())

  luaunit.assertEquals(
    GetBot():GetItemInSlot(1):GetName(),
    "item_tpscroll")
end

function test_PurchaseItem_basic()
  test_RefreshBot()

  luaunit.assertTrue(item_purchase.test_PurchaseItem(
    GetBot(),
    "item_tango"))

  luaunit.assertEquals(GetBot():GetItemInSlot(1):GetName(), "item_tango")
end

function test_PurchaseItem_recipe()
  test_RefreshBot()

  luaunit.assertTrue(item_purchase.test_PurchaseItem(
    GetBot(),
    "item_magic_wand"))

  luaunit.assertTrue(item_purchase.test_PurchaseItem(
    GetBot(),
    "item_magic_wand"))

  luaunit.assertTrue(item_purchase.test_PurchaseItem(
    GetBot(),
    "item_magic_wand"))

  luaunit.assertTrue(item_purchase.test_PurchaseItem(
    GetBot(),
    "item_magic_wand"))

  luaunit.assertEquals(
    GetBot():GetItemInSlot(1):GetName(),
    "item_branches")

  luaunit.assertEquals(
    GetBot():GetItemInSlot(2):GetName(),
    "item_branches")

  luaunit.assertEquals(
    GetBot():GetItemInSlot(3):GetName(),
    "item_enchanted_mango")

  luaunit.assertEquals(
    GetBot():GetItemInSlot(4):GetName(),
    "item_magic_stick")
end

function test_FindNextItemToBuy()
  local item_list = {
    "nil",
    "item_tango"
  }

  index, item = item_purchase.test_FindNextItemToBuy(item_list)

  luaunit.assertEquals(index, 2)
  luaunit.assertEquals(item, "item_tango")
end

function test_PurchaseItemList()
  test_RefreshBot()

  local item_list = {
    "nil",
    "item_tango"
  }

  item_purchase.test_PurchaseItemList(GetBot(), item_list)
end

function test_ItemPurchaseThink()
  test_RefreshBot()

  item_purchase.ItemPurchaseThink()

  luaunit.assertEquals(
    GetBot():GetItemInSlot(1):GetName(),
    "item_courier")
end

os.exit(luaunit.LuaUnit.run())
