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

local function GetTalentIndex(npc_bot, table_index)
  return
    skill_build.SKILL_BUILD[npc_bot:GetUnitName()].talents[table_index]
end

local function GetAbilityIndex(npc_bot, table_index)
  return
    skill_build.SKILL_BUILD[npc_bot:GetUnitName()].abilities[table_index]
end

local function GetTableIndex(npc_bot)
  local table_index = npc_bot:GetLevel() - npc_bot:GetAbilityPoints() + 1

  while GetTalentIndex(npc_bot, table_index) == nil
    and GetAbilityIndex(npc_bot, table_index) == nil
    and table_index < 100 do

    table_index = table_index + 1
  end

  return table_index
end

function M.AbilityLevelUpThink()
  local npc_bot = GetBot()

  if npc_bot:GetAbilityPoints() < 1 then return end

  local table_index = GetTableIndex(npc_bot)

  local talent_index = GetTalentIndex(npc_bot, table_index)

  if talent_index ~= nil
    and AbilityLevelUp(
      npc_bot,
      TALENTS[npc_bot:GetUnitName()][talent_index]) then

    return
  end

  local ability_index = GetAbilityIndex(npc_bot, table_index)

  if ability_index ~= nil then

    AbilityLevelUp(
      npc_bot,
      ABILITIES[npc_bot:GetUnitName()][ability_index])
  end
end

-- Provide an access to local functions and lists for unit tests only
M.test_AbilityLevelUp = AbilityLevelUp
M.test_GetTableIndex = GetTableIndex

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
