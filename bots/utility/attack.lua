local functions = require(
  GetScriptDirectory() .."/utility/functions")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local algorithms = require(
  GetScriptDirectory() .."/utility/attack_algorithms")

local common_algorithms = require(
  GetScriptDirectory() .."/utility/common_algorithms")

local attack_target = require(
  GetScriptDirectory() .."/database/attack_target")

local M = {}

local function GetDesire(bot, mode_desires)
  for mode, desire in pairs(mode_desires) do
    if functions.IsBotModeMatch(bot, mode) then
      return desire end
  end
  return 0
end

local function IsEnemyNear(bot)
  local radius = constants.MAX_GET_UNITS_RADIUS

  return 0 < #common_algorithms.GetEnemyHeroes(bot, radius)
         or 0 < #common_algorithms.GetEnemyCreeps(bot, radius)
         or 0 < #common_algorithms.GetNeutralCreeps(bot, radius)
         or 0 < #common_algorithms.GetEnemyBuildings(bot, radius)
end

function M.ChooseTarget(bot, radius)
  if not IsEnemyNear(bot) then
    return nil end

  local targets = {}

  for algorithm, mode_desires in pairs(attack_target.ATTACK_TARGET) do
    if algorithms[algorithm] == nil then
      do goto continue end
    end

    local desire = GetDesire(bot, mode_desires)
    if desire <= 0 then
      do goto continue end
    end

    local is_succeed, target = algorithms[algorithm](bot, radius)

    if is_succeed then
      targets[desire] = target
    end
    ::continue::
  end

  return functions.GetElementWith(
    targets,
    function(t, a, b)
      return b < a
    end)
end

function M.Attack(unit, target)
  if functions.IsBotCasting(unit) then
    return end

  -- This SetTarget is required to start casting skills
  unit:SetTarget(target)

  unit:Action_AttackUnit(target, false)
end

-- Provide an access to local functions for unit tests only
M.test_IsEnemyNear = IsEnemyNear
M.test_GetDesire = GetDesire

return M
