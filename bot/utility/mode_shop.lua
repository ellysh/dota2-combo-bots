local logger = require(
  GetScriptDirectory() .."/utility/logger")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local M = {}

local function IsShopRequired(bot, check_shop_func)
  return not functions.IsBotBusy(bot)
         and not bot:WasRecentlyDamagedByAnyHero(5.0)
         and functions.GetItemToBuy(bot) ~= nil
         and check_shop_func(
               functions.GetItemToBuy(bot))
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

local function GetDesire(check_shop_func, get_distance_func)
  local bot = GetBot();

  if not IsShopRequired(bot, check_shop_func)
    or IsBotInFightingMode(bot)
    or constants.SHOP_WALK_RADIUS < bot[get_distance_func](bot) then

    return 0
  end

  return 0.7
end

function M.GetDesireSideShop()
  return GetDesire(
    IsItemPurchasedFromSideShop,
    "DistanceFromSideShop")
end

function M.GetDesireSecretShop()
  return GetDesire(
    IsItemPurchasedFromSecretShop,
    "DistanceFromSecretShop")
end

local function GetNearestLocation(bot, location_1, location_2)
  if GetUnitToLocationDistance(bot, location_1) <
    GetUnitToLocationDistance(bot, location_2) then

    return location_1
  else
    return location_2
  end
end

local function Think(get_distance_func, shop1, shop2)
  -- We do all purchase and sell operations in the item_purchase module

  local bot = GetBot()
  local shop_location = GetNearestLocation(
    bot,
    GetShopLocation(GetTeam(), shop1),
    GetShopLocation(GetTeam(), shop2))

  bot:Action_MoveToLocation(shop_location);
end

function M.ThinkSideShop()
  Think("DistanceFromSideShop", SHOP_SECRET, SHOP_SECRET2)
end

function M.ThinkSecretShop()
  Think("DistanceFromSecretShop", SHOP_SIDE, SHOP_SIDE2)
end

-- Provide an access to local functions for unit tests only
M.test_GetNearestLocation = GetNearestLocation

return M
