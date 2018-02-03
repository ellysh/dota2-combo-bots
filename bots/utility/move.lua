local constants = require(
  GetScriptDirectory() .."/utility/constants")

local M = {}

local function GetTpScrollAbility(unit)
  return unit:GetAbilityByName("item_tpscroll")
end

local function CanUseTpScroll(unit, target_location)
  local tp_ability = GetTpScrollAbility(unit)
  return tp_ability ~= nil
         and tp_ability:IsFullyCastable()
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

-- Provide an access to local functions for unit tests only
M.test_GetTpScrollAbility = GetTpScrollAbility
M.test_CanUseTpScroll = CanUseTpScroll

return M
