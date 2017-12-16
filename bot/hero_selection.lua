local heroes = require(
    GetScriptDirectory() .."/database/heroes")

function GetBotNames ()
    return  {"Alfa", "Bravo", "Charlie", "Delta", "Echo"}
end

function ElementInList(element, list)
  for _,e in pairs(list) do
    if e == element then
      return true
    end
  end
  return false
end

function GetRandomHero(position)
  -- TODO: Now we find first hero with the specified position.
  -- It should be random instead.
  for _, hero in pairs(heroes.HEROES) do
    if ElementInList(position, hero.position) then
      return hero.name
  end
  return nil
end

-- TODO: Now the draft algorithm works only for all pick mode for a team of bots
function Think()
  local players = GetTeamPlayers(GetTeam())

  SelectHero(players[1], GetRandomHero(5))
end

function UpdateLaneAssignments()
  if ( GetTeam() == TEAM_RADIANT ) then
    return {
      [1] = LANE_TOP,
      [2] = LANE_TOP,
      [3] = LANE_MID,
      [4] = LANE_BOT,
      [5] = LANE_BOT,
    }
  elseif ( GetTeam() == TEAM_DIRE ) then
    return {
      [1] = LANE_BOT,
      [2] = LANE_BOT,
      [3] = LANE_MID,
      [4] = LANE_TOP,
      [5] = LANE_TOP,
    }
  end
end
