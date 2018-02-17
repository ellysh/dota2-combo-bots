local player_desires = require(
  GetScriptDirectory() .."/utility/player_desires")

function GetDesire()
  return player_desires.GetDesire("BOT_MODE_LANING")
end
