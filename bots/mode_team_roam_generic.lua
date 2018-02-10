local constants = require(
  GetScriptDirectory() .."/utility/constants")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local move = require(
  GetScriptDirectory() .."/utility/move")

local attack = require(
  GetScriptDirectory() .."/utility/attack")

local player_desires = require(
  GetScriptDirectory() .."/utility/player_desires")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local M = {}

function GetDesire()
  return functions.GetNormalizedDesire(
           GetRoamDesire()
           + player_desires.GetDesire("BOT_MODE_TEAM_ROAM"),
         constants.MAX_PUSH_DESIRE)
end

function Think()
  local target_player = functions.GetMaxKillsPlayer(
    GetOpposingTeam(),
    function(p) return IsHeroAlive(p) end)

  local target_location = functions.GetLastPlayerLocation(target_player)

  if target_location == nil then
    return end

  local bot = GetBot()

  if functions.IsEnemyNear(bot) then
     attack.Attack(bot, constants.MAX_GET_UNITS_RADIUS)
  else
    move.Move(bot, target_location)
  end
end

-- Provide an access to local functions and variables for unit tests only
M.test_GetMaxKillsEnemyPlayer = GetMaxKillsEnemyPlayer

return M
