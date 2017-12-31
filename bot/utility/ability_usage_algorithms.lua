local logger = require(
  GetScriptDirectory() .."/utility/logger")

local M = {}

local function GetEnemyHeroMinHp(npc_bot, radius)
  -- TODO: Implement this function
  return nil
end

local function IsTargetable(npc)
  -- TODO: Implement this function
  return false
end

local function IsEnoughDamageToKill(npc, ability)
  -- TODO: Implement this function
  return false
end

local function GetTarget(target, ability)
  -- TODO: Implement this function
  return nil
end

function M.low_hp_enemy_hero_to_kill(npc_bot, ability)
  local enemy_hero = GetEnemyHeroMinHp(npc_bot, ability:GetCastRange())

  if enemy_hero == nil
    or not IsTargetable(enemy_hero)
    or not IsEnoughDamageToKill(enemy_hero, ability) then

    return BOT_ACTION_DESIRE_NONE, nil
  end

  return BOT_ACTION_DESIRE_HIGH, GetTarget(enemy_hero, ability)
end

-- Provide an access to local functions and lists for unit tests only
M.test_GetEnemyHeroMinHp = GetEnemyHeroMinHp
M.test_IsTargetable = IsTargetable
M.test_IsEnoughDamageToKill = IsEnoughDamageToKill
M.test_GetTarget = GetTarget

return M
