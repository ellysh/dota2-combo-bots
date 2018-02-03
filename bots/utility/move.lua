local constants = require(
  GetScriptDirectory() .."/utility/constants")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local logger = require(
  GetScriptDirectory() .."/utility/logger")

local M = {}

local function GetTpScrollAbility(unit)
  return functions.GetItem(unit, "item_tpscroll")
end

local function CanUseTpScroll(unit, target_location)
  local tp_ability = GetTpScrollAbility(unit)

  return tp_ability ~= nil
         and tp_ability:IsFullyCastable()
         and constants.MIN_TELEPORT_RADIUS
             < GetUnitToLocationDistance(unit, target_location)
end

function M.Move(unit, target_location)
  if functions.IsBotBusy(unit) then
    return end

  if CanUseTpScroll(unit, target_location) then

    logger.Print("M.Move() - unit = " .. unit:GetUnitName() ..
      " use tp to " .. target_location[1] .. ", " .. target_location[2])

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
