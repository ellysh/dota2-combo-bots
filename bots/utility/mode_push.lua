local desires = require(
  GetScriptDirectory() .."/utility/desires")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local attack = require(
  GetScriptDirectory() .."/utility/attack")

local move = require(
  GetScriptDirectory() .."/utility/move")

local M = {}

function M.Think(lane)
  -- TODO: Use TP scrolls and TP boots here

  local bot = GetBot()
  local target_location = GetLaneFrontLocation(GetTeam(), lane, 0.5)

  if functions.IsEnemyNear(bot) then
     attack.Attack(bot, bot:GetCurrentVisionRange())
  else
    move.Move(bot, target_location)
  end
end

return M
