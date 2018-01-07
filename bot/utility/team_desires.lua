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
  local players = GetTeamPlayers(GetBot():GetTeam())
  local player = GetPlayerWith(
    constants.MAX,
    function(player) return GetHeroKills(player) end,
    players)

  return player ~= nil and IsHeroAlive(player)
end

function M.time_is_less_5_minutes()
  return DotaTime() < (5 * 60)
end

M.PUSH_LINES_DESIRE = {
  PUSH_TOP_LINE_DESIRE = 0.0,
  PUSH_MID_LINE_DESIRE = 0.0,
  PUSH_BOT_LINE_DESIRE = 0.0
}

function M.TeamThink()
  for algorithm, desires in functions.spairs(team_desires.TEAM_DESIRES) do
    if M[algorithm] == nil then goto continue end

    local desire_index = functions.ternary(M[algorithm](), 1, 2)

    for name, value in pairs(desires) do
      M.PUSH_LINES_DESIRE[name] =
        M.PUSH_LINES_DESIRE[name] + value[desire_index]
    end
    ::continue::
  end

end

-- Provide an access to local functions for unit tests only
M.test_IsAllyHaveItem = IsAllyHaveItem

return M
