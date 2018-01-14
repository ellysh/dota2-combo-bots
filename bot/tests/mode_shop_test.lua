package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local mode_shop = require("mode_shop")
local constants = require("constants")
local functions = require("functions")
local luaunit = require('luaunit')

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

  luaunit.assertEquals(mode_shop.GetDesireSideShop(), 1.0)
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
end

function test_Think()
  test_RefreshBot()

  DISTANCE_FROM_SHOP = 1000
  mode_shop.ThinkSideShop()

  luaunit.assertEquals(BOT_ACTION, BOT_ACTION_TYPE_MOVE_TO)

  luaunit.assertEquals(BOT_MOVE_LOCATION, {10, 10})
end

os.exit(luaunit.LuaUnit.run())
