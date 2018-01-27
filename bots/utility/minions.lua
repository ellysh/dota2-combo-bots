local constants = require(
  GetScriptDirectory() .."/utility/constants")

local M = {}

function M.MinionThink(minion)
  local bot = GetBot()

  if constants.MAX_MINION_DISTANCE_FROM_HERO
     < GetUnitToUnitDistance(bot, minion) then

     minion:Action_MoveToLocation(bot:GetExtrapolatedLocation(3.0))
     return
   end

   local target = bot:GetTarget()

   if target ~= nil then
     minion:Action_AttackUnit(target, false)
   end
end

return M
