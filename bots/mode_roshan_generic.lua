local constants = require(
  GetScriptDirectory() .."/utility/constants")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local player_desires = require(
  GetScriptDirectory() .."/utility/player_desires")

local move = require(
  GetScriptDirectory() .."/utility/move")

local attack = require(
  GetScriptDirectory() .."/utility/attack")

function GetDesire()
  return functions.GetNormalizedDesire(
           GetRoshanDesire()
           + player_desires.GetDesire("BOT_MODE_ROSHAN"),
         constants.MAX_ROSHAN_DESIRE)
end

function Think()
  local ROSHAN_PIT_RADIUS = 180
  local bot = GetBot()
  local target_location = Vector(-2190, 1650, ROSHAN_PIT_RADIUS)

  if ROSHAN_PIT_RADIUS
     < GetUnitToLocationDistance(bot, target_location) then

    move.Move(bot, target_location)
  else
    local target = attack.ChooseTarget(
      bot,
      constants.MAX_GET_UNITS_RADIUS)

    if target ~= nil then
      attack.Attack(bot, target)
    end
  end
end
