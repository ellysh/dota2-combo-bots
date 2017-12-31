local logger = require(
  GetScriptDirectory() .."/utility/logger")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

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
  return npc:CanBeSeen()
         and not npc:IsMagicImmune()
         and not npc:IsInvulnerable()
         and not npc:IsIllusion()
end

local function IsEnoughDamageToKill(npc, ability)
  return npc:GetHealth() <= npc:GetActualIncomingDamage(
    ability:GetAbilityDamage(),
    ability:GetDamageType())
end

local function GetTarget(target, ability)
  local target_type = functions.GetAbilityTargetType(ability)

  if target_type == constants.ABILITY_LOCATION_TARGET then
    -- TODO: We use constant cast time 0.3 for all abilities
    return target:GetExtrapolatedLocation(0.3)
  end

  if target_type == constants.ABILITY_UNIT_TARGET then
    return target
  end

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
