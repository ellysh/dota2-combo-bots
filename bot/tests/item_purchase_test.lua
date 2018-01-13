package.path = package.path .. ";../utility/?.lua"

require("global_functions")

local item_purchase = require("item_purchase")
local constants = require("constants")
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

  local result = item_purchase.test_GetInventoryAndStashItems(GetBot())

  for i = 1, #result - 1 do
    luaunit.assertEquals(BOT.inventory[i], result[i + 1])
  end
end

function test_FindNextComponentToBuy()
  test_RefreshBot()

  luaunit.assertEquals(
    item_purchase.test_FindNextComponentToBuy(
      GetBot(),
      "item_magic_wand"),
    "item_branches")

  table.insert(BOT.inventory, "item_branches")

  luaunit.assertEquals(
    item_purchase.test_FindNextComponentToBuy(
      GetBot(),
      "item_magic_wand"),
    "item_branches")

  table.insert(BOT.inventory, "item_branches")

  luaunit.assertEquals(
    item_purchase.test_FindNextComponentToBuy(
      GetBot(),
      "item_magic_wand"),
    "item_enchanted_mango")

  table.insert(BOT.inventory, "item_enchanted_mango")

  luaunit.assertEquals(
    item_purchase.test_FindNextComponentToBuy(
      GetBot(),
      "item_magic_wand"),
    "item_magic_stick")
end

function test_PurchaseItem_basic()
  test_RefreshBot()

  NEXT_BUY_ITEM = nil
  item_purchase.test_PurchaseItem(GetBot(), "item_tango")

  luaunit.assertEquals(NEXT_BUY_ITEM, "item_tango")
end

function test_PurchaseItem_recipe()
  test_RefreshBot()

  local bot = GetBot()

  NEXT_BUY_ITEM = nil
  item_purchase.test_PurchaseItem(bot, "item_magic_wand")
  luaunit.assertEquals(NEXT_BUY_ITEM, "item_branches")

  table.insert(bot.inventory, "item_branches")

  NEXT_BUY_ITEM = nil
  item_purchase.test_PurchaseItem(bot, "item_magic_wand")
  luaunit.assertEquals(NEXT_BUY_ITEM, "item_branches")

  table.insert(bot.inventory, "item_branches")

  NEXT_BUY_ITEM = nil
  item_purchase.test_PurchaseItem(bot, "item_magic_wand")
  luaunit.assertEquals(NEXT_BUY_ITEM, "item_enchanted_mango")

  table.insert(bot.inventory, "item_enchanted_mango")

  NEXT_BUY_ITEM = nil
  item_purchase.test_PurchaseItem(bot, "item_magic_wand")
  luaunit.assertEquals(NEXT_BUY_ITEM, "item_magic_stick")
end

function test_PurchaseItem_recipe_from_recipe_component()
  test_RefreshBot()

  local bot = GetBot()
  bot.gold = 9000

  NEXT_BUY_ITEM = nil
  item_purchase.test_PurchaseItem(GetBot(), "item_lotus_orb")
  luaunit.assertEquals(NEXT_BUY_ITEM, "item_void_stone")

  table.insert(bot.inventory, "item_void_stone")

  NEXT_BUY_ITEM = nil
  item_purchase.test_PurchaseItem(GetBot(), "item_lotus_orb")
  luaunit.assertEquals(NEXT_BUY_ITEM, "item_ring_of_health")

  table.insert(bot.inventory, "item_pers")

  NEXT_BUY_ITEM = nil
  item_purchase.test_PurchaseItem(GetBot(), "item_lotus_orb")
  luaunit.assertEquals(NEXT_BUY_ITEM, "item_platemail")

  table.insert(bot.inventory, "item_platemail")

  NEXT_BUY_ITEM = nil
  item_purchase.test_PurchaseItem(GetBot(), "item_lotus_orb")
  luaunit.assertEquals(NEXT_BUY_ITEM, "item_energy_booster")

  table.insert(bot.inventory, "item_energy_booster")
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

function test_SellItemByIndex_level_match()
  test_RefreshBot()

  local npc_bot = GetBot()
  npc_bot.level = 15

  npc_bot.inventory = {
    "item_tango",
    "item_branches"
  }

  local condition = {
    level = 15,
    time = 30
  }

  NEXT_SELL_ITEM = nil
  item_purchase.test_SellItemByIndex(GetBot(), 2, condition)

  luaunit.assertEquals(
    NEXT_SELL_ITEM, {name = "item_branches"})
end

function test_SellItemByIndex_time_match()
  test_RefreshBot()

  BOT.inventory = {
    "item_tango",
    "item_branches"
  }

  local condition = {
    level = 15,
    time = 30
  }

  TIME = 30 * 60
  NEXT_SELL_ITEM = nil
  item_purchase.test_SellItemByIndex(GetBot(), 2, condition)

  luaunit.assertEquals(
    NEXT_SELL_ITEM, {name = "item_branches"})
end

function test_SellExtraItem()
  test_RefreshBot()

  local npc_bot = GetBot()
  npc_bot.level = 15

  npc_bot.inventory = {
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
    "item_branches",
    "item_branches"
  }

  NEXT_SELL_ITEM = nil
  item_purchase.test_SellExtraItem(GetBot())

  luaunit.assertEquals(NEXT_SELL_ITEM, {name = "item_branches"})
end

function test_ItemPurchaseThink()
  test_RefreshBot()

  item_purchase.ItemPurchaseThink()

  luaunit.assertEquals(
    GetBot():GetItemInSlot(1):GetName(),
    "item_tpscroll")
end

function test_ItemPurchaseThink_with_full_inventory()
  test_RefreshBot()

  local npc_bot = GetBot()
  npc_bot.level = 15
  npc_bot.gold = 9000

  npc_bot.inventory = {
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
    "item_branches",
    "item_branches"
  }

  NEXT_BUY_ITEM = nil

  item_purchase.ItemPurchaseThink()

  -- The first item_branches in the inventory should be sold

  luaunit.assertEquals(
    NEXT_BUY_ITEM,
    "item_tango")
end

os.exit(luaunit.LuaUnit.run())
