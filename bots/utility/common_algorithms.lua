local functions = require(
  GetScriptDirectory() .."/utility/functions")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local M = {}

function M.IsAttackTargetable(unit)
  return unit:CanBeSeen()
         and unit:IsAlive()
         and not unit:IsInvulnerable()
         and not unit:IsIllusion()
end

function M.CompareMaxHealth(t, a, b)
  return t[b]:GetHealth() < t[a]:GetHealth()
end

function M.CompareMinHealth(t, a, b)
  return t[a]:GetHealth() < t[b]:GetHealth()
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

local function GetNormalizedRadius(radius)
  if radius == nil or radius == 0 then
    return constants.DEFAULT_ABILITY_USAGE_RADIUS
  end

  -- TODO: Trick with MAX_ABILITY_USAGE_RADIUS breaks Sniper's ult.
  -- But the GetNearbyHeroes function has the maximum radius 1600.

  return functions.ternary(
    constants.MAX_ABILITY_USAGE_RADIUS < radius,
    constants.MAX_ABILITY_USAGE_RADIUS,
    radius)
end

function M.GetEnemyHeroes(bot, radius)
  return bot:GetNearbyHeroes(
    GetNormalizedRadius(radius),
    true,
    BOT_MODE_NONE)
end

function M.GetAllyHeroes(bot, radius)
  return bot:GetNearbyHeroes(
    GetNormalizedRadius(radius),
    false,
    BOT_MODE_NONE)
end

function M.GetEnemyCreeps(bot, radius)
  local enemy_creeps = bot:GetNearbyCreeps(
    GetNormalizedRadius(radius),
    true)

  local neutral_creeps = bot:GetNearbyNeutralCreeps(
    GetNormalizedRadius(radius))

  return functions.ComplementOfLists(enemy_creeps, neutral_creeps, true)
end

function M.GetNeutralCreeps(bot, radius)
  return bot:GetNearbyNeutralCreeps(GetNormalizedRadius(radius))
end

function M.GetAllyCreeps(bot, radius)
  return bot:GetNearbyCreeps(GetNormalizedRadius(radius), false)
end

function M.GetEnemyBuildings(bot, radius)
  local towers = bot:GetNearbyTowers(GetNormalizedRadius(radius), true)

  if #towers ~= 0 then
    return towers end

  return bot:GetNearbyBarracks(GetNormalizedRadius(radius), true)
end

function M.IsEnemyHeroOnTheWay(bot, location)
  local enemies = M.GetEnemyHeroes(bot, constants.MAX_GET_UNITS_RADIUS)
  local bot_distance = GetUnitToLocationDistance(bot, location)

  return nil ~= functions.GetElementWith(
    enemies,
    nil,
    function(unit)
      return GetUnitToLocationDistance(unit, location) < bot_distance
    end)
end

local function GetUnitManaLevel(unit)
  return unit:GetMana() / unit:GetMaxMana()
end

local function GetUnitHealthLevel(unit)
  return functions.GetRate(unit:GetHealth(), unit:GetMaxHealth())
end

function M.IsUnitLowHp(unit)
  return unit:GetHealth() <= constants.UNIT_LOW_HEALTH
         or GetUnitHealthLevel(unit)
            <= constants.UNIT_LOW_HEALTH_LEVEL
end

function M.IsUnitLowMp(unit)
  return GetUnitManaLevel(unit) <= constants.UNIT_LOW_MANA_LEVEL
end

function M.IsUnitHalfHp(unit)
  return GetUnitHealthLevel(unit) <= constants.UNIT_HALF_HEALTH_LEVEL
end

function M.GetLastPlayerLocation(player)
  if player == nil then
    return nil end

  local seen_info = GetHeroLastSeenInfo(player)

  if seen_info == nil
     or #seen_info == 0
     or seen_info[1] == nil
     or 10 < seen_info[1].time_since_seen then
    return nil end

  return seen_info[1].location
end

-- Provide an access to local functions for unit tests only
M.test_GetNormalizedRadius = GetNormalizedRadius
M.test_GetUnitHealthLevel = GetUnitHealthLevel

return M
