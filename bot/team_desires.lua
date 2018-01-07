local team_desires = require(
  GetScriptDirectory() .."/utility/team_desires")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

function TeamThink()
  team_desires.TeamThink()
end

function UpdatePushLaneDesires()
  return {
    team_desires.PUSH_LINES_DESIRE["PUSH_TOP_LINE_DESIRE"],
    team_desires.PUSH_LINES_DESIRE["PUSH_MID_LINE_DESIRE"],
    team_desires.PUSH_LINES_DESIRE["PUSH_BOT_LINE_DESIRE"]
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
