local functions = require(
  GetScriptDirectory() .."/utility/functions")

local algorithms = require(
  GetScriptDirectory() .."/utility/attack_algorithms")

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

function M.ChooseTarget(bot, radius)
  if not functions.IsEnemyNear(bot) then
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
  if functions.IsBotBusy(unit) then
    return end

  -- This SetTarget is required to start casting skills
  unit:SetTarget(target)

  unit:Action_AttackUnit(target, false)
end

-- Provide an access to local functions for unit tests only
M.test_GetDesire = GetDesire

return M
