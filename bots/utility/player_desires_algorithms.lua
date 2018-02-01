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

-- Provide an access to local functions for unit tests only
M.test_PlayerOnLane = PlayerOnLane

return M
