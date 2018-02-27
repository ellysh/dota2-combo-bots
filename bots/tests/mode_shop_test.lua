package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local luaunit = require("luaunit")
local mode_shop = require("mode_shop")
local constants = require("constants")
local memory = require("memory")

memory.MakePurchaseList(GetBot())

function test_IsShopRequired_item_to_buy_succeed()
  test_RefreshBot()

  local bot = GetBot()

  memory.AddItemToBuy(bot, "item_boots")
  IS_SIDE_SHOP_ITEM = true
  UNIT_MODE = BOT_MODE_NONE

  luaunit.assertTrue(
    mode_shop.test_IsShopRequired(
      bot,
      IsItemPurchasedFromSideShop))
end

function test_IsShopRequired_item_to_sell_succeed()
  test_RefreshBot()

  local bot = GetBot()
  memory.AddItemToBuy(bot, nil)
  memory.SetItemToSell(bot, "item_boots")
  UNIT_MODE = BOT_MODE_NONE

  luaunit.assertTrue(
    mode_shop.test_IsShopRequired(
      bot,
      IsItemPurchasedFromSideShop))
end

function test_GetDesire_in_fight_mode_negative()
  test_RefreshBot()

  memory.AddItemToBuy(GetBot(), "item_boots")
  IS_SIDE_SHOP_ITEM = true
  UNIT_MODE = BOT_MODE_ATTACK
  UNIT_HAS_NEARBY_UNITS = false

  luaunit.assertEquals(
    mode_shop.test_GetDesire(
      IsItemPurchasedFromSideShop,
      {1500, 1500},
      0.3),
    0)
end

function test_GetDesire_succeed()
  test_RefreshBot()

  memory.AddItemToBuy(GetBot(), "item_boots")
  IS_SIDE_SHOP_ITEM = true
  UNIT_MODE = BOT_MODE_NONE
  UNIT_HAS_NEARBY_UNITS = false

  luaunit.assertAlmostEquals(
    mode_shop.test_GetDesire(
      IsItemPurchasedFromSideShop,
      {1600, 1600},
      0.3),
    0.56,
    0.01)
end

function test_GetDesireSideShop_negative()
  test_RefreshBot()

  UNIT_IS_CHANNELING = true
  luaunit.assertEquals(mode_shop.GetDesireSideShop(), 0)

  UNIT_IS_CHANNELING = false
  luaunit.assertEquals(mode_shop.GetDesireSideShop(), 0)

  UNIT_WAS_DAMAGED = true
  luaunit.assertEquals(mode_shop.GetDesireSideShop(), 0)

  UNIT_WAS_DAMAGED = false
  luaunit.assertEquals(mode_shop.GetDesireSideShop(), 0)
end

function test_GetDesireSideShop_positive()
  test_RefreshBot()

  memory.AddItemToBuy(GetBot(), "item_boots")
  IS_SIDE_SHOP_ITEM = true

  luaunit.assertEquals(
    mode_shop.GetDesireSideShop(),
    constants.MAX_SHOP_DESIRE)
end

function test_GetDesireSecretShop_positive()
  test_RefreshBot()

  memory.AddItemToBuy(GetBot(), "item_vitality_booster")
  IS_SECRET_SHOP_ITEM = true

  luaunit.assertEquals(
    mode_shop.GetDesireSecretShop(),
    constants.MAX_SHOP_DESIRE)
end

function test_ThinkSideShop()
  test_RefreshBot()

  DISTANCE_FROM_SHOP = 1000
  mode_shop.ThinkSideShop()

  luaunit.assertEquals(BOT_ACTION, BOT_ACTION_TYPE_MOVE_TO)

  luaunit.assertEquals(UNIT_MOVE_LOCATION, {10, 10})
end

function test_ThinkSecretShop()
  test_RefreshBot()

  mode_shop.ThinkSecretShop()

  luaunit.assertEquals(BOT_ACTION, BOT_ACTION_TYPE_MOVE_TO)

  luaunit.assertEquals(UNIT_MOVE_LOCATION, {10, 10})
end

os.exit(luaunit.LuaUnit.run())
