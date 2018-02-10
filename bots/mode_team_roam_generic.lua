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
  local bot = GetBot()
  local locations_times = GetHeroLastSeenInfo(GetMaxKillsEnemyPlayer())
  local location_time = functions.GetElementWith(
    locations_times,
    CompareMinTime,
    nil)

  if functions.IsEnemyNear(bot) then
     attack.Attack(bot, bot:GetCurrentVisionRange())
  else
    move.Move(bot, location_time[1])
  end
end

-- Provide an access to local functions and variables for unit tests only

return M
