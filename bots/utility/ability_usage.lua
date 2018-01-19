local logger = require(
  GetScriptDirectory() .."/utility/logger")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local skill_usage = require(
  GetScriptDirectory() .."/database/skill_usage")

local M = {}

local function IsBotModeMatch(bot, bot_mode)
  if bot_mode == "any_mode" or bot_mode == "team_fight" then
    return true
  end

  local active_mode = bot:GetActiveMode()

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

  return active_mode == constants.BOT_MODES[bot_mode]
end

local function CalculateDesireAndTarget(
  bot,
  algorithm,
  bot_mode,
  ability)

  if algorithm == nil then return false, nil end

  if not IsBotModeMatch(bot, bot_mode) then
    return false, nil
  end

  return algorithm(bot, ability)
end

local function GetDesiredAbilitiesList(bot)
  local result = {}

  for ability_name, algorithms in pairs(skill_usage.SKILL_USAGE) do
    local ability = bot:GetAbilityByName(ability_name)

    if ability == nil
      or not ability:IsFullyCastable() then goto continue end

    for bot_mode, algorithm in functions.spairs(algorithms) do

      local is_succeed, target =
        CalculateDesireAndTarget(bot,
          algorithm[1],
          bot_mode,
          ability)

      local desire = functions.ternary(is_succeed, algorithm[2], 0.0)

      if desire ~= nil and desire ~= 0.0 then
         result[ability] = {target, desire}
      end
    end

    ::continue::
  end

  return result
end

local function ChooseAbilityAndTarget(bot)
  -- Thanks to the spairs() function we iterate the most desired skills
  -- first. Then, we use them with the desired probability.

  local desired_abilities = GetDesiredAbilitiesList(bot)

  for ability, target_desire
    in functions.spairs(
      desired_abilities,
      function(t, a, b) return t[b][2] < t[a][2] end) do

    if functions.GetRandomTrue(target_desire[2]) then

        return ability, target_desire[1]
    end
  end

  return nil, nil
end

local function UseAbility(bot, ability, target)
  if ability == nil then return end

  logger.Print("UseAbility() - " .. bot:GetUnitName() ..
    " use " .. ability:GetName())

  local target_type = functions.GetAbilityTargetType(ability)

  if target_type == constants.ABILITY_LOCATION_TARGET then
    bot:Action_UseAbilityOnLocation(ability, target)
    return
  end

  if target_type == constants.ABILITY_NO_TARGET then
    bot:Action_UseAbility(ability)
    return
  end

  bot:Action_UseAbilityOnEntity(ability, target)
end

function M.AbilityUsageThink()
  local bot = GetBot()

  if functions.IsBotBusy(bot) then return end

  local ability, target = ChooseAbilityAndTarget(bot)

  UseAbility(bot, ability, target)
end

-- Provide an access to local functions and lists for unit tests only
M.test_IsBotModeMatch = IsBotModeMatch
M.test_CalculateDesireAndTarget = CalculateDesireAndTarget
M.test_ChooseAbilityAndTarget = ChooseAbilityAndTarget
M.test_UseAbility = UseAbility

return M
