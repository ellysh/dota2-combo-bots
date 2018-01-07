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

function M.max_kills_enemy_hero_alive()
  local enemy_hero = functions.GetUnitWith(
    constants.MAX,
    function(unit) return GetHeroKills(unit:GetPlayerID()) end,
    GetUnitList(UNIT_LIST_ENEMY_HEROES))

  return enemy_hero:IsAlive()
end

function M.max_kills_ally_hero_alive()
  local ally_hero = functions.GetUnitWith(
    constants.MAX,
    function(unit) return GetHeroKills(unit:GetPlayerID()) end,
    GetUnitList(UNIT_LIST_ALLIED_HEROES))

  return ally_hero:IsAlive()
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
