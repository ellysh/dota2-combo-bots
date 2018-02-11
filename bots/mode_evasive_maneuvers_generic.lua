local player_desires = require(
  GetScriptDirectory() .."/utility/player_desires")

function GetDesire()
  return player_desires.GetDesire("BOT_MODE_EVASIVE_MANEUVERS")
end

function Think()
  local bot = GetBot()
  bot:Action_MoveToLocation(GetShopLocation(GetTeam(), SHOP_HOME))
end
