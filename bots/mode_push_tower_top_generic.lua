local mode_push = require(
  GetScriptDirectory() .."/utility/mode_push")

function GetDesire()
  return GetPushLaneDesire(BOT_MODE_PUSH_TOWER_TOP)
         + player_desires.GetDesire("BOT_MODE_PUSH_TOWER_TOP")
end

function Think()
  mode_push.Think(LANE_TOP)
end
