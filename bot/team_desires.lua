local logger = require(
    GetScriptDirectory() .."/utility/logger")

function GetAliveAllyHeroNumber()
  local units = GetUnitList(UNIT_LIST_ALLIED_HEROES)
  local result = 0

  for _, unit in pairs(units) do
    if unit:IsAlive() and not unit:IsIllusion() then
      result = result + 1
    end
  end

  return result
end

function GetAliveEnemyHeroNumber()
  local result = 0

  for _, enemyId in pairs(GetTeamPlayers(GetOpposingTeam())) do
    if IsHeroAlive(enemyId) then
      result = result + 1
    end
  end

  return result
end

--[[
function UpdatePushLaneDesires()
  -- Do not push at the beginning of the match
  if DotaTime() <= 10 * 60 then return {0, 0, 0} end

  -- Do not push if enemy team has significant advantage (2 alive heroes)
  if 1 < (GetAliveEnemyHeroNumber() - GetAliveAllyHeroNumber()) then

    logger.Print("UpdatePushLaneDesires() - do not push " .. GetAliveAllyHeroNumber() .. " vs " .. GetAliveEnemyHeroNumber())

    return {0, 0, 0}
  end

  -- Push mid if > 2 enemy heroes died
  if GetAliveEnemyHeroNumber() < 4 then

    logger.Print("UpdatePushLaneDesires() - push " .. GetAliveAllyHeroNumber() .. " vs " .. GetAliveEnemyHeroNumber())

    return {0.2, 0.9, 0.2}
  end

  logger.Print("UpdatePushLaneDesires() - default decision " .. GetAliveAllyHeroNumber() .. " vs " .. GetAliveEnemyHeroNumber())

  -- Orefer to push mid in the general case
  return { 0.4, 0.7, 0.4 }
end
--]]

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
