local functions = require(
  GetScriptDirectory() .."/utility/functions")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local player_desires = require(
  GetScriptDirectory() .."/utility/player_desires")

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
      {"", GetLaneFrontLocation(GetOpposingTeam(), lane, 0)})
  end

  return result
end

local function CompareMinDistance(t, a, b)
  return GetUnitToLocationDistance(GetBot(), t[a][2])
         < GetUnitToLocationDistance(GetBot(), t[b][2])
end

local function GetClosestFarmSpot(bot)
  local farm_spots = GetNeutralSpawners()

  local front_lanes = GetEnemyFrontLocations()

  functions.TableConcat(farm_spots, front_lanes)

  local result = functions.GetElementWith(
    farm_spots,
    CompareMinDistance,
    nil)

  return result[2]
end

function Think()
  local bot = GetBot()

  local target_location = GetClosestFarmSpot(bot)

  if target_location == nil then
    return end

  if constants.MIN_HERO_DISTANCE_FROM_FARM_SPOT
     < GetUnitToLocationDistance(bot, target_location) then

    bot:Action_MoveToLocation(target_location)
  else
    local target = attack.ChooseTarget(
      bot,
      constants.MAX_GET_UNITS_RADIUS)

    if target ~= nil then
      attack.Attack(bot, target)
    end
  end
end
