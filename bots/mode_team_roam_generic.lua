local constants = require(
  GetScriptDirectory() .."/utility/constants")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local move = require(
  GetScriptDirectory() .."/utility/move")

local player_desires = require(
  GetScriptDirectory() .."/utility/player_desires")

local M = {}

function GetDesire()
  return functions.GetNormalizedDesire(
           GetRoamDesire()
           + player_desires.GetDesire("BOT_MODE_TEAM_ROAM"),
         constants.MAX_PUSH_DESIRE)
end

function Think()
  local bot = GetBot()
  local target_location = GetLaneFrontLocation(GetTeam(), lane, 0.5)

  if functions.IsEnemyNear(bot) then
     attack.Attack(bot, bot:GetCurrentVisionRange())
  else
    move.Move(bot, target_location)
  end
end

-- Provide an access to local functions and variables for unit tests only

return M
