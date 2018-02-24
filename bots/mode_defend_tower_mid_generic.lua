local mode_defend = require(
  GetScriptDirectory() .."/utility/mode_defend")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local player_desires = require(
  GetScriptDirectory() .."/utility/player_desires")

function GetDesire()
  return functions.GetNormalizedDesire(
           GetDefendLaneDesire(LANE_MID)
           + player_desires.GetDesire("BOT_MODE_DEFEND_TOWER_MID"),
         constants.MAX_DEFEND_DESIRE)
end

function Think()
  mode_defend.Think(LANE_MID)
end
