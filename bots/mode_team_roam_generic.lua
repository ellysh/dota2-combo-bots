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

local function CompareMaxHeroKills(t, a, b)
  return GetHeroKills(t[b]) < GetHeroKills(t[a])
end

local function GetMaxKillsEnemyPlayer()
  local players = GetTeamPlayers(GetOpposingTeam())
  local player = functions.GetElementWith(
    players,
    CompareMaxHeroKills,
    function(p) return IsHeroAlive(p) end)

  return player
end

local function CompareMinTime(t, a, b)
  return t[a][2] < t[b][2]
end

function Think()
  local target_player = GetMaxKillsEnemyPlayer()

  if target_player == nil then
    return end

  local locations_times = GetHeroLastSeenInfo(target_player)
  local location_time = functions.GetElementWith(
    locations_times,
    CompareMinTime,
    nil)

  if location_time == nil then
    return end

  local bot = GetBot()

  if functions.IsEnemyNear(bot) then
     attack.Attack(bot, constants.MAX_GET_UNITS_RADIUS)
  else
    move.Move(bot, location_time[1])
  end
end

-- Provide an access to local functions and variables for unit tests only
M.test_GetMaxKillsEnemyPlayer = GetMaxKillsEnemyPlayer

return M
