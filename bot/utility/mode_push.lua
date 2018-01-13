local desires = require(
  GetScriptDirectory() .."/utility/desires")

local player_desires = require(
  GetScriptDirectory() .."/database/player_desires")

local player_desires_algorithms = require(
  GetScriptDirectory() .."/utility/player_desires_algorithms")

local M = {}

local PLAYER_DESIRES = {
  [LANE_TOP] = 0,
  [LANE_MID] = 0,
  [LANE_BOT] = 0
}

function M.GetDesire(lane)
  PLAYER_DESIRES = desires.Think(
    player_desires.PLAYER_DESIRES,
    player_desires_algorithms)

  return GetPushLaneDesire(lane) + PLAYER_DESIRES[lane]
end

function M.Think(lane)
  -- TODO: Use TP scrolls and TP boots here

  local npc_bot = GetBot()
  local target = GetLaneFrontLocation(GetTeam(), lane, 0.5)
  npc_bot:Action_AttackMove(target)
end

return M
