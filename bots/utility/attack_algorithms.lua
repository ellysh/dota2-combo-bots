local functions = require(
  GetScriptDirectory() .."/utility/functions")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local M = {}

local function IsTargetable(unit)
  return unit:CanBeSeen()
         and unit:IsAlive()
         and not unit:IsInvulnerable()
         and not unit:IsIllusion()
end

local function CompareMaxHeroKills(t, a, b)
  return GetHeroKills(t[b]:GetPlayerID()) <
    GetHeroKills(t[a]:GetPlayerID())
end

function M.max_kills_enemy_hero(bot, radius)
  local enemy_heroes = functions.GetEnemyHeroes(bot, radius)
  local enemy_hero = functions.GetElementWith(
    enemy_heroes,
    CompareMaxHeroKills,
    IsTargetable)

  if enemy_hero == nil then
    return false, nil end

  return true, enemy_hero
end

local function CompareMaxEstimatedDamage(t, a, b)
  local b_damage = t[b]:GetEstimatedDamageToTarget(
    true,
    GetBot(),
    3.0,
    DAMAGE_TYPE_ALL)

  local a_damage = t[a]:GetEstimatedDamageToTarget(
    true,
    GetBot(),
    3.0,
    DAMAGE_TYPE_ALL)

  return b_damage < a_damage
end

function M.max_estimated_damage_enemy_hero(bot, radius)
  local enemy_heroes = functions.GetEnemyHeroes(bot, radius)

  local enemy_hero = functions.GetElementWith(
    enemy_heroes,
    CompareMaxEstimatedDamage,
    IsTargetable)

  if enemy_hero == nil then
    return false, nil end

  return true, enemy_hero
end

local function CompareMaxHealth(t, a, b)
  return t[b]:GetHealth() < t[a]:GetHealth()
end

local function CompareMinHealth(t, a, b)
  return t[a]:GetHealth() < t[b]:GetHealth()
end

function M.max_hp_creep(bot, radius)
  local creeps = functions.GetEnemyCreeps(bot, radius)
  local creep = functions.GetElementWith(
    creeps,
    CompareMaxHealth,
    IsTargetable)

  if creep == nil then
    return false, nil end

  return true, creep
end

local function IsLastHit(bot, unit)
  return unit:GetHealth() <= bot:GetAttackDamage()
end

function M.last_hit_creep(bot, radius)
  local creeps = functions.GetEnemyCreeps(bot, radius)
  local creep = functions.GetElementWith(
    creeps,
    CompareMinHealth,
    function(unit)
      return IsTargetable(unit) and IsLastHit(bot, unit)
    end)

  if creep == nil then
    return false, nil end

  return true, creep
end

function M.min_hp_enemy_building(bot, radius)
  local enemy_buildings =
    functions.GetEnemyBuildings(bot, radius)

  local enemy_building = functions.GetElementWith(
    enemy_buildings,
    CompareMinHealth,
    IsTargetable)

  if enemy_building == nil then
    return false, nil end

  return true, enemy_building
end

function M.low_hp_enemy_hero(bot, radius)
  local enemy_heroes = functions.GetEnemyHeroes(bot, radius)
  local enemy_hero = functions.GetElementWith(
    enemy_heroes,
    CompareMinHealth,
    function(unit)
      return IsTargetable(unit)
             and functions.GetUnitHealthLevel(unit)
                 <= constants.UNIT_LOW_HEALTH_LEVEL
    end)

  if enemy_hero == nil then
    return false, nil end

  return true, enemy_hero
end

function M.low_hp_enemy_building(bot, radius)
  local enemy_buildings =
    functions.GetEnemyBuildings(bot, radius)

  local enemy_building = functions.GetElementWith(
    enemy_buildings,
    CompareMinHealth,
    function(unit)
      return IsTargetable(unit)
             and functions.GetUnitHealthLevel(unit)
                 <= constants.UNIT_LOW_HEALTH_LEVEL
    end)

  if enemy_building == nil then
    return false, nil end

  return true, enemy_building
end

-- Provide an access to local functions and variables for unit tests only
M.test_IsTargetable = IsTargetable
M.test_IsLastHit = IsLastHit

return M
