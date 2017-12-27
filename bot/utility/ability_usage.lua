local logger = require(
  GetScriptDirectory() .."/utility/logger")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local skill_usage = require(
  GetScriptDirectory() .."/database/skill_usage")

local M = {}

local function IsBotModeMatch(npc_bot, bot_mode)
  if bot_mode == "any_mode" or bot_mode == "team_fight" then
    return true
  end

  local active_mode = npc_bot:GetActiveMode()

  if bot_mode == BOT_MODE_ROAM then
    return active_mode == BOT_MODE_ROAM
           or active_mode == BOT_MODE_TEAM_ROAM
  end

  -- Actual bot modes are the constant digits but the
  -- shortcuted modes are strings.

  if bot_mode == "BOT_MODE_PUSH_TOWER" then
    return active_mode == BOT_MODE_PUSH_TOWER_TOP
           or active_mode == BOT_MODE_PUSH_TOWER_MID
           or active_mode == BOT_MODE_PUSH_TOWER_BOT
  end

  if bot_mode == "BOT_MODE_DEFEND_TOWER" then
    return active_mode == BOT_MODE_DEFEND_TOWER_TOP
           or active_mode == BOT_MODE_DEFEND_TOWER_MID
           or active_mode == BOT_MODE_DEFEND_TOWER_BOT
  end

  return active_mode == bot_mode
end

local function CalculateDesireAndTarget(npc_bot, algorithm, bot_mode)
  if algorithm == nil then return BOT_ACTION_DESIRE_NONE, nil end

  if not IsBotModeMatch(npc_bot, bot_mode) then
    return BOT_ACTION_DESIRE_NONE, nil
  end

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
      local desire, target =
        CalculateDesireAndTarget(npc_bot, algorithm, bot_mode)

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

local function UseAbility(npc_bot, ability, target)
  if ability == nil then return end

  local behavior = ability:GetBehavior()

  if functions.CheckFlag(behavior, ABILITY_BEHAVIOR_NO_TARGET) then
    npc_bot:Action_UseAbility(ability)
    return
  end

  if functions.CheckFlag(behavior, ABILITY_BEHAVIOR_POINT) then
    npc_bot:Action_UseAbilityOnLocation(ability, target)
    return
  end

  npc_bot:Action_UseAbilityOnEntity(ability, target)
end

function M.AbilityUsageThink()
  local npc_bot = GetBot()

  local ability, target = ChooseAbilityAndTarget(npc_bot)

  UseAbility(npc_bot, ability, target)
end

-- Provide an access to local functions and lists for unit tests only
M.test_IsBotModeMatch = IsBotModeMatch
M.test_CalculateDesireAndTarget = CalculateDesireAndTarget
M.test_ChooseAbilityAndTarget = ChooseAbilityAndTarget

return M
