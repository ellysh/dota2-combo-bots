package.path = package.path .. ";../utility/?.lua"

require("global_functions")

local mode_shop = require("mode_shop")
local constants = require("constants")
local luaunit = require('luaunit')

function test_GetDesire_null()
  test_RefreshBot()

  IS_CHANNELING = true
  luaunit.assertEquals(mode_shop.GetDesire(false, 0), 0)

  IS_CHANNELING = false
  luaunit.assertEquals(mode_shop.GetDesire(false, 0), 0)

  WAS_DAMAGED = true
  luaunit.assertEquals(mode_shop.GetDesire(true, 0), 0)

  WAS_DAMAGED = false
  luaunit.assertEquals(
    mode_shop.GetDesire(
      true,
      constants.SHOP_WALK_RADIUS + 1),
    0)
end

function test_GetDesire_positive()
  test_RefreshBot()

  luaunit.assertEquals(mode_shop.GetDesire(true, 0), 1.2)

  luaunit.assertEquals(
    mode_shop.GetDesire(
      true,
      constants.SHOP_WALK_RADIUS / 2),
    0.7)

  luaunit.assertAlmostEquals(
    mode_shop.GetDesire(
      true,
      constants.SHOP_WALK_RADIUS / 3),
    0.866,
    0.001)

  luaunit.assertEquals(
    mode_shop.GetDesire(
      true,
      constants.SHOP_WALK_RADIUS / 4),
    0.95)
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

function test_ThinkSideShop()
  test_RefreshBot()

  mode_shop.ThinkSideShop()

  luaunit.assertEquals(BOT_ACTION, BOT_ACTION_TYPE_MOVE_TO)

  luaunit.assertEquals(BOT_MOVE_LOCATION, {10, 10})
end

os.exit(luaunit.LuaUnit.run())
