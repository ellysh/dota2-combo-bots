local constants = require(
  GetScriptDirectory() .."/utility/constants")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local player_desires = require(
  GetScriptDirectory() .."/utility/player_desires")

function GetDesire()
  return functions.GetNormalizedDesire(
           GetRoshanDesire()
           + player_desires.GetDesire("BOT_MODE_ROSHAN"),
         constants.MAX_ROSHAN_DESIRE)
end
