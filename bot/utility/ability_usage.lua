local logger = require(
  GetScriptDirectory() .."/utility/logger")

local ability_levelup = require(
  GetScriptDirectory() .."/utility/ability_levelup")

local M = {}

-- TODO: Move all skill usage "algorithms" to the separate module
function low_hp_enemy_hero_to_kill()
  -- TODO: Implement this function
  return BOT_ACTION_DESIRE_HIGH, {0, 0}
end

-- The skill_usage module should be included after a definition
-- of the checking algorithms
local skill_usage = require(
  GetScriptDirectory() .."/database/skill_usage")

local function GetDesireAndTargetList(abilities)
  --  This function returns list: ability -> {desire, target}
  local result = {}

  for _, ability in pairs(abilities) do
    local skill_algorithms = skill_usage.SKILL_USAGE[ability:GetName()]

    if skill_algorithms == nil then goto continue end

    local any_mode = skill_algorithms.any_mode

    if any_mode ~= nil then
      local desire, target = any_mode()

      if desire ~= BOT_ACTION_DESIRE_NONE then
        result[ability] = {desire, target}
        goto continue
      end
    end

    -- TODO: Process the bot mode specific algorithms here

    ::continue::
  end

  return result
end

local function GetMostDesiredAbility(desire_list)
  -- TODO: Return the {ability, target} pair
end

function M.AbilityUsageThink(abilities)
  local desire_list = GetDesireAndTargetList(abilities)

  local ability, target = GetMostDesiredAbility(desire_list)

  UseAbility(ability, target)
end

-- Provide an access to local functions and lists for unit tests only
M.test_GetDesireAndTargetList = GetDesireAndTargetList

return M
