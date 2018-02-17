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

local common_algorithms = require(
  GetScriptDirectory() .."/utility/common_algorithms")

local M = {}

function GetDesire()
  return functions.GetNormalizedDesire(
           GetRoamDesire()
           + player_desires.GetDesire("BOT_MODE_TEAM_ROAM"),
         constants.MAX_PUSH_DESIRE)
end

function Think()
  local target_player = common_algorithms.GetMaxKillsPlayer(
    GetOpposingTeam(),
    function(p) return IsHeroAlive(p) end)

  local target_location =
    common_algorithms.GetLastPlayerLocation(target_player)

  if target_location == nil then
    return end

  local bot = GetBot()
  local target = attack.ChooseTarget(bot, constants.MAX_GET_UNITS_RADIUS)

  if target ~= nil then
    attack.Attack(bot, target)
  else
    move.Move(bot, target_location)
  end
end

-- Provide an access to local functions and variables for unit tests only
M.test_GetMaxKillsEnemyPlayer = GetMaxKillsEnemyPlayer

return M
