local functions = require(
  GetScriptDirectory() .."/utility/functions")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local common_algorithms = require(
  GetScriptDirectory() .."/utility/common_algorithms")

local M = {}

function M.max_kills_enemy_hero(bot, radius)
  local enemy_heroes = common_algorithms.GetEnemyHeroes(bot, radius)
  local enemy_hero = functions.GetElementWith(
    enemy_heroes,
    common_algorithms.CompareMaxHeroKills,
    common_algorithms.IsAttackTargetable)

  if enemy_hero == nil then
    return false, nil end

  return true, enemy_hero
end

function M.max_hp_enemy_creep(bot, radius)
  local creeps = common_algorithms.GetEnemyCreeps(bot, radius)
  local creep = functions.GetElementWith(
    creeps,
    common_algorithms.CompareMaxHealth,
    common_algorithms.IsAttackTargetable)

  if creep == nil then
    return false, nil end

  return true, creep
end

function M.max_hp_neutral_creep(bot, radius)
  local creeps = common_algorithms.GetNeutralCreeps(bot, radius)
  local creep = functions.GetElementWith(
    creeps,
    common_algorithms.CompareMaxHealth,
    common_algorithms.IsAttackTargetable)

  if creep == nil then
    return false, nil end

  return true, creep
end

local function IsLastHit(bot, unit)
  return unit:GetHealth() <= bot:GetAttackDamage()
end

function M.last_hit_enemy_creep(bot, radius)
  local creeps = common_algorithms.GetEnemyCreeps(bot, radius)
  local creep = functions.GetElementWith(
    creeps,
    common_algorithms.CompareMinHealth,
    function(unit)
      return common_algorithms.IsAttackTargetable(unit)
             and IsLastHit(bot, unit)
    end)

  if creep == nil then
    return false, nil end

  return true, creep
end

function M.min_hp_enemy_building(bot, radius)
  local enemy_buildings =
    common_algorithms.GetEnemyBuildings(bot, radius)

  local enemy_building = functions.GetElementWith(
    enemy_buildings,
    common_algorithms.CompareMinHealth,
    common_algorithms.IsAttackTargetable)

  if enemy_building == nil then
    return false, nil end

  return true, enemy_building
end

function M.low_hp_enemy_hero(bot, radius)
  local enemy_heroes = common_algorithms.GetEnemyHeroes(bot, radius)
  local enemy_hero = functions.GetElementWith(
    enemy_heroes,
    common_algorithms.CompareMinHealth,
    function(unit)
      return common_algorithms.IsAttackTargetable(unit)
             and common_algorithms.IsUnitLowHp(unit)
    end)

  if enemy_hero == nil then
    return false, nil end

  return true, enemy_hero
end

function M.low_hp_enemy_building(bot, radius)
  local enemy_buildings =
    common_algorithms.GetEnemyBuildings(bot, radius)

  local enemy_building = functions.GetElementWith(
    enemy_buildings,
    common_algorithms.CompareMinHealth,
    function(unit)
      return common_algorithms.IsAttackTargetable(unit)
             and common_algorithms.IsUnitLowHp(unit)
    end)

  if enemy_building == nil then
    return false, nil end

  return true, enemy_building
end

function M.attacking_enemy_hero(bot, radius)
  local enemy_heroes = common_algorithms.GetEnemyHeroes(bot, radius)
  local enemy_hero = functions.GetElementWith(
    enemy_heroes,
    common_algorithms.CompareMaxHeroKills,
    function(unit)
      return common_algorithms.IsAttackTargetable(unit)
             and unit:GetAttackTarget() == bot
    end)

  if enemy_hero == nil then
    return false, nil end

  return true, enemy_hero
end

function M.attacking_enemy_creep(bot, radius)
  local enemy_creeps = common_algorithms.GetEnemyCreeps(bot, radius)
  local enemy_creep = functions.GetElementWith(
    enemy_creeps,
    common_algorithms.CompareMinHealth,
    function(unit)
      return common_algorithms.IsAttackTargetable(unit)
             and unit:GetAttackTarget() == bot
    end)

  if enemy_creep == nil then
    return false, nil end

  return true, enemy_creep
end

-- Provide an access to local functions and variables for unit tests only
M.test_IsLastHit = IsLastHit

return M
