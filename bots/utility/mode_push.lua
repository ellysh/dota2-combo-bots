local desires = require(
  GetScriptDirectory() .."/utility/desires")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local attack = require(
  GetScriptDirectory() .."/utility/attack")

local move = require(
  GetScriptDirectory() .."/utility/move")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local M = {}

function M.Think(lane)
  local bot = GetBot()
  local target_location = GetLaneFrontLocation(GetTeam(), lane, 0.5)

  if functions.IsEnemyNear(bot) then
     attack.Attack(bot, constants.MAX_GET_UNITS_RADIUS)
  else
    move.Move(bot, target_location)
  end
end

return M
