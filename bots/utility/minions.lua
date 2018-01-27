local constants = require(
  GetScriptDirectory() .."/utility/constants")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local attack = require(
  GetScriptDirectory() .."/utility/attack")

local M = {}

local function IsMinionsOwnerNear(bot, minion)
  return GetUnitToUnitDistance(bot, minion)
         <= constants.MAX_MINION_DISTANCE_FROM_HERO
end

function M.MinionThink(minion)
  local bot = GetBot()
  local target = bot:GetTarget()

  if IsMinionsOwnerNear(bot, minion) and target ~= nil then

    minion:Action_AttackUnit(target, false)

  elseif not IsMinionsOwnerNear(bot, minion)
        and functions.IsEnemyNear(minion) then

    attack.Attack(minion)

  elseif not IsMinionsOwnerNear(bot, minion) then

    minion:Action_MoveToLocation(bot:GetExtrapolatedLocation(3.0))

  end
end

return M
