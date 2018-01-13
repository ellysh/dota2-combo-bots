local logger = require(
  GetScriptDirectory() .."/utility/logger")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local M = {}

function M.have_low_hp()
  if functions.GetUnitHealthLevel(GetBot())
     < constants.UNIT_LOW_HEALTH_LEVEL then

    return true
  end

  return false
end

return M
