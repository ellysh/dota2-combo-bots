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
  local enemies = functions.GetEnemyHeroes(bot, 1600)
  local allies = functions.GetAllyHeroes(bot, 1600)

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

  local enemies = functions.GetEnemyHeroes(bot, 1600)

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

-- Provide an access to local functions for unit tests only
M.test_PlayerOnLane = PlayerOnLane

return M
