local logger = require(
  GetScriptDirectory() .."/utility/logger")

local skill_build = require(
  GetScriptDirectory() .."/database/skill_build")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local M = {}

local ABILITIES = {}

local TALENTS = {}

function M.InitAbilities()
  local bot = GetBot()

  ABILITIES[bot:GetUnitName()] = {}
  TALENTS[bot:GetUnitName()] = {}

  for i = 0, 23, 1 do

    local ability = bot:GetAbilityInSlot(i)

    if ability ~= nil and ability:GetName() ~= "generic_hidden" then
      if ability:IsTalent() then
        table.insert(TALENTS[bot:GetUnitName()], ability:GetName())
      else
        table.insert(ABILITIES[bot:GetUnitName()], ability:GetName())
      end
    end
  end
end

local function AbilityLevelUp(bot, ability_name)
  local ability = bot:GetAbilityByName(ability_name)

  if ability_name ~= nil
    and not ability:IsNull()
    and ability:CanAbilityBeUpgraded() then

    logger.Print("AbilityLevelUp() - " .. bot:GetUnitName() ..
                 " level up " .. ability_name)

    bot:ActionImmediate_LevelAbility(ability_name)
    return true
  end

  return false
end

local TALENT_LEVELS = {10, 15, 20, 25}

function M.AbilityLevelUpThink()
  local bot = GetBot()

  if bot:GetAbilityPoints() < 1 then return end

  local abilities_build =
    skill_build.SKILL_BUILD[bot:GetUnitName()].abilities

  for level, ability_index in functions.spairs(abilities_build) do

    if functions.IsElementInList(TALENT_LEVELS, level) then
      if AbilityLevelUp(
        bot,
        TALENTS[bot:GetUnitName()][ability_index]) then

        abilities_build[level] = nil
        return
      end
    end

    if AbilityLevelUp(
      bot,
      ABILITIES[bot:GetUnitName()][ability_index]) then

      abilities_build[level] = nil
      return
    end
  end
end

-- Provide an access to local functions and lists for unit tests only
M.test_AbilityLevelUp = AbilityLevelUp

-- Provide an access to local variables for unit tests only

function M.test_GetAbilities()
  return ABILITIES
end

function M.test_SetAbilities(a)
  ABILITIES = a
end

function M.test_SetTalents(t)
  TALENTS = t
end

function M.test_GetTalents()
  return TALENTS
end

return M
