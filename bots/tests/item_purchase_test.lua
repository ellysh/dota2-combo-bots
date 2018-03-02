package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local luaunit = require("luaunit")
local item_purchase = require("item_purchase")
local constants = require("constants")
local memory = require("memory")

memory.InitPurchaseList(GetBot())

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
  memory.AddItemToBuy(GetBot(), nil)

  item_purchase.test_PurchaseTpScroll(GetBot())

  luaunit.assertEquals(
    memory.GetItemToBuy(GetBot()),
    "item_tpscroll")
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

  memory.SetItemToSell(bot, nil)
  memory.AddItemToBuy(bot, nil)
  item_purchase.test_SellItemByIndex(GetBot(), 1, condition)

  luaunit.assertEquals(memory.GetItemToSell(bot), "item_branches")
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
  memory.AddItemToBuy(bot, nil)
  memory.SetItemToSell(bot, nil)
  item_purchase.test_SellItemByIndex(GetBot(), 1, condition)

  luaunit.assertEquals(memory.GetItemToSell(bot), "item_branches")
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
  memory.AddItemToBuy(bot, nil)
  memory.SetItemToSell(bot, nil)
  item_purchase.test_SellItemByIndex(GetBot(), 1, condition)

  luaunit.assertEquals(memory.GetItemToSell(bot), nil)
end


function test_SetItemToSell_because_of_level_succeed()
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

  memory.AddItemToBuy(bot, nil)
  memory.SetItemToSell(bot, nil)
  item_purchase.test_SetItemToSell(GetBot())

  luaunit.assertEquals(memory.GetItemToSell(bot), "item_branches")
end

function test_SetItemToSell_because_of_buying_new_succeed()
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

  memory.AddItemToBuy(bot, "item_branches")
  memory.SetItemToSell(bot, nil)
  item_purchase.test_SetItemToSell(GetBot())

  luaunit.assertEquals(memory.GetItemToSell(bot), "item_branches")
end

function test_SetItemToSell_when_already_planned_fails()
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

  memory.SetItemToSell(bot, {name = "item_tango"})
  item_purchase.test_SetItemToSell(GetBot())

  luaunit.assertEquals(
    memory.GetItemToSell(bot),
    {name = "item_tango"})
end

function test_PurchaseViaCourier_succeed()
  test_RefreshBot()

  local bot = GetBot()

  memory.AddItemToBuy(bot, "item_branches")

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

  memory.AddItemToBuy(bot, "item_branches")

  COURIER = Unit:new()
  DISTANCE_FROM_SHOP = 200
  UNIT_PURCHASE_RESULT = PURCHASE_ITEM_DISALLOWED_ITEM

  luaunit.assertEquals(
    item_purchase.test_PurchaseViaCourier(bot),
    PURCHASE_ITEM_DISALLOWED_ITEM)
end

function test_PerformSell_sell_succeed()
  test_RefreshBot()

  local bot = GetBot()
  bot.inventory = { "item_branches" }

  DISTANCE_FROM_SHOP = 100

  memory.SetItemToSell(bot, "item_branches")

  item_purchase.test_PerformSell(bot)

  luaunit.assertEquals(memory.GetItemToSell(bot), nil)
  luaunit.assertEquals(bot.inventory[1], "nil")
end

function test_PerformPurchase_succeed()
  test_RefreshBot()

  local bot = GetBot()

  memory.AddItemToBuy(bot, "item_branches")

  COURIER = nil
  item_purchase.test_PerformPurchase(bot)

  luaunit.assertEquals(memory.GetItemToBuy(bot), "item_clarity")
  luaunit.assertEquals(bot.inventory[1], "item_branches")
end

function test_PerformPurchase_too_far_from_shops_fails()
  test_RefreshBot()

  local bot = GetBot()

  DISTANCE_FROM_SHOP = 9000
  memory.AddItemToBuy(bot, "item_branches")

  item_purchase.test_PerformPurchase(bot)

  luaunit.assertEquals(memory.GetItemToBuy(bot), "item_branches")
  luaunit.assertEquals(bot.inventory[1], nil)
end

function test_ItemPurchaseThink()
  test_RefreshBot()

  item_purchase.ItemPurchaseThink()

  luaunit.assertEquals(
    memory.GetItemToBuy(GetBot()),
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

  memory.RemoveItemToBuyIndex(bot)
  memory.SetItemToSell(bot, nil)

  item_purchase.ItemPurchaseThink()

  -- The first item_branches in the inventory should be sold

  luaunit.assertEquals(
    memory.GetItemToSell(bot),
    "item_branches")

  luaunit.assertEquals(
    memory.GetItemToBuy(bot),
    "item_clarity")
end

os.exit(luaunit.LuaUnit.run())
