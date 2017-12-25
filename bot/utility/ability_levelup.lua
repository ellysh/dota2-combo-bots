local logger = require(
  GetScriptDirectory() .."/utility/logger")

local skill_build = require(
  GetScriptDirectory() .."/database/skill_build")

local M = {}

ABILITIES = {}

TALENTS = {}

local function InitAbilities()
  local npc_bot = GetBot()

  for i = 0, 23, 1 do

    local ability = npc_bot:GetAbilityInSlot(i)

    if ability ~= nil and ability:GetName() ~= "generic_hidden" then
      if ability:IsTalent() then
        table.insert(TALENTS, ability)
      else
        table.insert(ABILITIES, ability)
      end
    end
  end
end

local function AbilityLevelUp(npc_bot, ability)
  if ability ~= nil and ability:CanAbilityBeUpgraded() then
    npc_bot:ActionImmediate_LevelAbility(ability:GetName())
    return true
  end

  return false
end

function M.AbilityLevelUpThink()
  local npc_bot = GetBot()

  if npc_bot:GetAbilityPoints() < 1 then return end

  local level = npc_bot:GetLevel()

  if not AbilityLevelUp(npc_bot, TALENTS[level]) then
    AbilityLevelUp(npc_bot, ABILITIES[level])
  end
end

return M
