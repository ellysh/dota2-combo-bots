local constants = require(
  GetScriptDirectory() .."/utility/constants")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local attack = require(
  GetScriptDirectory() .."/utility/attack")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local M = {}

local function IsMinionsOwnerNear(bot, minion)
  return GetUnitToUnitDistance(bot, minion)
         <= constants.MAX_MINION_DISTANCE_FROM_HERO
end

function M.MinionThink(minion)
  local bot = GetBot()

  local radius = functions.ternary(
    minion:GetBaseMovementSpeed() == 0,
    minion:GetAttackRange(),
    constants.MAX_GET_UNITS_RADIUS)

  local target = attack.ChooseTarget(minion, radius)

  if target ~= nil then
    attack.Attack(minion, target)
  elseif not IsMinionsOwnerNear(bot, minion) then
    minion:Action_MoveToLocation(bot:GetExtrapolatedLocation(3.0))
  end
end

return M
