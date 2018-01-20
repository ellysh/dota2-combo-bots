local logger = require(
  GetScriptDirectory() .."/utility/logger")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

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

function M.ally_have_aegis()
  return IsAllyHaveItem("item_aegis")
end

function M.ally_have_cheese()
  return IsAllyHaveItem("item_cheese")
end

local function CompareMaxHeroKills(t, a, b)
  return GetHeroKills(t[b]) < GetHeroKills(t[a])
end

function M.max_kills_enemy_hero_alive()
  local players = GetTeamPlayers(GetOpposingTeam())
  local player = functions.GetElementWith(
    players,
    CompareMaxHeroKills,
    nil)

  return player ~= nil and IsHeroAlive(player)
end

function M.max_kills_ally_hero_alive()
  local players = GetTeamPlayers(GetTeam())
  local player = functions.GetElementWith(
    players,
    CompareMaxHeroKills,
    nil)

  return player ~= nil and IsHeroAlive(player)
end

function M.time_is_more_5_minutes()
  return (5 * 60) < DotaTime()
end

function M.time_is_more_15_minutes()
  return (15 * 60) < DotaTime()
end

local function NumberUnitsOnLane(unit_type, lane)
  local units = GetUnitList(unit_type)

  local units_number = 0

  for _, unit in pairs(units) do
    if not unit:IsAlive() or unit:IsIllusion() then
      do goto continue end
    end

    local disatnce_from_lane =
      GetAmountAlongLane(lane, unit:GetLocation()).distance

    if disatnce_from_lane < constants.MAX_HERO_DISTANCE_FROM_LANE then
      units_number = units_number + 1
    end

    ::continue::
  end

  return units_number
end

function M.three_and_more_ally_heroes_on_top()
  return 3 <= NumberUnitsOnLane(UNIT_LIST_ALLIED_HEROES, LANE_TOP)
end

function M.three_and_more_ally_heroes_on_mid()
  return 3 <= NumberUnitsOnLane(UNIT_LIST_ALLIED_HEROES, LANE_MID)
end

function M.three_and_more_ally_heroes_on_bot()
  return 3 <= NumberUnitsOnLane(UNIT_LIST_ALLIED_HEROES, LANE_BOT)
end

function M.three_and_more_enemy_heroes_on_top()
  return 3 <= NumberUnitsOnLane(UNIT_LIST_ENEMY_HEROES , LANE_TOP)
end

function M.three_and_more_enemy_heroes_on_mid()
  return 3 <= NumberUnitsOnLane(UNIT_LIST_ENEMY_HEROES , LANE_MID)
end

function M.three_and_more_enemy_heroes_on_bot()
  return 3 <= NumberUnitsOnLane(UNIT_LIST_ENEMY_HEROES , LANE_BOT)
end

function M.no_enemy_heroes_on_top()
  return 0 == NumberUnitsOnLane(UNIT_LIST_ENEMY_HEROES , LANE_TOP)
end

function M.no_enemy_heroes_on_mid()
  return 0 == NumberUnitsOnLane(UNIT_LIST_ENEMY_HEROES , LANE_MID)
end

function M.no_enemy_heroes_on_bot()
  return 0 == NumberUnitsOnLane(UNIT_LIST_ENEMY_HEROES , LANE_BOT)
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

-- Provide an access to local functions for unit tests only
M.test_IsAllyHaveItem = IsAllyHaveItem
M.test_NumberUnitsOnLane = NumberUnitsOnLane

return M
