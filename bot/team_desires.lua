local team_desires = require(
    GetScriptDirectory() .."/utility/team_desires")

local functions = require(
    GetScriptDirectory() .."/utility/functions")

function TeamThink()
  team_desires.TeamThink()
end

function UpdatePushLaneDesires()
  return {
    functions.GetElementInList(team_desires.PUSH_LINES_DESIRE, 1),
    functions.GetElementInList(team_desires.PUSH_LINES_DESIRE, 2),
    functions.GetElementInList(team_desires.PUSH_LINES_DESIRE, 3)
  }
end

--[[
----------------------------------------------------------------------------------------------------

function UpdateDefendLaneDesires()

    return { 0.2, 0.2, 0.2 }

end

----------------------------------------------------------------------------------------------------

function UpdateFarmLaneDesires()

    return { 0.5, 0.5, 0.5 }

end

----------------------------------------------------------------------------------------------------

function UpdateRoamDesire()

    return { 0.5, GetTeamMember( 1 ) }

end


----------------------------------------------------------------------------------------------------

function UpdateRoshanDesire()

    return 0.1

end

----------------------------------------------------------------------------------------------------
--]]
