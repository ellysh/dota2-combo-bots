package.path = package.path .. ";../utility/?.lua"

require("global_functions")

local item_purchase = require("item_purchase_utility")
local luaunit = require('luaunit')

function test_IsTpScrollPresent()
  luaunit.assertFalse(item_purchase.test_IsTpScrollPresent(GetBot()))
end

function test_PurchaseCourier()
  item_purchase.test_PurchaseCourier(GetBot())

  luaunit.assertEquals(PURCHASED_ITEMS[1], "item_courier")
end

function test_PurchaseTpScroll()
  item_purchase.test_PurchaseTpScroll(GetBot())

  luaunit.assertEquals(PURCHASED_ITEMS[1], "item_tpscroll")
end

function test_PurchaseItem_basic()
  luaunit.assertTrue(item_purchase.test_PurchaseItem(
    GetBot(),
    "item_tango"))
end

function test_PurchaseItem_recipe()
  luaunit.assertTrue(item_purchase.test_PurchaseItem(
    GetBot(),
    "item_magic_wand"))
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
  local item_list = {
    "nil",
    "item_tango"
  }

  item_purchase.test_PurchaseItemList(GetBot(), item_list)
end

function test_MPurchaseItem()
  item_purchase.PurchaseItem()

  luaunit.assertEquals(PURCHASED_ITEMS[1], "item_tango")
end

os.exit(luaunit.LuaUnit.run())
