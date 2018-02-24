local logger = require(
  GetScriptDirectory() .."/utility/logger")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local common_algorithms = require(
  GetScriptDirectory() .."/utility/common_algorithms")

local skill_usage = require(
  GetScriptDirectory() .."/database/skill_usage")

local M = {}

local function CalculateDesireAndTarget(
  bot,
  algorithm,
  bot_mode,
  ability)

  if algorithm == nil then
    return false, nil end

  if not functions.IsBotModeMatch(bot, bot_mode) then
    return false, nil
  end

  return algorithm(bot, ability)
end

local function GetAbility(bot, ability_name)
  local ability = bot:GetAbilityByName(ability_name)

  if ability == nil then
    ability = functions.GetItem(bot, ability_name, ITEM_SLOT_TYPE_MAIN)
  end

  return ability
end

local function GetDesiredAbilitiesList(bot)
  local result = {}

  for ability_name, algorithms in pairs(skill_usage.SKILL_USAGE) do
    local ability = GetAbility(bot, ability_name)

    if ability == nil
      or not ability:IsFullyCastable() then
      -- We need "do end" around otherwse a code coverage does not work
      do goto continue end
    end

    for bot_mode, algorithm in functions.spairs(algorithms) do

      local is_succeed, target =
        CalculateDesireAndTarget(bot,
          algorithm[1],
          bot_mode,
          ability)

      local desire = functions.ternary(is_succeed, algorithm[2], 0)

      if desire ~= nil and desire ~= 0 then
         result[ability] = {target, desire}
      end
    end

    ::continue::
  end

  return result
end

local function ChooseAbilityAndTarget(bot)
  local desired_abilities = GetDesiredAbilitiesList(bot)

  local ability, target_desire = functions.GetKeyAndElementWith(
    desired_abilities,
    function(t, a, b) return t[b][2] < t[a][2] end)

  if ability == nil then
    return nil, nil end

  return ability, target_desire[1]
end

local function UseAbility(bot, ability, target)
  if ability == nil then
    return end

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

local function CancelAbility(bot)
  local ability = bot:GetCurrentActiveAbility()

  if not bot:IsChanneling()
     or ability == nil
     or ability:GetName() == "item_tpscroll" then
    return end

  local radius = functions.ternary(
    ability:GetCastRange() ~= 0,
    ability:GetCastRange(),
    ability:GetAOERadius())

  if #common_algorithms.GetEnemyHeroes(bot, radius) == 0 then

    logger.Print("CancelAbility() - " .. bot:GetUnitName() ..
      " cancel " .. ability:GetName())

    bot:Action_ClearActions(true)
  end
end

function M.AbilityUsageThink()
  local bot = GetBot()

  CancelAbility(bot)

  if functions.IsBotCasting(bot) then
    return end

  local ability, target = ChooseAbilityAndTarget(bot)

  UseAbility(bot, ability, target)
end

-- Provide an access to local functions and lists for unit tests only
M.test_CalculateDesireAndTarget = CalculateDesireAndTarget
M.test_GetDesiredAbilitiesList = GetDesiredAbilitiesList
M.test_ChooseAbilityAndTarget = ChooseAbilityAndTarget
M.test_UseAbility = UseAbility
M.test_CancelAbility = CancelAbility

return M
