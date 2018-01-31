local functions = require(
  GetScriptDirectory() .."/utility/functions")

local player_desires = require(
  GetScriptDirectory() .."/utility/player_desires")

function GetDesire()
  return player_desires.GetDesire("BOT_MODE_RETREAT")
end

function Think()
  local bot = GetBot()
  local fountain_location = GetShopLocation(GetTeam(), SHOP_HOME)

  bot:Action_MoveToLocation(fountain_location);
end
