local desires = require(
  GetScriptDirectory() .."/utility/desires")

local player_desires = require(
  GetScriptDirectory() .."/database/player_desires")

local player_desires_algorithms = require(
  GetScriptDirectory() .."/utility/player_desires_algorithms")

local PLAYER_DESIRES = {
  PUSH_TOP_LINE_DESIRE = 0,
  PUSH_MID_LINE_DESIRE = 0,
  PUSH_BOT_LINE_DESIRE = 0
}

function GetDesire()
  PLAYER_DESIRES = desires.Think(
    player_desires.PLAYER_DESIRES,
    player_desires_algorithms)

  return GetPushLaneDesire(LANE_BOT) + PLAYER_DESIRES.PUSH_BOT_LINE_DESIRE
end

function Think()
  -- TODO: Use TP scrolls and TP boots here

  local target = GetLaneFrontLocation(GetTeam(), LANE_BOT, 0.5)
  Action_AttackMove(target)
end
