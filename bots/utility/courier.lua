local functions = require(
  GetScriptDirectory() .."/utility/functions")

local M = {}

local COURIER_OWNER = nil
local CURRENT_ACTION = nil
local COURIER_IDLE_TIME = nil

local function IsCourierAvailable(bot)
  return (COURIER_OWNER == nil
         or COURIER_OWNER == bot:GetUnitName())
         and CURRENT_ACTION == nil
end

local function SetCourierAction(bot, courier, action)
  COURIER_OWNER = bot:GetUnitName()

  bot:ActionImmediate_Courier(courier, action)

  CURRENT_ACTION = action
end

local function IsFreeState(state)
  return state == COURIER_STATE_RETURNING_TO_BASE
         or state == COURIER_STATE_IDLE
         or state == COURIER_STATE_AT_BASE
end

local function FreeCourier(courier, state)
  if not IsFreeState(state) then
    return end

  -- We use the GameTime here to avoid negative DotaTime value
  -- before the horn.

  if COURIER_IDLE_TIME == nil then
    COURIER_IDLE_TIME = GameTime()
  elseif 10 < (GameTime() - COURIER_IDLE_TIME) then
    COURIER_IDLE_TIME = nil
    COURIER_OWNER = nil
    CURRENT_ACTION = nil
  end
end

local function IsSecretShopRequired(bot)
  local buy_item = functions.GetItemToBuy(bot)

  return buy_item ~= nil
         and IsItemPurchasedFromSecretShop(buy_item)
         and bot:GetActiveMode() ~= BOT_MODE_SECRET_SHOP
         and GetItemCost(buy_item) <= bot:GetGold()
end

local function IsCourierDamaged(courier)
  return courier:GetHealth() / courier:GetMaxHealth() <= 0.9
end

function M.CourierUsageThink()
  local bot = GetBot()
  local courier = GetCourier(0)

  if not bot:IsAlive() or courier == nil then
    return
  end

  local courier_state = GetCourierState(courier)

  if state == COURIER_STATE_DEAD then
    return end

  if IsCourierDamaged(courier) then
    SetCourierAction(bot, courier, COURIER_ACTION_BURST)
    return
  end

  if IsCourierAvailable(bot)
    and bot:GetCourierValue() > 0
    and not functions.IsInventoryFull(bot) then

    SetCourierAction(bot, courier, COURIER_ACTION_TRANSFER_ITEMS)
    return
  end

  if IsCourierAvailable(bot)
    and IsSecretShopRequired(bot) then

    SetCourierAction(bot, courier, COURIER_ACTION_SECRET_SHOP)
    return
  end

  if IsCourierAvailable(bot)
    and bot:GetStashValue() > 0 then

    SetCourierAction(bot, courier, COURIER_ACTION_TAKE_AND_TRANSFER_ITEMS)
    return
  end

  FreeCourier(courier, courier_state)
end

-- Provide an access to local functions for unit tests only
M.test_IsCourierAvailable = IsCourierAvailable
M.test_SetCourierAction = SetCourierAction
M.test_IsFreeState = IsFreeState
M.test_FreeCourier = FreeCourier
M.test_IsSecretShopRequired = IsSecretShopRequired
M.test_IsCourierDamaged = IsCourierDamaged

function M.test_GetCourierIdleTime()
  return COURIER_IDLE_TIME
end

function M.test_SetCourierIdleTime(time)
  COURIER_IDLE_TIME = time
end

return M
