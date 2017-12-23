local functions = require(
  GetScriptDirectory() .."/utility/functions")

function GetDesire()

  local npc_bot = GetBot();

  if functions.IsBotBusy(npc_bot)
    or not npc_bot.is_side_shop_mode then
    return 0
  end

  local distance = npc_bot:DistanceFromSideShop()
  local walk_radius = constants.SHOP_WALK_RADIUS

  if walk_radius < distance then return 0 end

  return 100 - ((distance * 100) / walk_radius)
end

local function GetNearestLocation(npc_bot, location_1, location_2)
  if GetUnitToLocationDistance(npc_bot, location_1) <
    GetUnitToLocationDistance(npc_bot, location_2) then

    return location_1
  else
    return location_2
  end
end

function Think()

  local npc_bot = GetBot();

  local shop_location = GetNearestLocation(
    npc_bot,
    GetShopLocation(GetTeam(), SHOP_SIDE),
    GetShopLocation(GetTeam(), SHOP_SIDE2))

  npcBot:Action_MoveToLocation(shop_location);
end

