package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local item_purchase = require("item_purchase")
local constants = require("constants")
local functions = require("functions")
local luaunit = require('luaunit')

function test_IsTpScrollPresent()
  test_RefreshBot()

  luaunit.assertFalse(item_purchase.test_IsTpScrollPresent(GetBot()))
end

function test_PurchaseCourier()
  test_RefreshBot()

  COURIER = nil
  item_purchase.test_PurchaseCourier(GetBot())

  luaunit.assertEquals(
    GetBot():GetItemInSlot(0):GetName(),
    "item_courier")
end

function test_PurchaseTpScroll()
  test_RefreshBot()

  ITEM_COST = 50
  functions.SetItemToBuy(GetBot(), nil)

  item_purchase.test_PurchaseTpScroll(GetBot())

  luaunit.assertEquals(
    functions.GetItemToBuy(GetBot()),
    "item_tpscroll")
end

function test_PurchaseTpScroll_when_another_item_in_purchase_slot_fails()
  test_RefreshBot()

  ITEM_COST = 50
  functions.SetItemToBuy(GetBot(), "item_branches")

  item_purchase.test_PurchaseTpScroll(GetBot())

  luaunit.assertEquals(
    functions.GetItemToBuy(GetBot()),
    "item_branches")
end

function test_IsRecipeItem()
  luaunit.assertFalse(item_purchase.test_IsRecipeItem("item_tango"))

  luaunit.assertFalse(item_purchase.test_IsRecipeItem("item_branches"))

  luaunit.assertTrue(item_purchase.test_IsRecipeItem("item_magic_wand"))
end

function test_IsItemAlreadyBought()
  local inventory = {
    "item_tango",
    "item_branches"
  }

  luaunit.assertFalse(
    item_purchase.test_IsItemAlreadyBought(inventory, "item_tpscroll"))

  luaunit.assertEquals(inventory[1], "item_tango")
  luaunit.assertEquals(inventory[2], "item_branches")

  luaunit.assertTrue(
    item_purchase.test_IsItemAlreadyBought(inventory, "item_tango"))

  luaunit.assertEquals(inventory[1], "nil")
  luaunit.assertEquals(inventory[2], "item_branches")
end

function test_GetInventoryAndStashItems()
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
    "nil",
    "nil",
    "nil",
    "item_tango",
    "nil",
    "item_branches",
  }

  local result = item_purchase.test_GetInventoryAndStashItems(bot)

  luaunit.assertEquals(#bot.inventory, #result)

  for i = 1, #result do
    luaunit.assertEquals(bot.inventory[i], result[i])
  end
end

function test_FindNextComponentToBuy()
  test_RefreshBot()

  local bot = GetBot()

  luaunit.assertEquals(
    item_purchase.test_FindNextComponentToBuy(bot, "item_magic_wand"),
    "item_branches")

  table.insert(bot.inventory, "item_branches")

  luaunit.assertEquals(
    item_purchase.test_FindNextComponentToBuy(bot, "item_magic_wand"),
    "item_branches")

  table.insert(bot.inventory, "item_branches")

  luaunit.assertEquals(
    item_purchase.test_FindNextComponentToBuy(bot, "item_magic_wand"),
    "item_enchanted_mango")

  table.insert(bot.inventory, "item_enchanted_mango")

  luaunit.assertEquals(
    item_purchase.test_FindNextComponentToBuy(bot, "item_magic_wand"),
    "item_magic_stick")

  table.insert(bot.inventory, "item_magic_stick")

  luaunit.assertEquals(
    item_purchase.test_FindNextComponentToBuy(bot, "item_magic_wand"),
    "nil")
end

function test_PurchaseItem_when_nil_item_fails()
  test_RefreshBot()

  local bot = GetBot()

  functions.SetItemToBuy(bot, nil)
  item_purchase.test_PurchaseItem(bot, "nil")

  luaunit.assertEquals(functions.GetItemToBuy(bot), nil)
end

function test_PurchaseItem_when_not_enough_gold_succeed()
  test_RefreshBot()

  local bot = GetBot()

  bot.gold = 0
  functions.SetItemToBuy(bot, nil)
  item_purchase.test_PurchaseItem(bot, "item_magic_stick")

  luaunit.assertEquals(functions.GetItemToBuy(bot), "item_magic_stick")
end

function test_PurchaseItem_basic()
  test_RefreshBot()

  local bot = GetBot()

  functions.SetItemToBuy(bot, nil)
  item_purchase.test_PurchaseItem(bot, "item_tango")

  luaunit.assertEquals(functions.GetItemToBuy(bot), "item_tango")
end

function test_PurchaseItem_recipe()
  test_RefreshBot()

  local bot = GetBot()

  functions.SetItemToBuy(bot, nil)
  item_purchase.test_PurchaseItem(bot, "item_magic_wand")
  luaunit.assertEquals(functions.GetItemToBuy(bot), "item_branches")

  table.insert(bot.inventory, "item_branches")

  functions.SetItemToBuy(bot, nil)
  item_purchase.test_PurchaseItem(bot, "item_magic_wand")
  luaunit.assertEquals(functions.GetItemToBuy(bot), "item_branches")

  table.insert(bot.inventory, "item_branches")

  functions.SetItemToBuy(bot, nil)
  item_purchase.test_PurchaseItem(bot, "item_magic_wand")
  luaunit.assertEquals(
    functions.GetItemToBuy(bot),
    "item_enchanted_mango")

  table.insert(bot.inventory, "item_enchanted_mango")

  functions.SetItemToBuy(bot, nil)
  item_purchase.test_PurchaseItem(bot, "item_magic_wand")
  luaunit.assertEquals(functions.GetItemToBuy(bot), "item_magic_stick")
end

function test_PurchaseItem_recipe_from_recipe_component()
  test_RefreshBot()

  local bot = GetBot()
  bot.gold = 9000

  functions.SetItemToBuy(bot, nil)
  item_purchase.test_PurchaseItem(bot, "item_lotus_orb")
  luaunit.assertEquals(functions.GetItemToBuy(bot), "item_void_stone")

  table.insert(bot.inventory, "item_void_stone")

  functions.SetItemToBuy(bot, nil)
  item_purchase.test_PurchaseItem(bot, "item_lotus_orb")
  luaunit.assertEquals(functions.GetItemToBuy(bot), "item_ring_of_health")

  table.insert(bot.inventory, "item_pers")

  functions.SetItemToBuy(bot, nil)
  item_purchase.test_PurchaseItem(bot, "item_lotus_orb")
  luaunit.assertEquals(functions.GetItemToBuy(bot), "item_platemail")

  table.insert(bot.inventory, "item_platemail")

  functions.SetItemToBuy(bot, nil)
  item_purchase.test_PurchaseItem(bot, "item_lotus_orb")
  luaunit.assertEquals(functions.GetItemToBuy(bot), "item_energy_booster")

  table.insert(bot.inventory, "item_energy_booster")
end

function test_PurchaseItem_when_inventory_full_succeed()
  -- This behavior is required for a bot to make a decision that he should
  -- sell something. After the PurchaseItem call, he has a full inventory
  -- and an item in the "purchase slot".

  test_RefreshBot()

  local bot = GetBot()

  bot.inventory = {
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches"
  }

  functions.SetItemToBuy(bot, nil)
  functions.SetItemToSell(bot, nil)
  item_purchase.test_PurchaseItem(bot, "item_tango")

  luaunit.assertEquals(
    functions.GetItemToBuy(bot),
    "item_tango")
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

function test_FindNextItemToBuy_with_empty_list_fails()
  local item_list = {
    "nil",
    "nil"
  }

  index, item = item_purchase.test_FindNextItemToBuy(item_list)

  luaunit.assertEquals(index, -1)
  luaunit.assertEquals(item, "nil")
end

function test_PurchaseItemList()
  test_RefreshBot()

  local bot = GetBot()

  bot.inventory = {}

  COURIER = Unit:new()
  functions.SetItemToBuy(bot, nil)
  item_purchase.test_PurchaseItemList(bot)

  luaunit.assertEquals(
    functions.GetItemToBuy(bot),
    "item_tango")
end

function test_PurchaseItemList_for_already_bought_item_fails()
  test_RefreshBot()

  local bot = GetBot()
  bot.inventory = { "item_tango" }

  functions.SetItemToBuy(bot, nil)
  item_purchase.test_PurchaseItemList(bot)

  luaunit.assertEquals(functions.GetItemToBuy(bot), nil)
end

function test_SellItemByIndex_level_match()
  test_RefreshBot()

  local bot = GetBot()
  bot.level = 15

  bot.inventory = {
    "item_tango",
    "item_branches"
  }

  local condition = {
    level = 15,
    time = 30
  }

  functions.SetItemToSell(bot, nil)
  functions.SetItemToBuy(bot, nil)
  item_purchase.test_SellItemByIndex(GetBot(), 1, condition)

  luaunit.assertEquals(functions.GetItemToSell(bot), "item_branches")
end

function test_SellItemByIndex_time_match()
  test_RefreshBot()

  local bot = GetBot()

  bot.inventory = {
    "item_tango",
    "item_branches"
  }

  local condition = {
    level = 15,
    time = 30
  }

  TIME = 30 * 60
  functions.SetItemToBuy(bot, nil)
  functions.SetItemToSell(bot, nil)
  item_purchase.test_SellItemByIndex(GetBot(), 1, condition)

  luaunit.assertEquals(functions.GetItemToSell(bot), "item_branches")
end

function test_SellItemByIndex_all_checks_fails()
  test_RefreshBot()

  local bot = GetBot()

  bot.inventory = {
    "item_tango",
    "item_branches"
  }

  local condition = {
    level = 15,
    time = 30
  }

  TIME = 1
  functions.SetItemToBuy(bot, nil)
  functions.SetItemToSell(bot, nil)
  item_purchase.test_SellItemByIndex(GetBot(), 1, condition)

  luaunit.assertEquals(functions.GetItemToSell(bot), nil)
end


function test_SellExtraItem_because_of_level_succeed()
  test_RefreshBot()

  local bot = GetBot()
  bot.level = 15
  TIME = 1

  bot.inventory = {
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches"
  }

  functions.SetItemToBuy(bot, nil)
  functions.SetItemToSell(bot, nil)
  item_purchase.test_SellExtraItem(GetBot())

  luaunit.assertEquals(functions.GetItemToSell(bot), "item_branches")
end

function test_SellExtraItem_because_of_buying_new_succeed()
  test_RefreshBot()

  local bot = GetBot()
  bot.level = 1
  TIME = 1

  bot.inventory = {
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches"
  }

  functions.SetItemToBuy(bot, "item_branches")
  functions.SetItemToSell(bot, nil)
  item_purchase.test_SellExtraItem(GetBot())

  luaunit.assertEquals(functions.GetItemToSell(bot), "item_branches")
end

function test_SellExtraItem_when_already_planned_fails()
  test_RefreshBot()

  local bot = GetBot()
  bot.level = 1
  TIME = 1

  bot.inventory = {
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_tango"
  }

  functions.SetItemToBuy(bot, "item_branches")
  functions.SetItemToSell(bot, {name = "item_tango"})
  item_purchase.test_SellExtraItem(GetBot())

  luaunit.assertEquals(
    functions.GetItemToSell(bot),
    {name = "item_tango"})
end

function test_PurchaseViaCourier_succeed()
  test_RefreshBot()

  local bot = GetBot()

  functions.SetItemToBuy(bot, "item_branches")

  COURIER = Unit:new()
  DISTANCE_FROM_SHOP = 200
  UNIT_PURCHASE_RESULT = PURCHASE_ITEM_SUCCESS

  luaunit.assertEquals(
    item_purchase.test_PurchaseViaCourier(bot),
    PURCHASE_ITEM_SUCCESS)
end

function test_PurchaseViaCourier_fails()
  test_RefreshBot()

  local bot = GetBot()

  functions.SetItemToBuy(bot, "item_branches")

  COURIER = Unit:new()
  DISTANCE_FROM_SHOP = 200
  UNIT_PURCHASE_RESULT = PURCHASE_ITEM_DISALLOWED_ITEM

  luaunit.assertEquals(
    item_purchase.test_PurchaseViaCourier(bot),
    PURCHASE_ITEM_DISALLOWED_ITEM)
end

function test_PerformPlannedPurchaseAndSell_sell_succeed()
  test_RefreshBot()

  local bot = GetBot()
  bot.inventory = { "item_branches" }

  functions.SetItemToSell(bot, "item_branches")

  item_purchase.test_PerformPlannedPurchaseAndSell(bot)

  luaunit.assertEquals(functions.GetItemToSell(bot), nil)
  luaunit.assertEquals(bot.inventory[1], "nil")
end

function test_PerformPlannedPurchaseAndSell_buy_succeed()
  test_RefreshBot()

  local bot = GetBot()

  functions.SetItemToBuy(bot, "item_branches")
  functions.SetItemToSell(bot, nil)

  COURIER = nil
  item_purchase.test_PerformPlannedPurchaseAndSell(bot)

  luaunit.assertEquals(functions.GetItemToBuy(bot), nil)
  luaunit.assertEquals(bot.inventory[1], "item_branches")
end

function test_PerformPlannedPurchaseAndSell_too_far_from_shops_fails()
  test_RefreshBot()

  local bot = GetBot()

  DISTANCE_FROM_SHOP = 9000
  functions.SetItemToBuy(bot, "item_branches")

  item_purchase.test_PerformPlannedPurchaseAndSell(bot)

  luaunit.assertEquals(functions.GetItemToBuy(bot), "item_branches")
  luaunit.assertEquals(bot.inventory[1], nil)
end

function test_ItemPurchaseThink()
  test_RefreshBot()

  item_purchase.ItemPurchaseThink()

  luaunit.assertEquals(
    functions.GetItemToBuy(GetBot()),
    "item_tpscroll")
end

function test_ItemPurchaseThink_with_full_inventory()
  test_RefreshBot()

  local bot = GetBot()
  bot.level = 15
  bot.gold = 9000

  bot.inventory = {
    "item_tpscroll",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
    "item_branches",
  }

  functions.SetItemToBuy(bot, nil)
  functions.SetItemToSell(bot, nil)

  item_purchase.ItemPurchaseThink()

  -- The first item_branches in the inventory should be sold

  luaunit.assertEquals(
    functions.GetItemToSell(bot),
    "item_branches")

  luaunit.assertEquals(
    functions.GetItemToBuy(bot),
    "item_tango")
end

os.exit(luaunit.LuaUnit.run())
