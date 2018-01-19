local desires = require(
  GetScriptDirectory() .."/utility/desires")

local player_desires = require(
  GetScriptDirectory() .."/database/player_desires")

local player_desires_algorithms = require(
  GetScriptDirectory() .."/utility/player_desires_algorithms")

local M = {}

local PLAYER_DESIRES = {
  PUSH_TOP_LINE_DESIRE = 0,
  PUSH_MID_LINE_DESIRE = 0,
  PUSH_BOT_LINE_DESIRE = 0
}

local LANE_TO_DESIRE= {
  [LANE_TOP] = "PUSH_TOP_LINE_DESIRE",
  [LANE_MID] = "PUSH_MID_LINE_DESIRE",
  [LANE_BOT] = "PUSH_BOT_LINE_DESIRE"
}

function M.GetDesire(lane)
  PLAYER_DESIRES = desires.Think(
    player_desires.PLAYER_DESIRES,
    player_desires_algorithms)

  return GetPushLaneDesire(lane) + PLAYER_DESIRES[LANE_TO_DESIRE[lane]]
end

function M.Think(lane)
  -- TODO: Use TP scrolls and TP boots here

  local bot = GetBot()
  local target = GetLaneFrontLocation(GetTeam(), lane, 0.5)
  bot:Action_AttackMove(target)
end

return M
