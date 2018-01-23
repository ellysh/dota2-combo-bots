local desires = require(
  GetScriptDirectory() .."/utility/desires")

local player_desires = require(
  GetScriptDirectory() .."/database/player_desires")

local player_desires_algorithms = require(
  GetScriptDirectory() .."/utility/player_desires_algorithms")

local attack = require(
  GetScriptDirectory() .."/utility/attack")

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

local function IsEnemyNear(bot)
  local radius = bot:GetCurrentVisionRange()

  return 0 < #bot:GetNearbyHeroes(radius, true, BOT_MODE_NONE)
         or 0 < #bot:GetNearbyCreeps(radius, true)
         or 0 < #bot:GetNearbyTowers(radius, true)
         or 0 < #bot:GetNearbyBarracks(radius, true)
end

function M.Think(lane)
  -- TODO: Use TP scrolls and TP boots here

  local bot = GetBot()
  local target = GetLaneFrontLocation(GetTeam(), lane, 0.5)

  if IsEnemyNear(bot) then
     attack.Attack(bot)
  else
    bot:Action_AttackMove(target)
  end
end

return M
