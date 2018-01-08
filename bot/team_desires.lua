local desires = require(
  GetScriptDirectory() .."/utility/desires")

local TEAM_DESIRES = {
  PUSH_TOP_LINE_DESIRE = 0,
  PUSH_MID_LINE_DESIRE = 0,
  PUSH_BOT_LINE_DESIRE = 0
}

function TeamThink()
  TEAM_DESIRES = desires.Think()
end

function UpdatePushLaneDesires()
  return {
    TEAM_DESIRES.PUSH_TOP_LINE_DESIRE,
    TEAM_DESIRES.PUSH_MID_LINE_DESIRE,
    TEAM_DESIRES.PUSH_BOT_LINE_DESIRE}
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
