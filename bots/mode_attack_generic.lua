local attack = require(
  GetScriptDirectory() .."/utility/attack")

local move = require(
  GetScriptDirectory() .."/utility/move")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local player_desires = require(
  GetScriptDirectory() .."/utility/player_desires")

function GetDesire()
  return functions.GetNormalizedDesire(
    player_desires.GetDesire("BOT_MODE_ATTACK"),
    constants.MAX_ATTACK_DESIRE)
end

function Think()
  local bot = GetBot()
  local target = attack.ChooseTarget(bot, constants.MAX_GET_UNITS_RADIUS)

  if target ~= nil then
    attack.Attack(bot, target)
  else
    move.Move(bot, GetShopLocation(GetTeam(), SHOP_HOME))
  end
end
