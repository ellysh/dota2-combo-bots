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

  BOT.is_secret_shop_mode = true

  luaunit.assertTrue(
    courier.test_IsSecretShopRequired(GetBot()))

  BOT.is_secret_shop_mode = true
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

function test_CourierUsageThink_no_action()
  test_RefreshCourier()
  test_RefreshBot()

  local bot = GetBot()
  bot.is_alive = false

  COURIER_ACTION = nil
  courier.CourierUsageThink()
  luaunit.assertEquals(COURIER_ACTION, nil)

  COURIER_STATE = COURIER_STATE_DEAD
  COURIER_ACTION = nil
  courier.CourierUsageThink()
  luaunit.assertEquals(COURIER_ACTION, nil)

  COURIER = nil
  COURIER_ACTION = nil
  courier.CourierUsageThink()
  luaunit.assertEquals(COURIER_ACTION, nil)
end

function test_CourierUsageThink_return_action()
  test_RefreshCourier()
  test_RefreshBot()

  COURIER_STATE = COURIER_STATE_IDLE
  TIME = 0
  courier.CourierUsageThink()

  TIME = 11
  COURIER_ACTION = nil
  courier.CourierUsageThink()

  luaunit.assertEquals(COURIER_ACTION, COURIER_ACTION_RETURN)
end

function test_CourierUsageThink_burst_action()
  test_RefreshCourier()
  test_RefreshBot()

  local c = GetCourier()
  c.health = c.max_health / 2

  COURIER_ACTION = nil
  courier.CourierUsageThink()

  luaunit.assertEquals(COURIER_ACTION, COURIER_ACTION_BURST)
end

function test_CourierUsageThink_transfer_action()
  test_RefreshCourier()
  test_RefreshBot()

  COURIER_ACTION = nil
  COURIER_STATE = COURIER_STATE_IDLE
  COURIER_VALUE = 400
  courier.CourierUsageThink()

  luaunit.assertEquals(COURIER_ACTION, COURIER_ACTION_TRANSFER_ITEMS)
end

function test_CourierUsageThink_secret_shop_action()
  test_RefreshCourier()
  test_RefreshBot()

  COURIER_ACTION = nil
  COURIER_STATE = COURIER_STATE_IDLE
  BOT.is_secret_shop_mode = true
  courier.CourierUsageThink()

  luaunit.assertEquals(COURIER_ACTION, COURIER_ACTION_SECRET_SHOP)
end

function test_CourierUsageThink_take_and_transfer_action()
  test_RefreshCourier()
  test_RefreshBot()

  COURIER_ACTION = nil
  COURIER_STATE = COURIER_STATE_AT_BASE
  STASH_VALUE = 400
  courier.CourierUsageThink()

  luaunit.assertEquals(
    COURIER_ACTION,
    COURIER_ACTION_TAKE_AND_TRANSFER_ITEMS)
end

os.exit(luaunit.LuaUnit.run())
