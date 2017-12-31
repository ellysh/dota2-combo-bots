local logger = require(
  GetScriptDirectory() .."/utility/logger")

local M = {}

local function GetEnemyHeroMinHp(npc_bot, radius)
  local enemies = npc_bot:GetNearbyHeroes(radius, true, BOT_MODE_NONE)

  if #enemies == 0 then return nil end

  local min_hp = 10000
  local result = nil

  for _, enemy in pairs(enemies) do
    if enemy == nil or not enemy:IsAlive() then goto continue end

    if enemy:GetHealth() < min_hp then
      min_hp = enemy:GetHealth()
      result = enemy
    end

    ::continue::
  end

  return result
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
