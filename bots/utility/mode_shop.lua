local logger = require(
  GetScriptDirectory() .."/utility/logger")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local M = {}

local function IsShopRequired(bot, check_shop_func)
  local buy_item = functions.GetItemToBuy(bot)

  return not functions.IsBotBusy(bot)
         and not bot:WasRecentlyDamagedByAnyHero(3.0)
         and buy_item ~= nil
         and check_shop_func(buy_item)
         and GetItemCost(buy_item) <= bot:GetGold()
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

local function GetDesire(check_shop_func, get_distance_func, base_desire)
  local bot = GetBot();

  local shop_distance = bot[get_distance_func](bot)

  if not IsShopRequired(bot, check_shop_func)
    or constants.SHOP_WALK_RADIUS < shop_distance then

    return 0
  end

  if shop_distance < constants.SHOP_WALK_RADIUS / 3 then
    return 0.9
  end

  if IsBotInFightingMode(bot) then
    return 0
  end

  return (1 - (shop_distance / constants.SHOP_WALK_RADIUS)) + base_desire
end

function M.GetDesireSideShop()
  return GetDesire(
    IsItemPurchasedFromSideShop,
    "DistanceFromSideShop",
    0.3)
end

function M.GetDesireSecretShop()
  return GetDesire(
    IsItemPurchasedFromSecretShop,
    "DistanceFromSecretShop",
    0.2)
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
  Think("DistanceFromSideShop", SHOP_SIDE, SHOP_SIDE2)
end

function M.ThinkSecretShop()
  Think("DistanceFromSecretShop", SHOP_SECRET, SHOP_SECRET2)
end

-- Provide an access to local functions for unit tests only
M.test_GetNearestLocation = GetNearestLocation
M.test_IsBotInFightingMode = IsBotInFightingMode
M.test_GetDesire = GetDesire

return M
