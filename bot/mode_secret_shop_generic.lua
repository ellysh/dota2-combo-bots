local functions = require(
  GetScriptDirectory() .."/utility/functions")

function GetDesire()

  local npc_bot = GetBot();

  if functions.IsBotBusy(npc_bot)
    or not npc_bot.is_secret_shop_mode then
    return 0
  end

  local distance = npc_bot:DistanceFromSecretShop()
  local walk_radius = constants.SHOP_WALK_RADIUS

  if walk_radius < distance then return 0 end

  return 100 - ((distance * 100) / walk_radius)
end

