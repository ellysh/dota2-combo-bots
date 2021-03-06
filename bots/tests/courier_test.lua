package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local luaunit = require("luaunit")
local courier = require("courier")
local memory = require("memory")

memory.InitPurchaseList(GetBot())

function test_IsCourierAvailable_succeed()
  local bot = GetBot()

  courier.test_SetCourierOwner(nil)
  courier.test_SetCourierCurrentAction(nil)

  luaunit.assertTrue(courier.test_IsCourierAvailable(bot))
end

function test_IsCourierAvailable_for_fewer_position_hero_succeed()
  local bot = GetBot()
  bot.name = "npc_dota_hero_ursa"

  courier.test_SetCourierOwner("npc_dota_hero_shadow_shaman")
  courier.test_SetCourierCurrentAction(nil)

  luaunit.assertTrue(courier.test_IsCourierAvailable(bot))
end

function test_IsCourierAvailable_another_owner_fails()
  local bot = GetBot()

  UNITS = { Unit:new("npc_dota_hero_sniper") }
  courier.test_SetCourierOwner("npc_dota_hero_sniper")
  courier.test_SetCourierCurrentAction(nil)

  luaunit.assertFalse(courier.test_IsCourierAvailable(bot))
end

function test_IsCourierAvailable_owner_dead_succeed()
  local bot = GetBot()

  local owner = Unit:new("npc_dota_hero_sniper")
  owner.health = 0
  UNITS = { owner }
  courier.test_SetCourierOwner("npc_dota_hero_sniper")
  courier.test_SetCourierCurrentAction(nil)

  luaunit.assertTrue(courier.test_IsCourierAvailable(bot))
end

function test_IsCourierAvailable_action_fails()
  local bot = GetBot()

  courier.test_SetCourierOwner(nil)
  courier.test_SetCourierCurrentAction(COURIER_ACTION_SECRET_SHOP)

  luaunit.assertFalse(courier.test_IsCourierAvailable(bot))
end

function test_FreeCourier_moving_fails()
  test_RefreshCourier()

  local bot = GetBot()

  courier.test_SetCourierCurrentAction(COURIER_ACTION_SECRET_SHOP)

  courier.test_FreeCourier(
    bot,
    GetCourier(),
    COURIER_STATE_MOVING)

  luaunit.assertEquals(
    courier.test_GetCourierCurrentAction(),
    COURIER_ACTION_SECRET_SHOP)
end

function test_FreeCourier_succeed()
  test_RefreshCourier()

  local bot = GetBot()

  DISTANCE_FROM_SHOP = 2000
  TIME = 12
  courier.test_FreeCourier(
    bot,
    GetCourier(),
    COURIER_STATE_IDLE)

  luaunit.assertEquals(COURIER_ACTION, COURIER_ACTION_RETURN)
end

function test_IsSecretShopRequired()
  test_RefreshBot()

  luaunit.assertFalse(
    courier.test_IsSecretShopRequired(GetBot()))

  IS_SECRET_SHOP_ITEM = true
  memory.AddItemToBuy(GetBot(), "item_vitality_booster")
  luaunit.assertTrue(
    courier.test_IsSecretShopRequired(GetBot()))

  IS_SECRET_SHOP_ITEM = false
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

function test_CourierUsageThink_no_action_succeed()
  test_RefreshCourier()
  test_RefreshBot()

  local bot = GetBot()
  bot.health = 0

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

function test_CourierUsageThink_burst_action_succeed()
  test_RefreshCourier()
  test_RefreshBot()

  local c = GetCourier()
  c.health = c.max_health / 2

  COURIER_ACTION = nil
  courier.CourierUsageThink()

  luaunit.assertEquals(COURIER_ACTION, COURIER_ACTION_BURST)
end

local function FreeCourier()
  courier.test_FreeCourier(GetBot(), GetCourier(0), COURIER_STATE_IDLE)
  TIME = TIME + 11
  courier.test_FreeCourier(GetBot(), GetCourier(0), COURIER_STATE_IDLE)
end

function test_CourierUsageThink_transfer_action_succeed()
  test_RefreshCourier()
  test_RefreshBot()

  courier.test_SetCourierOwner(nil)
  courier.test_SetCourierCurrentAction(nil)

  COURIER_ACTION = nil
  COURIER_STATE = COURIER_STATE_IDLE
  COURIER_VALUE = 400
  courier.CourierUsageThink()

  luaunit.assertEquals(COURIER_ACTION, COURIER_ACTION_TRANSFER_ITEMS)
end

function test_CourierUsageThink_secret_shop_action_succeed()
  test_RefreshCourier()
  test_RefreshBot()

  courier.test_SetCourierOwner(nil)
  courier.test_SetCourierCurrentAction(nil)

  COURIER_ACTION = nil
  COURIER_STATE = COURIER_STATE_IDLE
  IS_SECRET_SHOP_ITEM = true
  memory.AddItemToBuy(GetBot(), "item_vitality_booster")

  courier.CourierUsageThink()

  luaunit.assertEquals(COURIER_ACTION, COURIER_ACTION_SECRET_SHOP)
end

function test_CourierUsageThink_take_and_transfer_action_succeed()
  test_RefreshCourier()
  test_RefreshBot()

  courier.test_SetCourierOwner(nil)
  courier.test_SetCourierCurrentAction(nil)

  COURIER_ACTION = nil
  COURIER_STATE = COURIER_STATE_AT_BASE
  STASH_VALUE = 400
  memory.AddItemToBuy(GetBot(), nil)
  courier.CourierUsageThink()

  luaunit.assertEquals(
    COURIER_ACTION,
    COURIER_ACTION_TAKE_AND_TRANSFER_ITEMS)
end

function test_CourierUsageThink_dead_fails()
  test_RefreshCourier()
  test_RefreshBot()

  FreeCourier()

  COURIER_ACTION = nil
  COURIER_STATE = COURIER_STATE_DEAD
  IS_SECRET_SHOP_ITEM = true
  memory.AddItemToBuy(GetBot(), "item_vitality_booster")

  courier.CourierUsageThink()

  luaunit.assertEquals(COURIER_ACTION, nil)
end

function test_CourierUsageThink_free_succeed()
  test_RefreshCourier()
  test_RefreshBot()

  FreeCourier()

  COURIER_ACTION = nil
  COURIER_STATE = COURIER_STATE_AT_BASE
  STASH_VALUE = 0
  memory.AddItemToBuy(GetBot(), nil)
  courier.CourierUsageThink()

  luaunit.assertEquals(
    COURIER_ACTION,
    nil)
end

os.exit(luaunit.LuaUnit.run())
