local desires = require(
  GetScriptDirectory() .."/utility/desires")

local team_desires = require(
  GetScriptDirectory() .."/database/team_desires")

local team_desires_algorithms = require(
  GetScriptDirectory() .."/utility/team_desires_algorithms")

local TEAM_DESIRES = {
  BOT_MODE_PUSH_TOWER_TOP = 0,
  BOT_MODE_PUSH_TOWER_MID = 0,
  BOT_MODE_PUSH_TOWER_BOT = 0,
  BOT_MODE_TEAM_ROAM = 0
}

function TeamThink()
  TEAM_DESIRES = desires.Think(
    team_desires.TEAM_DESIRES,
    team_desires_algorithms)
end

function UpdatePushLaneDesires()
  return {
    TEAM_DESIRES.BOT_MODE_PUSH_TOWER_TOP,
    TEAM_DESIRES.BOT_MODE_PUSH_TOWER_MID,
    TEAM_DESIRES.BOT_MODE_PUSH_TOWER_BOT}
end

function UpdateRoamDesire()
  return { TEAM_DESIRES.BOT_MODE_TEAM_ROAM, GetTeamMember(1) }
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

function UpdateRoshanDesire()

    return 0.1

end

----------------------------------------------------------------------------------------------------
--]]
