local logger = require(
  GetScriptDirectory() .."/utility/logger")

local skill_usage = require(
  GetScriptDirectory() .."/database/skill_usage")

local M = {}

local function CalculateDesireAndTarget(algorithm, bot_mode)
  if algorithm == nil then return BOT_ACTION_DESIRE_NONE, 0 end

  -- TODO: Check the real bot mode matching here

  return algorithm()
end

local function ChooseAbilityAndTarget(npc_bot)
  local result_ability = nil
  local result_target = nil

  local most_desired_target = BOT_ACTION_DESIRE_NONE

  for ability_name, algorithms in pairs(skill_usage.SKILL_USAGE) do
    local ability = npc_bot:GetAbilityByName(ability_name)

    if not ability:IsFullyCastable() then goto continue end

    for bot_mode, algorithm in pairs(algorithms) do
      local desire, target = CalculateDesireAndTarget(algorithm, bot_mode)

      if most_desired_target < desire then
        result_ability = ability
        result_target = target
        most_desired_target = desire
      end
    end

    ::continue::
  end

  return result_ability, result_target
end

function M.AbilityUsageThink()
  local npc_bot = GetBot()

  local ability, target = ChooseAbilityAndTarget(npc_bot)

  UseAbility(npc_bot, ability, target)
end

-- Provide an access to local functions and lists for unit tests only
M.test_ChooseAbilityAndTarget = ChooseAbilityAndTarget

return M
