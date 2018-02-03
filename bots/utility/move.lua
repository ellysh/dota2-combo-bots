local M = {}

local function GetTpScrollAbility(unit)
  return unit:GetAbilityByName("item_tpscroll")
end

local function CanUseTpScroll(unit, target_location)
  return GetTpScrollAbility(unit):IsFullyCastable()
         and constants.MIN_TELEPORT_RADIUS
             < GetUnitToLocationDistance(unit, target_location)
end

function M.Move(unit, target_location)
  if CanUseTpScroll(unit, target_location) then
    unit:Action_UseAbilityOnLocation(
      GetTpScrollAbility(unit),
      target_location)
  else
    unit:Action_MoveToLocation(target_location);
  end
end

return M
