local logger = require(
  GetScriptDirectory() .."/utility/logger")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local team_desires = require(
  GetScriptDirectory() .."/database/team_desires")

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

  for _, hero in pairs(ally_heroes) do

    if functions.IsElementInList(
      functions.GetInventoryItems(hero),
      item_name) then

      return true
    end
  end

  return false
end

function M.ally_have_aegis()
  return IsAllyHaveItem("item_aegis")
end

function M.ally_have_cheese()
  return IsAllyHaveItem("item_cheese")
end

-- TODO: Combine this function with the functions.GetUnitWith.
-- The only one difference is the unit:IsAlive() check.

local function GetPlayerWith(min_max, get_function, players)
  if #players == 0 then return nil end

  local current_value = functions.ternary(
    min_max == constants.MIN,
    1000000,
    -1)
  local result = nil

  for _, player in pairs(players) do
    if player == nil then goto continue end

    local player_value = get_function(player)
    local is_positive_comparison = functions.ternary(
      min_max == constants.MIN,
      player_value < current_value,
      current_value < player_value)

    if is_positive_comparison then
      current_value = player_value
      result = player
    end

    ::continue::
  end

  return result
end

function M.max_kills_enemy_hero_alive()
  local players = GetTeamPlayers(GetOpposingTeam())
  local player = GetPlayerWith(
    constants.MAX,
    function(player) return GetHeroKills(player) end,
    players)

  return player ~= nil and IsHeroAlive(player)
end

function M.max_kills_ally_hero_alive()
  local npc_bot = GetBot()

  if npc_bot == nil then return false end

  local players = GetTeamPlayers(npc_bot:GetTeam())
  local player = GetPlayerWith(
    constants.MAX,
    function(player) return GetHeroKills(player) end,
    players)

  return player ~= nil and IsHeroAlive(player)
end

function M.time_is_more_5_minutes()
  return (5 * 60) < DotaTime()
end

function M.time_is_more_15_minutes()
  return (15 * 60) < DotaTime()
end

local function ThreeAndMoreUnitsOnLane(unit_type, lane)
  local ally_heroes = GetUnitList(unit_type)
  local heroes_number = 0

  for _, hero in pairs(ally_heroes) do
    if not hero:IsAlive() or hero:IsIllusion() then goto continue end

    local disatnce_from_lane =
      GetAmountAlongLane(lane, hero:GetLocation()).distance

    if disatnce_from_lane < constants.MAX_HERO_DISTANCE_FROM_LANE then
      heroes_number = heroes_number + 1
    end

    ::continue::
  end

  return 3 <= heroes_number
end

function M.three_and_more_ally_heroes_on_top()
  return ThreeAndMoreUnitsOnLane(UNIT_LIST_ALLIED_HEROES, LANE_TOP)
end

function M.three_and_more_ally_heroes_on_mid()
  return ThreeAndMoreUnitsOnLane(UNIT_LIST_ALLIED_HEROES, LANE_MID)
end

function M.three_and_more_ally_heroes_on_bot()
  return ThreeAndMoreUnitsOnLane(UNIT_LIST_ALLIED_HEROES, LANE_BOT)
end

function M.three_and_more_enemy_heroes_on_top()
  return ThreeAndMoreUnitsOnLane(UNIT_LIST_ENEMY_HEROES , LANE_TOP)
end

function M.three_and_more_enemy_heroes_on_mid()
  return ThreeAndMoreUnitsOnLane(UNIT_LIST_ENEMY_HEROES , LANE_MID)
end

function M.three_and_more_enemy_heroes_on_bot()
  return ThreeAndMoreUnitsOnLane(UNIT_LIST_ENEMY_HEROES , LANE_BOT)
end

M.PUSH_LINES_DESIRE = {
  PUSH_TOP_LINE_DESIRE = 0,
  PUSH_MID_LINE_DESIRE = 0,
  PUSH_BOT_LINE_DESIRE = 0
}

local function ResetTeamDesires()
  for key, _ in pairs(M.PUSH_LINES_DESIRE) do
    M.PUSH_LINES_DESIRE[key] = 0
  end
end

function M.TeamThink()
  ResetTeamDesires()

  for algorithm, desires in functions.spairs(team_desires.TEAM_DESIRES) do
    if M[algorithm] == nil then goto continue end

    local desire_index = functions.ternary(M[algorithm](), 1, 2)

    for key, value in pairs(desires) do
      M.PUSH_LINES_DESIRE[key] =
        M.PUSH_LINES_DESIRE[key] + value[desire_index]
    end
    ::continue::
  end
end

function M.UpdatePushLaneDesires()
  return {
    M.PUSH_LINES_DESIRE["PUSH_TOP_LINE_DESIRE"],
    M.PUSH_LINES_DESIRE["PUSH_MID_LINE_DESIRE"],
    M.PUSH_LINES_DESIRE["PUSH_BOT_LINE_DESIRE"]
  }
end

-- Provide an access to local functions for unit tests only
M.test_IsAllyHaveItem = IsAllyHaveItem
M.test_ThreeAndMoreUnitsOnLane = ThreeAndMoreUnitsOnLane

return M
