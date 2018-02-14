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

function M.more_enemy_heroes_around_then_ally()
  local bot = GetBot()
  local enemies = functions.GetEnemyHeroes(
    bot,
    constants.MAX_GET_UNITS_RADIUS)
  local allies = functions.GetAllyHeroes(
    bot,
    constants.MAX_GET_UNITS_RADIUS)

  return #allies < (#enemies - 1)
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

function M.is_attacked_by_tower()
  local bot = GetBot()
  local towers = bot:GetNearbyTowers(
    constants.MAX_GET_UNITS_RADIUS,
    true)

  if #towers == 0 then
    return false end

  return towers[1]:GetAttackTarget() == bot
end

function M.is_attacked_by_enemy_hero()
  return GetBot():WasRecentlyDamagedByAnyHero(0.5)
end

function M.is_attacked_by_enemy_creep()
  local enemy_creeps = functions.GetEnemyCreeps(GetBot(), 600)

  if #enemy_creeps == 0 then
    return false end

  return GetBot():WasRecentlyDamagedByCreep(0.5)
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
