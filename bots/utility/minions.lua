local constants = require(
  GetScriptDirectory() .."/utility/constants")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local attack = require(
  GetScriptDirectory() .."/utility/attack")

local M = {}

function M.MinionThink(minion)
  local bot = GetBot()

  if functions.IsEnemyNear(minion) then
    attack.Attack(minion)
  elseif constants.MAX_MINION_DISTANCE_FROM_HERO
         < GetUnitToUnitDistance(bot, minion) then

    minion:Action_MoveToLocation(bot:GetExtrapolatedLocation(3.0))
  end
end

return M
