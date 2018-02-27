local functions = require(
  GetScriptDirectory() .."/utility/functions")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local player_desires = require(
  GetScriptDirectory() .."/utility/player_desires")

local move = require(
  GetScriptDirectory() .."/utility/move")

local attack = require(
  GetScriptDirectory() .."/utility/attack")

local memory = require(
  GetScriptDirectory() .."/utility/memory")

local M = {}

function GetDesire()
  return functions.GetNormalizedDesire(
    player_desires.GetDesire("BOT_MODE_FARM"),
    constants.MAX_FARM_DESIRE)
end

local function GetEnemyFrontLocations()
  local LANES = {LANE_TOP, LANE_BOT, LANE_MID}

  local result = {}

  for _, lane in pairs(LANES) do
    -- We replcate the format of the GetNeutralSpawners function here.
    -- It allows to process all farm spot locations in the same manner.

    table.insert(
      result,
      {
        type = lane,
        is_full = true,
        location = GetLaneFrontLocation(GetOpposingTeam(), lane, 0)
      })
  end

  return result
end

local function CompareMinDistance(t, a, b)
  return GetUnitToLocationDistance(GetBot(), t[a].location)
         < GetUnitToLocationDistance(GetBot(), t[b].location)
end

local function GetClosestFarmSpot()
  local farm_spots = memory.GetNeutralCampList()
  local front_lanes = GetEnemyFrontLocations()

  functions.TableConcat(farm_spots, front_lanes)

  local camp = functions.GetElementWith(
    farm_spots,
    CompareMinDistance,
    function(spot)
      return spot.is_full
    end)

  if camp == nil then
    return nil end

  return camp.location
end

function Think()
  local target_location = GetClosestFarmSpot()

  if target_location == nil then
    return end

  local bot = GetBot()

  local target = attack.ChooseTarget(
    bot,
    constants.MAX_GET_UNITS_RADIUS)

  if target ~= nil then
    attack.Attack(bot, target)
  elseif constants.MIN_HERO_DISTANCE_FROM_FARM_SPOT
     < GetUnitToLocationDistance(bot, target_location) then

    bot:Action_MoveToLocation(target_location)
  else
    memory.SetNeutralCampEmpty(target_location)
  end
end

-- Provide an access to local functions and variables for unit tests only
M.test_GetEnemyFrontLocations = GetEnemyFrontLocations
M.test_GetClosestFarmSpot = GetClosestFarmSpot

return M
