local heroes = require(
  GetScriptDirectory() .."/database/heroes")

local logger = require(
  GetScriptDirectory() .."/utility/logger")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local M = {}

local function IsIntersectionOfLists(list1, list2)
  for _, e in pairs(list1) do
    if functions.IsElementInList(list2, e) then return true end
  end
  return false
end

local function GetPickedHeroesList(team)
  local players = GetTeamPlayers(team)
  local result = {}

  for _, player in pairs(players) do
    table.insert(result, GetSelectedHeroName(player))
  end

  return result
end

local function IsHeroPickedByTeam(hero, team)
  return functions.IsElementInList(
    GetPickedHeroesList(team),
    hero)
end

local function IsHeroPicked(hero)
  return IsHeroPickedByTeam(hero, GetTeam())
         or IsHeroPickedByTeam(hero, GetOpposingTeam())
end

local function GetRandomHero(position)
  local hero = functions.GetElementWith(
    heroes.HEROES,
    nil,
    function(hero)
      return functions.IsElementInList(hero.position, position)
             and not IsHeroPicked(hero.name)
             and functions.GetRandomTrue(0.5)
    end)

  if hero ~= nil then return hero.name else return nil end
end

local function GetComboHero(position, combo_heroes)
  local hero = functions.GetElementWith(
    heroes.HEROES,
    nil,
    function(hero)
      return functions.IsElementInList(hero.position, position)
             and not IsHeroPicked(hero.name)
             and IsIntersectionOfLists(hero.combo_heroes, combo_heroes)
    end)

  if hero ~= nil then
    return hero.name
  else
    return GetRandomHero(position)
  end
end

local function IsHumanPlayersPicked()
  local players = GetTeamPlayers(GetTeam())

  for _, player in pairs(players) do
    if not IsPlayerBot(player)
      and GetSelectedHeroName(player) == "" then

      return false
    end
  end
  return true
end

function Think()
  if not IsHumanPlayersPicked() then
    return
  end

  local players = GetTeamPlayers(GetTeam())

  local hero_position_5 = GetRandomHero(5)
  SelectHero(players[5], hero_position_5)

  local hero_position_4 = GetComboHero(4, {hero_position_5})
  SelectHero(players[4], hero_position_4)

  local hero_position_3 = GetComboHero(
    3,
    {hero_position_4, hero_position_5})

  SelectHero(players[3], hero_position_3)

  local hero_position_2 = GetComboHero(
    2,
    {hero_position_3, hero_position_4, hero_position_5})

  SelectHero(players[2], hero_position_2)

  local hero_position_1 = GetComboHero(
    1,
    {hero_position_2, hero_position_3, hero_position_4, hero_position_5})

  SelectHero(players[1], hero_position_1)
end

function UpdateLaneAssignments()
  -- Radiant:  easy lane = bot / hard lane = top
  -- Dire:     easy lane = top / hard lane = bot

  -- TODO: Consider the hero combos when choosing the lanes
  if ( GetTeam() == TEAM_RADIANT ) then
    return {
      [1] = LANE_BOT,
      [2] = LANE_MID,
      [3] = LANE_TOP,
      [4] = LANE_BOT,
      [5] = LANE_TOP,
    }
  elseif ( GetTeam() == TEAM_DIRE ) then
    return {
      [1] = LANE_TOP,
      [2] = LANE_MID,
      [3] = LANE_BOT,
      [4] = LANE_TOP,
      [5] = LANE_BOT,
    }
  end
end

function GetBotNames()
  return {"Alfa", "Bravo", "Charlie", "Delta", "Echo",
           "Foxtrot", "Mike", "Juliett", "Oscar", "Papa",
           "Romeo", "Sierra", "Tango", "Victor", "Yankee",
         }
end

-- Provide an access to local functions for unit tests only
M.test_GetBotNames = GetBotNames
M.test_IsIntersectionOfLists = IsIntersectionOfLists
M.test_GetPickedHeroesList = GetPickedHeroesList
M.test_IsHeroPickedByTeam = IsHeroPickedByTeam
M.test_IsHeroPicked = IsHeroPicked
M.test_GetRandomHero = GetRandomHero
M.test_GetComboHero = GetComboHero

return M
