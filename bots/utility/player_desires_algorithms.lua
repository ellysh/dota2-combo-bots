local functions = require(
  GetScriptDirectory() .."/utility/functions")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local common_algorithms = require(
  GetScriptDirectory() .."/utility/common_algorithms")

local M = {}

function M.has_low_hp()
  return common_algorithms.IsUnitLowHp(GetBot())
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

  local enemies = common_algorithms.GetEnemyHeroes(
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

  local enemies = common_algorithms.GetEnemyHeroes(bot, 700)

  return 0 < #enemies
end

function M.has_not_full_hp_mp_and_near_fountain()
  local bot = GetBot()

  if bot:GetHealth() == bot:GetMaxHealth()
     and bot:GetMana() == bot:GetMaxMana() then
     return false end

  return bot:HasModifier("modifier_fountain_aura_buff")
end

function M.is_focused_by_enemies()
  local bot = GetBot()
  local enemy_towers = bot:GetNearbyTowers(
    constants.MAX_TOWER_ATTACK_RANGE,
    true)

  local enemy_creeps = common_algorithms.GetEnemyCreeps(
    bot,
    constants.MAX_CREEP_ATTACK_RANGE)

  local enemy_heroes = common_algorithms.GetEnemyHeroes(
    bot,
    constants.MAX_HERO_ATTACK_RANGE)

  local total_damage =
    common_algorithms.GetTotalDamage(enemy_towers, bot) +
    common_algorithms.GetTotalDamage(enemy_creeps, bot) +
    common_algorithms.GetTotalDamage(enemy_heroes, bot)

  return 0.2 < functions.GetRate(total_damage, bot:GetHealth())
end

local function IsWeakerTarget(unit, target)
  local hits_to_die = functions.GetRate(
    unit:GetHealth(),
    target:GetAttackDamage())

  local hits_to_kill = functions.GetRate(
    target:GetHealth(),
    unit:GetAttackDamage())

  return hits_to_kill < hits_to_die
end

function M.is_one_weaker_enemy_hero_near()
  local bot = GetBot()
  local enemy_heroes = common_algorithms.GetEnemyHeroes(
    bot,
    constants.MAX_GET_UNITS_RADIUS)

  local enemy_hero = functions.GetElementWith(
    enemy_heroes,
    common_algorithms.CompareMaxHeroKills,
    function(unit)
      return common_algorithms.IsAttackTargetable(unit)
             and IsWeakerTarget(bot, unit)
    end)

  return enemy_hero ~= nil and #enemy_heroes == 1
end

function M.roam_target_is_near()
  local target_player = common_algorithms.GetMaxKillsPlayer(
    GetOpposingTeam(),
    function(p) return IsHeroAlive(p) end)

  local target_location =
    common_algorithms.GetLastPlayerLocation(target_player)

  return target_location ~= nil
         and GetUnitToLocationDistance(GetBot(), target_location)
             < constants.MAX_ROAM_RADIUS
end

function M.ally_hero_is_near()
  local bot = GetBot()
  local allies = common_algorithms.GetAllyHeroes(
    bot,
    constants.MAX_GROUP_RADIUS)

  return 0 < #allies
end

function M.has_level_six()
  return 6 <= GetBot():GetLevel()
end

-- Provide an access to local functions for unit tests only
M.test_PlayerOnLane = PlayerOnLane

return M
