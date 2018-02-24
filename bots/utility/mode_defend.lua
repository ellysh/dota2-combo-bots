local attack = require(
  GetScriptDirectory() .."/utility/attack")

local move = require(
  GetScriptDirectory() .."/utility/move")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local M = {}

local ANCIENT = 1000

local BUILDINGS = {
  [LANE_TOP] = {
    [TOWER_TOP_1] = "TYPE_TOWER",
    [TOWER_TOP_2] = "TYPE_TOWER",
    [TOWER_TOP_3] = "TYPE_TOWER",
    [BARRACKS_TOP_MELEE] = "TYPE_BARRACKS",
    [BARRACKS_TOP_RANGED] = "TYPE_BARRACKS",
  },
  [LANE_BOT] = {
    [TOWER_BOT_1] = "TYPE_TOWER",
    [TOWER_BOT_2] = "TYPE_TOWER",
    [TOWER_BOT_3] = "TYPE_TOWER",
    [BARRACKS_BOT_MELEE] = "TYPE_BARRACKS",
    [BARRACKS_BOT_RANGED] = "TYPE_BARRACKS",
  },
  [LANE_MID] = {
    [TOWER_MID_1] = "TYPE_TOWER",
    [TOWER_MID_2] = "TYPE_TOWER",
    [TOWER_MID_3] = "TYPE_TOWER",
    [TOWER_BASE_1] = "TYPE_TOWER",
    [TOWER_BASE_2] = "TYPE_TOWER",
    [BARRACKS_MID_MELEE] = "TYPE_BARRACKS",
    [BARRACKS_MID_RANGED] = "TYPE_BARRACKS",
    [ANCIENT] = "TYPE_ANCIENT",
  },
}

local function GetNearestFrontBuilding(lane)
  local front_location = GetLaneFrontLocation(GetTeam(), lane, 0)
  local result = nil
  local min_distance = 10000000

  for building_id, building_type in pairs(BUILDINGS[lane]) do
    local building = functions.GetBuilding(building_id, building_type)

    if GetUnitToLocationDistance(building, front_location)
       < min_distance then

       result = building
    end
  end

  return result
end

function M.Think(lane)
  local bot = GetBot()
  local target = attack.ChooseTarget(bot, constants.MAX_GET_UNITS_RADIUS)

  if target ~= nil then
    attack.Attack(bot, target)
  else
    local target_location = GetNearestFrontBuilding(lane):GetLocation()

    move.Move(bot, target_location)
  end
end

return M
