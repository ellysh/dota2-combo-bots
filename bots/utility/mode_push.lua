local desires = require(
  GetScriptDirectory() .."/utility/desires")

local attack = require(
  GetScriptDirectory() .."/utility/attack")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local M = {}

function M.Think(lane)
  -- TODO: Use TP scrolls and TP boots here

  local bot = GetBot()
  local target = GetLaneFrontLocation(GetTeam(), lane, 0.5)

  if functions.IsEnemyNear(bot) then
     attack.Attack(bot, bot:GetCurrentVisionRange())
  else
    bot:Action_AttackMove(target)
  end
end

return M
