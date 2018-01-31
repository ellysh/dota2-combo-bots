local mode_push = require(
  GetScriptDirectory() .."/utility/mode_push")

local player_desires = require(
  GetScriptDirectory() .."/utility/player_desires")

function GetDesire()
  return GetPushLaneDesire(BOT_MODE_PUSH_TOWER_MID)
         + player_desires.GetDesire("BOT_MODE_PUSH_TOWER_MID")
end

function Think()
  mode_push.Think(LANE_MID)
end
