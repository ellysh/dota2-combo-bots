local heroes = require(
  GetScriptDirectory() .."/database/heroes")

local logger = require(
  GetScriptDirectory() .."/utility/logger")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local M = {}

-- TODO: Move this function in the functions module
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

local function GetHeroPositions(hero)
  if heroes.HEROES[hero] ~= nil then
    return heroes.HEROES[hero].position
  else
    return nil
  end
end

local function GetRandomHero(position)
  local hero = functions.GetKeyWith(
    heroes.HEROES,
    nil,
    function(hero, details)
      return functions.IsElementInList(details.position, position)
             and not IsHeroPicked(hero)
             and functions.GetRandomTrue(0.5)
    end)

  return hero
end

local function GetComboHero(position, combo_heroes)
  local hero = functions.GetKeyWith(
    heroes.HEROES,
    nil,
    function(hero, details)
      return functions.IsElementInList(details.position, position)
             and not IsHeroPicked(hero)
             and IsIntersectionOfLists(details.combo_heroes, combo_heroes)
    end)

  if hero ~= nil then
    return hero
  else
    return GetRandomHero(position)
  end
end

-- TODO: Rewrite this function with the GetElementWith() function
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

local function IsPickRequired(heroes)
  return heroes == nil or #heroes < 5
end

local function GetRequiredPosition(heroes)
  local positions = {
    [1] = "empty",
    [2] = "empty",
    [3] = "empty",
    [4] = "empty",
    [5] = "empty"
  }

  for _, hero in pairs(heroes) do
    local hero_position = GetHeroPositions(hero)
    if positions[hero_position[1]] == "empty" then
      positions[hero_position[1]] = hero
    elseif positions[hero_position[2]] == "empty" then
      positions[hero_position[2]] = hero
    end
  end

  return functions.GetKeyWith(
    positions,
    nil,
    function(position, hero) return hero ~= "empty" end)
end

local function PickHero(position, combo_heroes)
  local hero = GetComboHero(position, combo_heroes)

  if hero ~= nil then
    local players = GetTeamPlayers(GetTeam())
    if combo_heroes == nil then
      SelectHero(players[1], hero)
    else
      SelectHero(players[#combo_heroes + 1], hero)
    end
  end
end

function Think()
  if not IsHumanPlayersPicked() then
    return
  end

  local team_heroes = GetPickedHeroesList(GetTeam())

  if not IsPickRequired(team_heroes) then return end

  PickHero(GetRequiredPosition(team_heroes), team_heroes)
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
M.test_IsIntersectionOfLists = IsIntersectionOfLists
M.test_GetPickedHeroesList = GetPickedHeroesList
M.test_IsHeroPickedByTeam = IsHeroPickedByTeam
M.test_IsHeroPicked = IsHeroPicked
M.test_GetHeroPositions = GetHeroPositions
M.test_GetRandomHero = GetRandomHero
M.test_GetComboHero = GetComboHero
M.test_IsHumanPlayersPicked = IsHumanPlayersPicked
M.test_IsPickRequired = IsPickRequired
M.test_GetRequiredPosition = GetRequiredPosition
M.test_PickHero = PickHero
M.test_GetBotNames = GetBotNames

return M
