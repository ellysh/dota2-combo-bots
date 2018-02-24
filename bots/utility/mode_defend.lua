local attack = require(
  GetScriptDirectory() .."/utility/attack")

local move = require(
  GetScriptDirectory() .."/utility/move")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local M = {}

function M.Think(lane)
  local bot = GetBot()
  local target = attack.ChooseTarget(bot, constants.MAX_GET_UNITS_RADIUS)

  if target ~= nil then
    attack.Attack(bot, target)
  else
    local target_location = GetLaneFrontLocation(GetTeam(), lane, 0)

    move.Move(bot, target_location)
  end
end

return M
