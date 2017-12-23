package.path = package.path .. ";../utility/?.lua"

require("global_functions")

local courier = require("courier")
local luaunit = require('luaunit')

function test_IsCourierFree()
  luaunit.assertFalse(courier.test_IsCourierFree(COURIER_STATE_MOVING))

  luaunit.assertFalse(
    courier.test_IsCourierFree(COURIER_STATE_DELIVERING_ITEMS))

  luaunit.assertTrue(courier.test_IsCourierFree(COURIER_STATE_IDLE))
end

function test_IsCourierIdle()
  test_RefreshCourier()

  local c = GetCourier()
  luaunit.assertFalse(courier.test_IsCourierIdle(c, COURIER_STATE_MOVING))

  luaunit.assertFalse(courier.test_IsCourierIdle(
    c,
    COURIER_STATE_DELIVERING_ITEMS))

  TIME = 11
  c.idle_time = 0
  luaunit.assertTrue(courier.test_IsCourierIdle(c, COURIER_STATE_IDLE))
end

function test_IsSecretShopRequired()
  test_RefreshBot()

  luaunit.assertFalse(
    courier.test_IsSecretShopRequired(GetBot()))

  BOT.is_secret_shop_required = true

  luaunit.assertTrue(
    courier.test_IsSecretShopRequired(GetBot()))

  BOT.is_secret_shop_required = true
  BOT_MODE = BOT_MODE_SECRET_SHOP

  luaunit.assertFalse(
    courier.test_IsSecretShopRequired(GetBot()))
end

function test_IsCourierDamaged()
  test_RefreshCourier()

  local c = GetCourier()

  luaunit.assertFalse(courier.test_IsCourierDamaged(c))

  c.health = c.max_health / 2

  luaunit.assertTrue(courier.test_IsCourierDamaged(c))
end

function test_CourierUsageThink()
  test_RefreshCourier()

  -- Courier IDLE test
  courier.CourierUsageThink()
  TIME = 11
  courier.CourierUsageThink()

  luaunit.assertEquals(COURIER_ACTION, COURIER_ACTION_RETURN)
end

os.exit(luaunit.LuaUnit.run())
