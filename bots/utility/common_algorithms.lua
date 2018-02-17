local functions = require(
  GetScriptDirectory() .."/utility/functions")

local M = {}

function M.IsAttackTargetable(unit)
  return unit:CanBeSeen()
         and unit:IsAlive()
         and not unit:IsInvulnerable()
         and not unit:IsIllusion()
end

function M.CompareMaxHeroKills(t, a, b)
  return GetHeroKills(t[b]:GetPlayerID()) <
    GetHeroKills(t[a]:GetPlayerID())
end

local function CompareMaxPlayerKills(t, a, b)
  return GetHeroKills(t[b]) < GetHeroKills(t[a])
end

function M.GetMaxKillsPlayer(team, validate_function)
  local players = GetTeamPlayers(team)
  local player = functions.GetElementWith(
    players,
    CompareMaxPlayerKills,
    validate_function)

  return player
end

-- Provide an access to local functions for unit tests only

return M
