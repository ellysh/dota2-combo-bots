local mode_shop = require(
  GetScriptDirectory() .."/utility/mode_shop")

function GetDesire()
  local npc_bot = GetBot();

  mode_shop.GetDesire(
    npc_bot.is_secret_shop_mode,
    npc_bot:DistanceFromSecretShop())
end

