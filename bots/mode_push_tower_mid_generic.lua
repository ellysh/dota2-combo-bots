local mode_push = require(
  GetScriptDirectory() .."/utility/mode_push")

function GetDesire()
  return player_desires.GetDesire(
    "BOT_MODE_PUSH_TOWER_MID",
    BOT_MODE_PUSH_TOWER_MID)
end

function Think()
  mode_push.Think(LANE_MID)
end
