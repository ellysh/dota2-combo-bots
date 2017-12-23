local mode_shop = require(
  GetScriptDirectory() .."/utility/mode_shop")

function GetDesire()
  local npc_bot = GetBot();

  mode_shop.GetDesire(
    npc_bot.is_side_shop_mode,
    npc_bot:DistanceFromSideShop())
end

function Think()
  mode_shop.ThinkSideShop()
end

