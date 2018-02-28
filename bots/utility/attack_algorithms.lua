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

local function IsLastHit(unit, bot)
  return unit:GetHealth() <= bot:GetAttackDamage()
end

function M.last_hit_enemy_creep(bot, radius)
  local creeps = common_algorithms.GetEnemyCreeps(bot, radius)
  local creep = functions.GetElementWith(
    creeps,
    common_algorithms.CompareMinHealth,
    function(unit)
      return common_algorithms.IsAttackTargetable(unit)
             and IsLastHit(unit, bot)
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

local function GetLowHpUnit(units)
  local result = functions.GetElementWith(
    units,
    common_algorithms.CompareMinHealth,
    function(unit)
      return common_algorithms.IsAttackTargetable(unit)
             and common_algorithms.IsUnitLowHp(unit)
    end)

    return result
end

function M.low_hp_enemy_hero(bot, radius)
  local enemy_heroes = common_algorithms.GetEnemyHeroes(bot, radius)
  local enemy_hero = GetLowHpUnit(enemy_heroes)

  if enemy_hero == nil then
    return false, nil end

  return true, enemy_hero
end

function M.low_hp_enemy_building(bot, radius)
  local enemy_buildings =
    common_algorithms.GetEnemyBuildings(bot, radius)

  local enemy_building = GetLowHpUnit(enemy_buildings)

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

function M.assist_ally_hero(bot, radius)
  local bot = GetBot()
  local allies = common_algorithms.GetGroupHeroes(bot)

  local target = nil

  local attacking_ally = functions.GetElementWith(
    allies,
    common_algorithms.CompareMaxHeroKills,
    function(unit)
      target = unit:GetTarget()
      return target ~= nil
             and target:IsHero()
             and common_algorithms.IsAttackTargetable(target)
             and GetUnitToUnitDistance(unit, target)
                 <= constants.MAX_ASSIST_RADIUS
    end)

  if attacking_ally == nil or target == nil then
    return false, nil end

  return true, target
end

function M.roshan(bot, radius)
  local creeps = common_algorithms.GetNeutralCreeps(bot, radius)
  local creep = functions.GetElementWith(
    creeps,
    common_algorithms.CompareMaxHealth,
    function(unit)
      return unit:GetUnitName() == "npc_dota_roshan"
    end)

  if creep == nil then
    return false, nil end

  return true, creep
end

local function GetDenyHpTower(units)
  local DENY_TOWER_HEALTH = 160

  local result = functions.GetElementWith(
    units,
    common_algorithms.CompareMinHealth,
    function(unit)
      return common_algorithms.IsAttackTargetable(unit)
             and unit:GetHealth() <= DENY_TOWER_HEALTH
    end)

    return result
end

function M.deny_ally_tower(bot, radius)
  local ally_towers =
    common_algorithms.GetAllyTowers(bot, radius)

  local target = GetDenyHpTower(ally_towers)

  if target == nil then
    return false, nil end

  return true, target
end

return M
