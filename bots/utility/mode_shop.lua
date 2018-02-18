local constants = require(
  GetScriptDirectory() .."/utility/constants")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local memory = require(
  GetScriptDirectory() .."/utility/memory")

local common_algorithms = require(
  GetScriptDirectory() .."/utility/common_algorithms")

local M = {}

local function IsShopRequired(bot, check_shop_func)
  local buy_item = memory.GetItemToBuy(bot)
  local sell_item = memory.GetItemToSell(bot)

  return not functions.IsBotBusy(bot)
         and not bot:WasRecentlyDamagedByAnyHero(5.0)
         and (not functions.IsInventoryFull(bot)
              or sell_item ~= nil)
         and ((buy_item ~= nil
               and check_shop_func(buy_item)
               and GetItemCost(buy_item) <= bot:GetGold())
              or sell_item ~= nil)
end

local function GetDesire(check_shop_func, shop_location, base_desire)
  local bot = GetBot();
  local shop_distance = GetUnitToLocationDistance(bot, shop_location)

  if not IsShopRequired(bot, check_shop_func)
    or constants.SHOP_WALK_RADIUS < shop_distance then

    return 0
  end

  if shop_distance < constants.SHOP_WALK_RADIUS / 4 then
    return constants.MAX_SHOP_DESIRE
  end

  if functions.IsBotInFightingMode(bot)
     or common_algorithms.IsEnemyHeroOnTheWay(bot, shop_location) then
    return 0
  end

  return functions.GetNormalizedDesire(
           functions.DistanceToDesire(
             shop_distance,
             constants.SHOP_WALK_RADIUS,
             base_desire),
           constants.MAX_SHOP_DESIRE)
end

local function GetNearestShop(bot, shop_type)
  if shop_type == SHOP_SIDE then
    return functions.GetNearestLocation(
      bot,
      {GetShopLocation(GetTeam(), SHOP_SIDE),
       GetShopLocation(GetTeam(), SHOP_SIDE2)})
  elseif shop_type == SHOP_SECRET then
    return functions.GetNearestLocation(
      bot,
      {GetShopLocation(GetTeam(), SHOP_SECRET),
       GetShopLocation(GetTeam(), SHOP_SECRET2)})
  end
  return nil
end

function M.GetDesireSideShop()
  return GetDesire(
    IsItemPurchasedFromSideShop,
    GetNearestShop(GetBot(), SHOP_SIDE),
    0.3)
end

function M.GetDesireSecretShop()
  return GetDesire(
    IsItemPurchasedFromSecretShop,
    GetNearestShop(GetBot(), SHOP_SECRET),
    0.2)
end

local function Think(shop_location)
  -- We do all purchase and sell operations in the item_purchase module
  local bot = GetBot()

  bot:Action_MoveToLocation(shop_location);
end

function M.ThinkSideShop()
  Think(GetNearestShop(GetBot(), SHOP_SIDE))
end

function M.ThinkSecretShop()
  Think(GetNearestShop(GetBot(), SHOP_SECRET))
end

-- Provide an access to local functions for unit tests only
M.test_IsShopRequired = IsShopRequired
M.test_GetDesire = GetDesire

return M
