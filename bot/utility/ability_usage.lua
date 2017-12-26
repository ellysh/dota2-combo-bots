local logger = require(
  GetScriptDirectory() .."/utility/logger")

local ability_levelup = require(
  GetScriptDirectory() .."/utility/ability_levelup")

local M = {}

-- The skill_usage module should be included after a definition
-- of the checking algorithms
local skill_build = require(
  GetScriptDirectory() .."/database/skill_usage")

local function GetDesireAndTargetList()
  -- TODO: Return list: ability -> {desire, target}

  for _, ability in pairs(ability_levelup.ABILITIES) do
    if skill_build.SKILL_USAGE[ability:GetName()].any_mode() then
    end
  end
end

local function GetMostDesiredAbility(desire_list)
  -- TODO: Return the {ability, target} pair
end

function M.AbilityUsageThink()
  local desire_list = GetDesireAndTargetList()

  local ability, target = GetMostDesiredAbility(desire_list)

  UseAbility(ability, target)
end

return M
