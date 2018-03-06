local functions = require(
  GetScriptDirectory() .."/utility/functions")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local common_algorithms = require(
  GetScriptDirectory() .."/utility/common_algorithms")

local M = {}

function M.ally_mega_creeps()
  local enemy_team = GetOpposingTeam()

  for i = 1,6,1 do
    local barrack = GetBarracks(enemy_team, i)

    if barrack ~= nil
      and not barrack:IsNull()
      and barrack:IsAlive() then

      return false
    end
  end

  return true
end

local function IsAllyHaveItem(item_name)
  local ally_heroes = GetUnitList(UNIT_LIST_ALLIED_HEROES)

  local hero = functions.GetElementWith(
    ally_heroes,
    nil,
    function(hero)
      return functions.IsUnitHaveItems(hero, {item_name})
    end)

  return hero ~= nil
end

function M.ally_has_aegis()
  return IsAllyHaveItem("item_aegis")
end

function M.ally_has_cheese()
  return IsAllyHaveItem("item_cheese")
end

function M.max_kills_enemy_hero_alive()
  local player = common_algorithms.GetMaxKillsPlayer(
    GetOpposingTeam(),
    nil)

  return player ~= nil and IsHeroAlive(player)
end

function M.max_kills_ally_hero_alive()
  local player = common_algorithms.GetMaxKillsPlayer(
    GetTeam(),
    nil)

  return player ~= nil and IsHeroAlive(player)
end

function M.time_is_more_3_minutes()
  return (3 * 60) < DotaTime()
end

local function UnitsOnLane(unit_type, lane)
  local units = GetUnitList(unit_type)
  local result = {}

  for _, unit in pairs(units) do
    if not unit:IsAlive() or unit:IsIllusion() then
      do goto continue end
    end

    local disatnce_from_lane =
      GetAmountAlongLane(lane, unit:GetLocation()).distance

    if disatnce_from_lane < constants.MAX_HERO_DISTANCE_FROM_LANE then
      table.insert(result, unit)
    end

    ::continue::
  end

  return result
end

function M.more_ally_heroes_on_top_then_enemy()
  local allies = #UnitsOnLane(UNIT_LIST_ALLIED_HEROES, LANE_TOP)
  local enemies = #UnitsOnLane(UNIT_LIST_ENEMY_HEROES, LANE_TOP)

  return allies < (enemies - 1)
end

function M.more_ally_heroes_on_mid_then_enemy()
  local allies = #UnitsOnLane(UNIT_LIST_ALLIED_HEROES, LANE_MID)
  local enemies = #UnitsOnLane(UNIT_LIST_ENEMY_HEROES, LANE_MID)

  return allies < (enemies - 1)
end

function M.more_ally_heroes_on_bot_then_enemy()
  local allies = #UnitsOnLane(UNIT_LIST_ALLIED_HEROES, LANE_BOT)
  local enemies = #UnitsOnLane(UNIT_LIST_ENEMY_HEROES, LANE_BOT)

  return allies < (enemies - 1)
end

function M.no_enemy_heroes_on_top()
  return 0 == #UnitsOnLane(UNIT_LIST_ENEMY_HEROES, LANE_TOP)
end

function M.no_enemy_heroes_on_mid()
  return 0 == #UnitsOnLane(UNIT_LIST_ENEMY_HEROES, LANE_MID)
end

function M.no_enemy_heroes_on_bot()
  return 0 == #UnitsOnLane(UNIT_LIST_ENEMY_HEROES, LANE_BOT)
end

function M.more_ally_heroes_alive_then_enemy()
  local ally_number = functions.GetNumberOfElementsWith(
    GetTeamPlayers(GetTeam()),
    function(player) return IsHeroAlive(player) end)

  local enemy_number = functions.GetNumberOfElementsWith(
    GetTeamPlayers(GetOpposingTeam()),
    function(player) return IsHeroAlive(player) end)

  return enemy_number < ally_number
end

function M.is_night()
  return GetTimeOfDay() < 0.25
         or 0.75 < GetTimeOfDay()
end

function M.all_enemy_team_dead()
  local players = GetTeamPlayers(GetOpposingTeam())
  local player = functions.GetElementWith(
    players,
    nil,
    function(p) return IsHeroAlive(p) end)

  return player == nil
end

local function IsEnemyHeroInLocation(location)
  local ally_heroes = GetUnitList(UNIT_LIST_ALLIED_HEROES)
  local nearby_ally = functions.GetElementWith(
    ally_heroes,
    nil,
    function(unit)
      return GetUnitToLocationDistance(unit, location)
             < unit:GetCurrentVisionRange()
    end)

  -- We consider that there is an enemy if the location is not seen
  if nearby_ally == nil then
    return true end

  local enemy_heroes = common_algorithms.GetEnemyHeroes(
    nearby_ally,
    constants.MAX_GET_UNITS_RADIUS)

  return 0 < #enemy_heroes
end

function M.enemy_hero_was_seen()
  local player = common_algorithms.GetMaxKillsPlayer(
    GetOpposingTeam(),
    function(p) return IsHeroAlive(p) end)

  local player_location = common_algorithms.GetLastPlayerLocation(player)
  return player_location ~= nil
         and IsEnemyHeroInLocation(player_location)
end

local function GetEnemyUnitsNearLocation(unit_type, location, radius)
  local units = GetUnitList(unit_type)
  local result = {}

  functions.DoWithKeysAndElements(
    units,
    function(_, unit)
      if GetUnitToLocationDistance(unit, location) <= radius then
        table.insert(result, unit)
      end
    end)

  return result
end

local function IsThreeEnemyHeroesOnLane(lane)
  local units = UnitsOnLane(UNIT_LIST_ENEMY_HEROES, lane)
  local building = common_algorithms.GetNearestFrontBuilding(lane)
  local units_number = 0

  functions.DoWithKeysAndElements(
    units,
    function(_, unit)
      if GetUnitToUnitDistance(unit, building)
         <= constants.MAX_ENEMY_TO_BUILDING_RADIUS then
        units_number = units_number + 1
      end
    end)

  return 3 <= units_number
end

function M.three_enemy_heroes_on_bot()
  return IsThreeEnemyHeroesOnLane(LANE_BOT)
end

function M.three_enemy_heroes_on_mid()
  return IsThreeEnemyHeroesOnLane(LANE_MID)
end

function M.three_enemy_heroes_on_top()
  return IsThreeEnemyHeroesOnLane(LANE_TOP)
end

local function IsBuildingFocusedByEnemies(building)
  if building == nil then
    return false end

  local enemy_creeps = GetEnemyUnitsNearLocation(
    UNIT_LIST_ENEMY_CREEPS,
    building:GetLocation(),
    constants.MAX_CREEP_ATTACK_RANGE)

  local enemy_heroes = GetEnemyUnitsNearLocation(
    UNIT_LIST_ENEMY_HEROES,
    building:GetLocation(),
    constants.MAX_HERO_ATTACK_RANGE)

  local total_damage =
    common_algorithms.GetTotalDamage(enemy_creeps, building) +
    common_algorithms.GetTotalDamage(enemy_heroes, building)

  return 0.05 < functions.GetRate(total_damage, building:GetHealth())

end

function M.is_bot_building_focused_by_enemies()
  return IsBuildingFocusedByEnemies(
           common_algorithms.GetNearestFrontBuilding(LANE_BOT))
end

function M.is_top_building_focused_by_enemies()
  return IsBuildingFocusedByEnemies(
           common_algorithms.GetNearestFrontBuilding(LANE_TOP))
end

function M.is_mid_building_focused_by_enemies()
  return IsBuildingFocusedByEnemies(
           common_algorithms.GetNearestFrontBuilding(LANE_MID))
end

function M.enough_damage_and_health_for_roshan()
  -- The factor value is required to tune the bots strength when
  -- they decide to kill Roshan.
  local FACTOR = 1.5
  local ROSHAN_HEALTH = 5500 * FACTOR
  local ROSHAN_DAMAGE = 65 * FACTOR

  local ally_heroes = GetUnitList(UNIT_LIST_ALLIED_HEROES)

  return common_algorithms.IsWeakerTarget(
    ally_heroes,
    ROSHAN_HEALTH,
    ROSHAN_DAMAGE)
end

function M.is_roshan_alive()
  local MAX_ROSHAN_RESPAWN_MINUTES = 11
  return MAX_ROSHAN_RESPAWN_MINUTES * 60
         <= (DotaTime() - GetRoshanKillTime())
end

-- Provide an access to local functions for unit tests only
M.test_IsAllyHaveItem = IsAllyHaveItem
M.test_UnitsOnLane = UnitsOnLane
M.test_IsBuildingFocusedByEnemies = IsBuildingFocusedByEnemies
M.test_IsThreeEnemyHeroesOnLane = IsThreeEnemyHeroesOnLane

return M
