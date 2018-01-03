local logger = require(
  GetScriptDirectory() .."/utility/logger")

local skill_build = require(
  GetScriptDirectory() .."/database/skill_build")

local M = {}

local ABILITIES = {}

local TALENTS = {}

function M.InitAbilities()
  local npc_bot = GetBot()

  ABILITIES[npc_bot:GetUnitName()] = {}
  TALENTS[npc_bot:GetUnitName()] = {}

  for i = 0, 23, 1 do

    local ability = npc_bot:GetAbilityInSlot(i)

    if ability ~= nil and ability:GetName() ~= "generic_hidden" then
      if ability:IsTalent() then
        table.insert(TALENTS[npc_bot:GetUnitName()], ability)
      else
        table.insert(ABILITIES[npc_bot:GetUnitName()], ability)
      end
    end
  end
end

local function AbilityLevelUp(npc_bot, ability)
  if ability ~= nil and ability:CanAbilityBeUpgraded() then

    logger.Print("AbilityLevelUp() - " .. npc_bot:GetUnitName() ..
                 " level up " .. ability:GetName())

    npc_bot:ActionImmediate_LevelAbility(ability:GetName())
    return true
  end

  return false
end

function M.AbilityLevelUpThink()
  local npc_bot = GetBot()

  if npc_bot:GetAbilityPoints() < 1 then return end

  local level = npc_bot:GetLevel()

  local talent_index =
    skill_build.SKILL_BUILD[npc_bot:GetUnitName()].talents[level]

  if not AbilityLevelUp(npc_bot, TALENTS[talent_index]) then
    local ability_index =
      skill_build.SKILL_BUILD[npc_bot:GetUnitName()].abilities[level]

    AbilityLevelUp(npc_bot, ABILITIES[ability_index])
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

function M.test_GetTalents()
  return TALENTS
end

return M
