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

function M.AbilityLevelUpThink()
  -- TODO: Implement this function
end

return M
