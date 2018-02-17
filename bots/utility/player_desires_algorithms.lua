 local logger = require(
  GetScriptDirectory() .."/utility/logger")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local M = {}

function M.has_low_hp()
  return functions.IsUnitLowHp(GetBot())
end

local function PlayerOnLane(lane)
  local disatnce_from_lane =
    GetAmountAlongLane(lane, GetBot():GetLocation()).distance

  return disatnce_from_lane < constants.MAX_HERO_DISTANCE_FROM_LANE
end

function M.player_on_top()
  return PlayerOnLane(LANE_TOP)
end

function M.player_on_mid()
  return PlayerOnLane(LANE_MID)
end

function M.player_on_bot()
  return PlayerOnLane(LANE_BOT)
end

function M.has_tp_scrol_or_travel_boots()
  return functions.IsUnitHaveItems(
    GetBot(),
    {
      "item_tpscroll",
      "item_travel_boots_1",
      "item_travel_boots_2"
    })
end

function M.has_buyback()
  local bot = GetBot()

  return bot:HasBuyback()
         and bot:GetBuybackCost() <= bot:GetGold()
end

function M.is_shrine_healing_and_no_enemy()
  local bot = GetBot()

  local shrines = bot:GetNearbyShrines(
      constants.SHRINE_AURA_RADIUS,
      false)

  if #shrines == 0
     or not IsShrineHealing(shrines[1]) then
    return false end

  local enemies = functions.GetEnemyHeroes(
    bot,
    constants.MAX_GET_UNITS_RADIUS)

  return #enemies == 0
end

function M.is_shrine_healing_and_enemies_near()
  local bot = GetBot()

  local shrines = bot:GetNearbyShrines(
      constants.SHRINE_AURA_RADIUS,
      false)

  if #shrines == 0
     or not IsShrineHealing(shrines[1]) then
    return false end

  local enemies = functions.GetEnemyHeroes(bot, 700)

  return 0 < #enemies
end

function M.has_not_full_hp_mp_and_near_fountain()
  local bot = GetBot()

  if bot:GetHealth() == bot:GetMaxHealth()
     and bot:GetMana() == bot:GetMaxMana() then
     return false end

  return bot:HasModifier("modifier_fountain_aura_buff")
end

local function GetTotalDamage(units, target)
  local total_damage = 0

  functions.DoWithElements(
    units,
    function(unit)
      if unit:GetAttackTarget() == target then
        total_damage = total_damage + unit:GetAttackDamage()
      end
    end)

  return total_damage
end

function M.is_focused_by_enemy_towers()
  local bot = GetBot()
  local enemy_towers = bot:GetNearbyTowers(
    constants.MAX_TOWER_ATTACK_RANGE,
    true)

  return 0.1 < functions.GetRate(
                 GetTotalDamage(enemy_towers, bot),
                 bot:GetHealth())
end

function M.is_enemy_heroes_near()
  local bot = GetBot()
  local enemy_heroes = functions.GetEnemyHeroes(
    bot,
    constants.MAX_GET_UNITS_RADIUS)

  return 0 < #enemy_heroes
end

-- TODO: Move this function to functions.IsAttackTargetable.
-- This is a duplicate of the attack_algorithms.IsTargetable.

local function IsTargetable(unit)
  return unit:CanBeSeen()
         and unit:IsAlive()
         and not unit:IsInvulnerable()
         and not unit:IsIllusion()
end

local function IsFocusedByEnemyHeroes(is_stronger)
  local bot = GetBot()
  local enemy_heroes = functions.GetEnemyHeroes(
    bot,
    constants.MAX_GET_UNITS_RADIUS)

  if #enemy_heroes == 0 then
    return false end

  local enemy_hero = functions.GetElementWith(
    enemy_heroes,
    CompareMaxHeroKills,
    IsTargetable)

  if enemy_hero == nil then
    return false end

  -- TODO: Should we consider enemy/allies creeps/towers in this calculation?
  local hits_to_die = bot:GetHealth() / GetTotalDamage(enemy_heroes, bot)
  local hits_to_kill = enemy_hero:GetHealth() / bot:GetAttackDamage()

  return functions.ternary(is_stronger,
    hits_to_die <= hits_to_kill,
    hits_to_kill < hits_to_die)
end

function M.is_focused_by_stronger_enemy_heroes()
  return IsFocusedByEnemyHeroes(true)
end

function M.is_focused_by_weaker_enemy_heroes()
  return IsFocusedByEnemyHeroes(false)
end

function M.is_focused_by_enemy_creeps()
  local bot = GetBot()
  local enemy_creeps = functions.GetEnemyCreeps(
    bot,
    constants.MAX_CREEP_ATTACK_RANGE)

  return 0.1 < functions.GetRate(
                 GetTotalDamage(enemy_creeps, bot),
                 bot:GetHealth())
end

function M.roam_target_is_near()
  local target_player = functions.GetMaxKillsPlayer(
    GetOpposingTeam(),
    function(p) return IsHeroAlive(p) end)

  local target_location = functions.GetLastPlayerLocation(target_player)
  return target_location ~= nil
         and GetUnitToLocationDistance(GetBot(), target_location)
             < constants.MAX_ROAM_RADIUS
end

-- Provide an access to local functions for unit tests only
M.test_PlayerOnLane = PlayerOnLane

return M
