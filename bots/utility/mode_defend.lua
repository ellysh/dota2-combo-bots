local attack = require(
  GetScriptDirectory() .."/utility/attack")

local move = require(
  GetScriptDirectory() .."/utility/move")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local common_algorithms = require(
  GetScriptDirectory() .."/utility/common_algorithms")

local M = {}

local ANCIENT = 1000

local BUILDINGS = {
  [LANE_TOP] = {
    {id = TOWER_TOP_1, type ="TYPE_TOWER"},
    {id = TOWER_TOP_2, type ="TYPE_TOWER"},
    {id = TOWER_TOP_3, type ="TYPE_TOWER"},
    {id = BARRACKS_TOP_MELEE, type = "TYPE_BARRACKS"},
    {id = BARRACKS_TOP_RANGED, type = "TYPE_BARRACKS"},
  },
  [LANE_BOT] = {
    {id = TOWER_BOT_1, type = "TYPE_TOWER"},
    {id = TOWER_BOT_2, type = "TYPE_TOWER"},
    {id = TOWER_BOT_3, type = "TYPE_TOWER"},
    {id = BARRACKS_BOT_MELEE, type = "TYPE_BARRACKS"},
    {id = BARRACKS_BOT_RANGED, type = "TYPE_BARRACKS"},
  },
  [LANE_MID] = {
    {id = TOWER_MID_1, type = "TYPE_TOWER"},
    {id = TOWER_MID_2, type = "TYPE_TOWER"},
    {id = TOWER_MID_3, type = "TYPE_TOWER"},
    {id = TOWER_BASE_1, type = "TYPE_TOWER"},
    {id = TOWER_BASE_2, type = "TYPE_TOWER"},
    {id = BARRACKS_MID_MELEE, type = "TYPE_BARRACKS"},
    {id = BARRACKS_MID_RANGED, type = "TYPE_BARRACKS"},
    {id = ANCIENT, type = "TYPE_ANCIENT"},
  },
}

local function GetNearestFrontBuilding(lane)
  local front_location = GetLaneFrontLocation(GetTeam(), lane, 0)
  local result = nil
  local min_distance = 10000000

  for _, building_info in pairs(BUILDINGS[lane]) do
    local building = common_algorithms.GetBuilding(
      building_info.id,
      building_info.type)

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
