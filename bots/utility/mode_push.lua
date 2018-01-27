local desires = require(
  GetScriptDirectory() .."/utility/desires")

local player_desires = require(
  GetScriptDirectory() .."/database/player_desires")

local player_desires_algorithms = require(
  GetScriptDirectory() .."/utility/player_desires_algorithms")

local attack = require(
  GetScriptDirectory() .."/utility/attack")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local M = {}

local LANE_TO_DESIRE= {
  [LANE_TOP] = "PUSH_TOP_LINE_DESIRE",
  [LANE_MID] = "PUSH_MID_LINE_DESIRE",
  [LANE_BOT] = "PUSH_BOT_LINE_DESIRE"
}

function M.GetDesire(lane)
  local desires_list = desires.Think(
    player_desires.PLAYER_DESIRES,
    player_desires_algorithms)

  return GetPushLaneDesire(lane) + desires_list[LANE_TO_DESIRE[lane]]
end

function M.Think(lane)
  -- TODO: Use TP scrolls and TP boots here

  local bot = GetBot()
  local target = GetLaneFrontLocation(GetTeam(), lane, 0.5)

  if functions.IsEnemyNear(bot) then
     attack.Attack(bot)
  else
    bot:Action_AttackMove(target)
  end
end

return M
