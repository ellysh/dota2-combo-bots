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

  luaunit.assertEquals(mode_shop.GetDesire(true, 0), 1.0)

  luaunit.assertEquals(
    mode_shop.GetDesire(
      true,
      constants.SHOP_WALK_RADIUS / 2),
    0.5)

  luaunit.assertAlmostEquals(
    mode_shop.GetDesire(
      true,
      constants.SHOP_WALK_RADIUS / 3),
    0.666,
    0.001)

  luaunit.assertEquals(
    mode_shop.GetDesire(
      true,
      constants.SHOP_WALK_RADIUS / 4),
    0.75)
end

os.exit(luaunit.LuaUnit.run())
