local mode_push = require(
  GetScriptDirectory() .."/utility/mode_push")

function GetDesire()
  return mode_push.GetDesire(LANE_BOT)
end

function Think()
  mode_push.Think(LANE_BOT)
end
