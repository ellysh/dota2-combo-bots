local team_desires = require(
    GetScriptDirectory() .."/utility/team_desires")

function TeamThink()
  team_desires.TeamThink()
end

function UpdatePushLaneDesires()
  return {0, 0, 0}
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
