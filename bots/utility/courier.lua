local constants = require(
  GetScriptDirectory() .."/utility/constants")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local memory = require(
  GetScriptDirectory() .."/utility/memory")

local M = {}

-- This table is required because global variables are shared between
-- both teams.

local COURIER_STATE = {
  [TEAM_RADIANT] = {
    COURIER_OWNER = nil,
    COURIER_CURRENT_ACTION = nil,
  },
  [TEAM_DIRE] = {
    COURIER_OWNER = nil,
    COURIER_CURRENT_ACTION = nil,
  }
}

local function IsAllyHeroDead(name)
  local ally_heroes = GetUnitList(UNIT_LIST_ALLIED_HEROES)

  local hero = functions.GetElementWith(
    ally_heroes,
    nil,
    function(unit)
      return unit:GetUnitName() == name
    end)

    return hero == nil or not hero:IsAlive()
end

local function IsCourierAvailable(bot)
  -- TODO: We compare only the primary position of
  -- the courier owner and the current bot.
  local courier_owner = COURIER_STATE[GetTeam()].COURIER_OWNER
  local courier_action = COURIER_STATE[GetTeam()].COURIER_CURRENT_ACTION

  return (courier_owner == nil
         or courier_owner == bot:GetUnitName()
         or functions.GetHeroPositions(bot:GetUnitName())[1]
            < functions.GetHeroPositions(courier_owner)[1]
         or IsAllyHeroDead(courier_owner))
         and courier_action == nil
end

local function SetCourierAction(bot, courier, action)
  COURIER_STATE[GetTeam()].COURIER_OWNER = bot:GetUnitName()

  bot:ActionImmediate_Courier(courier, action)

  COURIER_STATE[GetTeam()].COURIER_CURRENT_ACTION = action
end

local function FreeCourier(bot, courier, state)
  if state == COURIER_STATE_IDLE
     and constants.BASE_SHOP_USE_RADIUS
         < courier:DistanceFromFountain() then
    SetCourierAction(bot, courier, COURIER_ACTION_RETURN)
  end

  if state == COURIER_STATE_AT_BASE then
    COURIER_STATE[GetTeam()].COURIER_OWNER = nil
    COURIER_STATE[GetTeam()].COURIER_CURRENT_ACTION = nil
  end
end

local function IsSecretShopRequired(bot)
  local buy_item = memory.GetItemToBuy(bot)

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

  if courier_state == COURIER_STATE_DEAD then
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

  FreeCourier(bot, courier, courier_state)
end

-- Provide an access to local functions for unit tests only
M.test_IsCourierAvailable = IsCourierAvailable
M.test_SetCourierAction = SetCourierAction
M.test_IsLocationChanged = IsLocationChanged
M.test_IsFreeState = IsFreeState
M.test_FreeCourier = FreeCourier
M.test_IsSecretShopRequired = IsSecretShopRequired
M.test_IsCourierDamaged = IsCourierDamaged

function M.test_SetCourierOwner(owner)
  COURIER_STATE[GetTeam()].COURIER_OWNER = owner
end

function M.test_SetCourierCurrentAction(action)
  COURIER_STATE[GetTeam()].COURIER_CURRENT_ACTION = action
end

function M.test_GetCourierCurrentAction(action)
  return COURIER_STATE[GetTeam()].COURIER_CURRENT_ACTION
end

return M
