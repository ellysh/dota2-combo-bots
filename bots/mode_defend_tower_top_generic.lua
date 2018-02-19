local functions = require(
  GetScriptDirectory() .."/utility/functions")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local player_desires = require(
  GetScriptDirectory() .."/utility/player_desires")

function GetDesire()
  return functions.GetNormalizedDesire(
           GetDefendLaneDesire(LANE_TOP)
           + player_desires.GetDesire("BOT_MODE_DEFEND_TOWER_TOP"),
         constants.MAX_DEFEND_DESIRE)
end
