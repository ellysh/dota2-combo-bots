local mode_shop = require(
  GetScriptDirectory() .."/utility/mode_shop")

function GetDesire()
  local npc_bot = GetBot();

  mode_shop.GetDesire(
    npc_bot.is_side_shop_mode,
    npc_bot:DistanceFromSideShop())
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

