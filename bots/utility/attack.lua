local functions = require(
  GetScriptDirectory() .."/utility/functions")

local attack_target = require(
  GetScriptDirectory() .."/database/attack_target")

local M = {}

-- TODO: Move the algorithms to the separate module

-- TODO: Fix the code duplication below. We have the same code in the
-- ability_usage_algorithms.lua module.

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
  local enemy_heroes = bot:GetNearbyHeroes(radius, true, BOT_MODE_NONE)
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

function M.last_hit_hp_creep(bot, radius)
  local creeps = functions.GetEnemyCreeps(bot, radius)
  local creep = functions.GetElementWith(
    creeps,
    CompareMinHealth,
    function(unit)
      return IsTargetable() and IsLastHit(bot, unit)
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

-----------

local function GetDesire(bot, mode_desires)
  for mode, desire in pairs(mode_desires) do
    if functions.IsBotModeMatch(bot, mode) then
      return desire end
  end
  return 0
end

local function ChooseTarget(bot)
  local radius = bot:GetCurrentVisionRange()
  local targets = {}

  for algorithm, mode_desires in pairs(attack_target.ATTACK_TARGET) do
    if M[algorithm] == nil then
      do goto continue end
    end

    local is_succeed, target = M[algorithm](bot, radius)

    if is_succeed then
      targets[GetDesire(bot, mode_desires)] = target
    end
    ::continue::
  end

  return functions.GetElementWith(
    targets,
    function(t, a, b)
      return b < a
    end)
end

function M.Attack(bot)
  local bot = GetBot()

  if functions.IsBotBusy(bot) then
    return end

  local target = ChooseTarget(bot)

  bot:Action_AttackUnit(target, false)
end

return M
