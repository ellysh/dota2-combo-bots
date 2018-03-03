local heroes = require(
  GetScriptDirectory() .."/database/heroes")

local logger = require(
  GetScriptDirectory() .."/utility/logger")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local M = {}

local function GetPickedHeroesList(team)
  local players = GetTeamPlayers(team)
  local result = {}

  for _, player in pairs(players) do
    local hero = GetSelectedHeroName(player)
    if hero ~= "" then
      table.insert(result, hero)
    end
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

local TEAM_COMPOSITION = {
  [TEAM_RADIANT] = {
    positions = {},
    damage_type = {
      physical = 0,
      magical = 0
    },
    attack_range = {
      melee = 0,
      ranged = 0
    },
    attribute = {
      strength = 0,
      agility = 0,
      intelligence = 0,
    },
    available_skills = {},
    available_auras = {},
    required_skills = {},
    required_auras = {},
    is_human_applied = false
  },
  [TEAM_DIRE] = {
    positions = {},
    damage_type = {
      physical = 0,
      magical = 0
    },
    attack_range = {
      melee = 0,
      ranged = 0
    },
    attribute = {
      strength = 0,
      agility = 0,
      intelligence = 0,
    },
    available_skills = {},
    available_auras = {},
    required_skills = {},
    required_auras = {},
    is_human_applied = false
  }
}

local function FillTeamComposition(position, hero)
  local team = GetTeam()
  local hero_details = heroes.HEROES[hero]

  table.insert(TEAM_COMPOSITION[team].positions, position)

  TEAM_COMPOSITION[team].damage_type[hero_details.damage_type] =
    TEAM_COMPOSITION[team].damage_type[hero_details.damage_type] + 1

  TEAM_COMPOSITION[team].attack_range[hero_details.attack_range] =
    TEAM_COMPOSITION[team].attack_range[hero_details.attack_range] + 1

  TEAM_COMPOSITION[team].attribute[hero_details.attribute] =
    TEAM_COMPOSITION[team].attribute[hero_details.attribute] + 1

  functions.TableConcat(
    TEAM_COMPOSITION[team].available_skills,
    hero_details.available_skills)

  functions.TableConcat(
    TEAM_COMPOSITION[team].available_auras,
    hero_details.available_auras)

  functions.TableConcat(
    TEAM_COMPOSITION[team].required_skills,
    hero_details.required_skills)

  functions.TableConcat(
    TEAM_COMPOSITION[team].required_auras,
    hero_details.required_auras)
end

local function GetRandomHero(position)
  local start_index = RandomInt(1, functions.GetTableSize(heroes.HEROES))
  local index = 1

  local hero = functions.GetKeyWith(
    heroes.HEROES,
    nil,
    function(hero, details)
      index = index + 1
      return start_index <= index
             and functions.IsElementInList(details.positions, position)
             and not IsHeroPicked(hero)
    end)

  return hero
end

local function HasRequiredAuras(details)
  return functions.IsIntersectionOfLists(
    details.available_auras,
    TEAM_COMPOSITION[GetTeam()].required_auras)
end

local function HasRequiredSkills(details)
  return functions.IsIntersectionOfLists(
    details.available_skills,
    TEAM_COMPOSITION[GetTeam()].required_skills)
end

local function HasRequiredDamageType(details)
  local team = GetTeam()

  if TEAM_COMPOSITION[team].damage_type["physical"] <
    TEAM_COMPOSITION[team].damage_type["magical"] then

    return details.damage_type == "physical"
  else
    return details.damage_type == "magical"
  end
end

local function HasRequiredAttackRange(details)
  local team = GetTeam()

  if TEAM_COMPOSITION[team].attack_range["melee"] <
    TEAM_COMPOSITION[team].attack_range["ranged"] then

    return details.attack_range == "melee"
  else
    return details.attack_range == "ranged"
  end
end

local function HasRequiredAttribute(details)
  local team = GetTeam()

  return (TEAM_COMPOSITION[team].attribute["strength"] == 0
          and details.attribute == "strength")
         or (TEAM_COMPOSITION[team].attribute["agility"] == 0
             and details.attribute == "agility")
         or (TEAM_COMPOSITION[team].attribute["intelligence"] == 0
             and details.attribute == "intelligence")
end

local function EstimateHero(details)
  local result = 0

  if HasRequiredAuras(details) then
    result = result + 35
  end

  if HasRequiredSkills(details) then
    result = result + 25
  end

  if HasRequiredDamageType(details) then
    result = result + 15
  end

  if HasRequiredAttackRange(details) then
    result = result + 15
  end

  if HasRequiredAttribute(details) then
    result = result + 10
  end

  return result
end

local function GetComboHero(position)
  local hero_estimates = {}

  functions.DoWithKeysAndElements(
    heroes.HEROES,
    function(hero, details)
      if functions.IsElementInList(details.positions, position)
         and not IsHeroPicked(hero) then

        hero_estimates[hero] = EstimateHero(details)
      end
    end)

  return functions.GetKeyWith(
    hero_estimates,
    function(t, a, b) return t[b] < t[a] end,
    nil)
end

local function ApplyHumanPlayersHeroes()
  local team = GetTeam()

  if TEAM_COMPOSITION[team].is_human_applied then
    return end

  local players = GetTeamPlayers(GetTeam())
  functions.DoWithKeysAndElements(
    players,
    function(_, player)
      if IsPlayerBot(player) then
        return end

      local hero = GetSelectedHeroName(player)
      local hero_details = heroes.HEROES[hero]

      if hero_details == nil then
        return end

      FillTeamComposition(hero_details.positions[1], hero)
    end)

  TEAM_COMPOSITION[team].is_human_applied = true
end

local function IsHumanPlayersPicked()
  local players = GetTeamPlayers(GetTeam())
  local no_pick_player = functions.GetElementWith(
    players,
    nil,
    function(player)
      return not IsPlayerBot(player)
             and GetSelectedHeroName(player) == ""
    end)

    return no_pick_player == nil
end

local function IsPickRequired()
  local team = GetTeam()

  return TEAM_COMPOSITION[team].positions == nil
         or #TEAM_COMPOSITION[team].positions < 5
end

local function GetRequiredPosition()
  local team = GetTeam()

  for i = 1, 5 do
    if not functions.IsElementInList(
      TEAM_COMPOSITION[team].positions,
      i) then

      return i
    end
  end

  return nil
end

local function PickHero()
  local position = GetRequiredPosition()
  local hero = nil

  if position == 1 then
    hero = GetRandomHero(position)
  else
    hero = GetComboHero(position)
  end

  if hero == nil then
    hero = GetRandomHero(position)

    if hero == nil then
      return end
  end

  logger.Print("PickHero() - position = " .. position ..
    " hero = " .. tostring(hero))

  FillTeamComposition(position, hero)

  local team = GetTeam()
  local players = GetTeamPlayers(team)

  if TEAM_COMPOSITION[team].positions == nil then
    SelectHero(players[1], hero)
  else
    SelectHero(players[#TEAM_COMPOSITION[team].positions], hero)
  end
end

function Think()
  if not IsHumanPlayersPicked() then return end

  ApplyHumanPlayersHeroes()

  if not IsPickRequired() then return end

  PickHero()
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
M.test_GetPickedHeroesList = GetPickedHeroesList
M.test_IsHeroPickedByTeam = IsHeroPickedByTeam
M.test_IsHeroPicked = IsHeroPicked
M.test_FillTeamComposition = FillTeamComposition
M.test_GetRandomHero = GetRandomHero
M.test_GetComboHero = GetComboHero
M.test_IsHumanPlayersPicked = IsHumanPlayersPicked
M.test_ApplyHumanPlayersHeroes = ApplyHumanPlayersHeroes
M.test_IsPickRequired = IsPickRequired
M.test_GetRequiredPosition = GetRequiredPosition
M.test_PickHero = PickHero
M.test_GetBotNames = GetBotNames

function M.test_ResetTeamComposition(team)
  TEAM_COMPOSITION[team].positions = {}
  TEAM_COMPOSITION[team].damage_type = {physical = 0, magical = 0}
  TEAM_COMPOSITION[team].attack_range = {melee = 0, ranged = 0}
  TEAM_COMPOSITION[team].attribute = {
    strength = 0,
    agility = 0,
    intelligence = 0}
  TEAM_COMPOSITION[team].available_skills = {}
  TEAM_COMPOSITION[team].available_auras = {}
  TEAM_COMPOSITION[team].required_skills = {}
  TEAM_COMPOSITION[team].required_auras = {}
  TEAM_COMPOSITION[team].is_human_applied = false
end

function M.test_GetTeamComposition(team)
  return TEAM_COMPOSITION[team]
end

return M
