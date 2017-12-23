local functions = require(
  GetScriptDirectory() .."/utility/functions")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local M = {}

function M.GetDesire(is_shop_mode, shop_distance)

  local npc_bot = GetBot();

  if functions.IsBotBusy(npc_bot)
    or not is_shop_mode
    or npc_bot:WasRecentlyDamagedByAnyHero(5.0) then

    return 0
  end

  local walk_radius = constants.SHOP_WALK_RADIUS

  if walk_radius < shop_distance then return 0 end

  return (100 - ((shop_distance * 100) / walk_radius)) / 100.0
end

local function GetNearestLocation(npc_bot, location_1, location_2)
  if GetUnitToLocationDistance(npc_bot, location_1) <
    GetUnitToLocationDistance(npc_bot, location_2) then

    return location_1
  else
    return location_2
  end
end

function M.ThinkSideShop()

  local npc_bot = GetBot();

  local shop_location = GetNearestLocation(
    npc_bot,
    GetShopLocation(GetTeam(), SHOP_SIDE),
    GetShopLocation(GetTeam(), SHOP_SIDE2))

  npc_bot:Action_MoveToLocation(shop_location);
end

-- Provide an access to local functions for unit tests only
M.test_GetNearestLocation = GetNearestLocation

return M
