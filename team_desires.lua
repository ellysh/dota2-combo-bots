function GetAliveUnitNumber(unitType)
  local units = GetUnitList(unitType);
  local result = 0;

  for _, unit in pairs(units) do
    if unit:IsAlive() and not unit:IsIllusion() then
      result = result + 1;
    end
  end

  return result
end

function GetAliveAllyHeroNumber()
  return GetAliveUnitNumber(UNIT_LIST_ALLIED_HEROES);
end

function GetAliveEnemyHeroNumber()
  return GetAliveUnitNumber(UNIT_LIST_ENEMY_HEROES);
end

function UpdatePushLaneDesires()
  -- Do not push at the beginning of the match
  if DotaTime() <= 7 * 60 then return {0, 0, 0} end

  -- Do not push if enemy team has significant advantage (2 alive heroes)
  if 1 < (GetAliveEnemyHeroNumber() - GetAliveAllyHeroNumber()) then
    return {0, 0, 0}
  end

  -- Push mid if > 2 enemy heroes died
  if GetAliveEnemyHeroNumber() < 4 then return {0.2, 0.8, 0.2} end

  -- Orefer to push mid in the general case
  return { 0.4, 0.7, 0.4 };
end

--[[
----------------------------------------------------------------------------------------------------

function UpdateDefendLaneDesires()

    return { 0.2, 0.2, 0.2 };

end

----------------------------------------------------------------------------------------------------

function UpdateFarmLaneDesires()

    return { 0.5, 0.5, 0.5 };

end

----------------------------------------------------------------------------------------------------

function UpdateRoamDesire()

    return { 0.5, GetTeamMember( 1 ) };

end


----------------------------------------------------------------------------------------------------

function UpdateRoshanDesire()

    return 0.1;

end

----------------------------------------------------------------------------------------------------
--]
