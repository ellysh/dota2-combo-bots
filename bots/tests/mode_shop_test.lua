package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local mode_shop = require("mode_shop")
local constants = require("constants")
local functions = require("functions")
local luaunit = require('luaunit')

function test_IsBotInFightingMode_succeed()
  test_RefreshBot()

  local bot = GetBot()

  local test_modes = {
    BOT_MODE_ATTACK,
    BOT_MODE_PUSH_TOWER_TOP,
    BOT_MODE_PUSH_TOWER_MID,
    BOT_MODE_PUSH_TOWER_BOT,
    BOT_MODE_DEFEND_ALLY,
    BOT_MODE_RETREAT,
    BOT_MODE_ROSHAN,
    BOT_MODE_DEFEND_TOWER_TOP,
    BOT_MODE_DEFEND_TOWER_MID,
    BOT_MODE_DEFEND_TOWER_BOT
  }

  for _, mode in pairs(test_modes) do
    BOT_MODE = mode
    luaunit.assertTrue(mode_shop.test_IsBotInFightingMode(bot))
  end
end

function test_GetDesire_in_fight_mode_negative()
  test_RefreshBot()

  functions.SetItemToBuy(GetBot(), "item_boots")
  IS_SIDE_SHOP_ITEM = true
  DISTANCE_FROM_SHOP = 2000
  BOT_MODE = BOT_MODE_ATTACK

  luaunit.assertEquals(
    mode_shop.test_GetDesire(
      IsItemPurchasedFromSideShop,
      "DistanceFromSideShop",
      0.3),
    0)
end

function test_GetDesire_succeed()
  test_RefreshBot()

  functions.SetItemToBuy(GetBot(), "item_boots")
  IS_SIDE_SHOP_ITEM = true
  DISTANCE_FROM_SHOP = 2000
  BOT_MODE = BOT_MODE_NONE

  luaunit.assertAlmostEquals(
    mode_shop.test_GetDesire(
      IsItemPurchasedFromSideShop,
      "DistanceFromSideShop",
      0.3),
    0.63,
    0.01)
end

function test_GetDesireSideShop_negative()
  test_RefreshBot()

  UNIT_IS_CHANNELING = true
  luaunit.assertEquals(mode_shop.GetDesireSideShop(), 0)

  UNIT_IS_CHANNELING = false
  luaunit.assertEquals(mode_shop.GetDesireSideShop(), 0)

  WAS_DAMAGED = true
  luaunit.assertEquals(mode_shop.GetDesireSideShop(), 0)

  WAS_DAMAGED = false
  luaunit.assertEquals(mode_shop.GetDesireSideShop(), 0)
end

function test_GetDesireSideShop_positive()
  test_RefreshBot()

  functions.SetItemToBuy(GetBot(), "item_boots")
  IS_SIDE_SHOP_ITEM = true

  luaunit.assertEquals(mode_shop.GetDesireSideShop(), 0.9)
end

function test_GetDesireSecretShop_positive()
  test_RefreshBot()

  functions.SetItemToBuy(GetBot(), "item_vitality_booster")
  IS_SECRET_SHOP_ITEM = true

  luaunit.assertEquals(mode_shop.GetDesireSecretShop(), 0.9)
end

function test_GetNearestLocation()
  test_RefreshBot()

  local location_1 = {20, 10}
  local location_2 = {10, 10}

  luaunit.assertEquals(
    mode_shop.test_GetNearestLocation(
      GetBot(),
      location_1,
      location_2),
    location_2)

  luaunit.assertEquals(
    mode_shop.test_GetNearestLocation(
      GetBot(),
      location_2,
      location_1),
    location_2)
end

function test_ThinkSideShop()
  test_RefreshBot()

  DISTANCE_FROM_SHOP = 1000
  mode_shop.ThinkSideShop()

  luaunit.assertEquals(BOT_ACTION, BOT_ACTION_TYPE_MOVE_TO)

  luaunit.assertEquals(BOT_MOVE_LOCATION, {10, 10})
end

function test_ThinkSecretShop()
  test_RefreshBot()

  DISTANCE_FROM_SHOP = 1000
  mode_shop.ThinkSecretShop()

  luaunit.assertEquals(BOT_ACTION, BOT_ACTION_TYPE_MOVE_TO)

  luaunit.assertEquals(BOT_MOVE_LOCATION, {10, 10})
end

os.exit(luaunit.LuaUnit.run())
