local functions = require(
  GetScriptDirectory() .."/utility/functions")

local M = {}

-- This table is required because global variables are shared between
-- both teams.

local COURIER_STATE = {
  [TEAM_RADIANT] = {
    COURIER_OWNER = nil,
    COURIER_CURRENT_ACTION = nil,
    COURIER_IDLE_TIME = nil,
    COURIER_PREVIOUS_LOCATION = nil
  },
  [TEAM_DIRE] = {
    COURIER_OWNER = nil,
    COURIER_CURRENT_ACTION = nil,
    COURIER_IDLE_TIME = nil,
    COURIER_PREVIOUS_LOCATION = nil
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
         and (courier_action == nil
              or courier_action == COURIER_ACTION_RETURN)
end

local function SetCourierAction(bot, courier, action)
  COURIER_STATE[GetTeam()].COURIER_OWNER = bot:GetUnitName()

  bot:ActionImmediate_Courier(courier, action)

  COURIER_STATE[GetTeam()].COURIER_CURRENT_ACTION = action
end

local function IsLocationChanged(courier)
  local previos_location =
    COURIER_STATE[GetTeam()].COURIER_PREVIOUS_LOCATION

  COURIER_STATE[GetTeam()].COURIER_PREVIOUS_LOCATION =
    courier:GetLocation()

  if previos_location == nil then
    return false end

  return not functions.IsLocationsEquals(
    previos_location,
    courier:GetLocation())
end

local function IsFreeState(state)
  return state == COURIER_STATE_RETURNING_TO_BASE
         or state == COURIER_STATE_IDLE
         or state == COURIER_STATE_AT_BASE
end

local function FreeCourier(bot, courier, state)
  if not IsFreeState(state) or IsLocationChanged(courier) then
    return
  end

  -- We use the GameTime here to avoid negative DotaTime value
  -- before the horn.

  if COURIER_STATE[GetTeam()].COURIER_IDLE_TIME == nil then
    COURIER_STATE[GetTeam()].COURIER_IDLE_TIME = GameTime()
  elseif 2 < (GameTime() - COURIER_STATE[GetTeam()].COURIER_IDLE_TIME) then
    COURIER_STATE[GetTeam()].COURIER_IDLE_TIME = nil
    COURIER_STATE[GetTeam()].COURIER_OWNER = nil
    COURIER_STATE[GetTeam()].COURIER_CURRENT_ACTION = nil

    bot:ActionImmediate_Courier(courier, COURIER_ACTION_RETURN)
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

function M.test_GetCourierIdleTime()
  return COURIER_STATE[GetTeam()].COURIER_IDLE_TIME
end

function M.test_SetCourierIdleTime(time)
  COURIER_STATE[GetTeam()].COURIER_IDLE_TIME = time
end

function M.test_SetCourierOwner(owner)
  COURIER_STATE[GetTeam()].COURIER_OWNER = owner
end

function M.test_SetCourierCurrentAction(action)
  COURIER_STATE[GetTeam()].COURIER_CURRENT_ACTION = action
end

function M.test_SetCourierPreviousLocation(location)
  COURIER_STATE[GetTeam()].COURIER_PREVIOUS_LOCATION = location
end

return M
