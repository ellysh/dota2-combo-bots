local mode_push = require(
  GetScriptDirectory() .."/utility/mode_push")

function GetDesire()
  return mode_push.GetDesire(LANE_MID)
end

function Think()
  mode_push.Think(LANE_MID)
end
