local logger = require(
  GetScriptDirectory() .."/utility/logger")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local M = {}

function M.have_low_hp()
  if functions.GetUnitHealthLevel(GetBot())
     < constants.UNIT_LOW_HEALTH_LEVEL then

    return true
  end

  return false
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

function M.have_tp_scrol_or_travel_boots()
  local inventory = functions.GetInventoryItems(GetBot())

  return functions.IsElementInList(inventory, "item_tpscroll")
      or functions.IsElementInList(inventory, "item_travel_boots_1")
      or functions.IsElementInList(inventory, "item_travel_boots_2")
end

-- Provide an access to local functions for unit tests only
M.test_PlayerOnLane = PlayerOnLane

return M
