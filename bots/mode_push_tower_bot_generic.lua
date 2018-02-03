local mode_push = require(
  GetScriptDirectory() .."/utility/mode_push")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local player_desires = require(
  GetScriptDirectory() .."/utility/player_desires")

function GetDesire()
  return functions.GetNormalizedDesire(
           GetPushLaneDesire(LANE_BOT)
           + player_desires.GetDesire("BOT_MODE_PUSH_TOWER_BOT"),
         constants.MAX_PUSH_DESIRE)
end

function Think()
  mode_push.Think(LANE_BOT)
end
