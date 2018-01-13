local functions = require(
  GetScriptDirectory() .."/utility/functions")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local M = {}

local function IsSideShopRequired(bot)
  return not functions.IsBotBusy(bot)
         and not bot:WasRecentlyDamagedByAnyHero(5.0)
         and NEXT_BUY_ITEM ~= nil
         and IsItemPurchasedFromSideShop(NEXT_BUY_ITEM)
end

local function IsSecretShopRequired(bot)
  return not functions.IsBotBusy(bot)
         and not bot:WasRecentlyDamagedByAnyHero(5.0)
         and NEXT_BUY_ITEM ~= nil
         and IsItemPurchasedFromSecretShop(NEXT_BUY_ITEM)
end

local function IsBotInFightingMode(bot)
  local mode = bot:GetActiveMode()

  return mode == BOT_MODE_ATTACK
         or mode == BOT_MODE_PUSH_TOWER_TOP
         or mode == BOT_MODE_PUSH_TOWER_MID
         or mode == BOT_MODE_PUSH_TOWER_BOT
         or mode == BOT_MODE_DEFEND_ALLY
         or mode == BOT_MODE_RETREAT
         or mode == BOT_MODE_ROSHAN
         or mode == BOT_MODE_DEFEND_TOWER_TOP
         or mode == BOT_MODE_DEFEND_TOWER_MID
         or mode == BOT_MODE_DEFEND_TOWER_BOT
end

function M.GetDesireSideShop()
  local bot = GetBot();

  if not IsSideShopRequired(bot)
    or IsBotInFightingMode(bot)
    or constants.SHOP_WALK_RADIUS < bot:DistanceFromSideShop() then

    return 0
  end

  return 1.0
end

function M.GetDesireSecretShop()
  local bot = GetBot();

  if not IsSecretShopRequired(bot)
    or IsBotInFightingMode(bot)
    or constants.SHOP_WALK_RADIUS < bot:DistanceFromSecretShop() then

    return 0
  end

  return 1.0
end

local function GetNearestLocation(bot, location_1, location_2)
  if GetUnitToLocationDistance(bot, location_1) <
    GetUnitToLocationDistance(bot, location_2) then

    return location_1
  else
    return location_2
  end
end

function M.ThinkSideShop()
  local bot = GetBot();

  if bot:DistanceFromSideShop() < constants.SHOP_USE_RADIUS then
    if PURCHASE_ITEM_SUCCESS ==
      bot:ActionImmediate_PurchaseItem(NEXT_BUY_ITEM) then

      NEXT_BUY_ITEM = nil
    end

    return
  end

  local shop_location = GetNearestLocation(
    bot,
    GetShopLocation(GetTeam(), SHOP_SIDE),
    GetShopLocation(GetTeam(), SHOP_SIDE2))

  bot:Action_MoveToLocation(shop_location);
end

function M.ThinkSecretShop()
  local bot = GetBot();

  if bot:DistanceFromSecretShop() < constants.SHOP_USE_RADIUS then
    if PURCHASE_ITEM_SUCCESS ==
      bot:ActionImmediate_PurchaseItem(NEXT_BUY_ITEM) then

      NEXT_BUY_ITEM = nil
    end

    return
  end

  local shop_location = GetNearestLocation(
    bot,
    GetShopLocation(GetTeam(), SHOP_SECRET),
    GetShopLocation(GetTeam(), SHOP_SECRET2))

  bot:Action_MoveToLocation(shop_location);
end

-- Provide an access to local functions for unit tests only
M.test_GetNearestLocation = GetNearestLocation

return M
