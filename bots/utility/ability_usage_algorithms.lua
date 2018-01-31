local logger = require(
  GetScriptDirectory() .."/utility/logger")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local M = {}

local function IsTargetable(unit)
  return unit:CanBeSeen()
         and unit:IsAlive()
         and not unit:IsMagicImmune()
         and not unit:IsInvulnerable()
         and not unit:IsIllusion()
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

local function CompareMinHealth(t, a, b)
  return t[a]:GetHealth() < t[b]:GetHealth()
end

local function CompareMaxHeroKills(t, a, b)
  return GetHeroKills(t[b]:GetPlayerID()) <
    GetHeroKills(t[a]:GetPlayerID())
end

function M.min_hp_enemy_hero_to_kill(bot, ability)
  local enemy_heroes = functions.GetEnemyHeroes(
    bot,
    ability:GetCastRange())

  local enemy_hero = functions.GetElementWith(
    enemy_heroes,
    CompareMaxHeroKillCompareMaxHeroKills,
    function(hero)
      return IsTargetable(hero) and IsEnoughDamageToKill(hero, ability)
    end)

  if enemy_hero == nil then
    return false, nil end

  return true, GetTarget(enemy_hero, ability)
end

function M.channeling_enemy_hero(bot, ability)
  local enemies = functions.GetEnemyHeroes(bot, ability:GetCastRange())
  local enemy_hero = functions.GetElementWith(
    enemies,
    CompareMaxHeroKills,
    function(hero)
      return IsTargetable(hero) and hero:IsChanneling()
    end)

  if enemy_hero == nil then
    return false, nil end

  return true, GetTarget(enemy_hero, ability)
end

function M.attacked_enemy_hero(bot, ability)
  local target = bot:GetTarget()

  if target == nil
     or not target:IsHero()
     or ability:GetCastRange() < GetUnitToUnitDistance(bot, target)
     or not IsTargetable(target) then
    return false, nil end

  return true, GetTarget(target, ability)
end

function M.attacked_enemy_creep(bot, ability)
  local target = bot:GetTarget()

  if target == nil
     or not target:IsCreep()
     or ability:GetCastRange() < GetUnitToUnitDistance(bot, target)
     or not IsTargetable(target) then
    return false, nil end

  return true, GetTarget(target, ability)
end

function M.attacked_enemy_building(bot, ability)
  local target = bot:GetTarget()

  if target == nil
     or not target:IsBuilding()
     or ability:GetCastRange() < GetUnitToUnitDistance(bot, target)
     or not IsTargetable(target) then
    return false, nil end

  return true, GetTarget(target, ability)
end

local function NumberOfTargetableUnits(units)
  return functions.GetNumberOfElementsWith(
    units,
    function(unit) return IsTargetable(unit) end)
end

function M.three_and_more_enemy_heroes_aoe(bot, ability)
  local enemies = functions.GetEnemyHeroes(bot, ability:GetAOERadius())

  if 3 <= NumberOfTargetableUnits(enemies) then
    return true, nil end

  return false, nil
end

function M.last_attacked_enemy_hero(bot, ability)
  local enemy_heroes = functions.GetEnemyHeroes(
    bot,
    ability:GetCastRange())

  local enemy_hero = functions.GetElementWith(
    enemy_heroes,
    CompareMaxHeroKills,
    function(hero)
      return bot:WasRecentlyDamagedByHero(hero, 2.0)
             and IsTargetable(hero)
    end)

  if enemy_hero == nil then
    return false, nil end

  return true, GetTarget(enemy_hero, ability)
end

function M.three_and_more_creeps(bot, ability)
  local cast_range = ability:GetCastRange()
  local enemies = functions.GetEnemyCreeps(bot, cast_range)

  if NumberOfTargetableUnits(enemies) < 3 then
    return false, nil end

  local target = bot:FindAoELocation(
    true,
    false,
    bot:GetLocation(),
    cast_range,
    ability:GetSpecialValueInt("radius"),
    0,
    ability:GetAbilityDamage())

  if 3 <= target.count
    and GetUnitToLocationDistance(bot, target.targetloc) < cast_range then
    return true, target.targetloc
  end

  return false, nil
end

function M.three_and_more_enemy_heroes(bot, ability)
  local cast_range = ability:GetCastRange()
  local enemies = functions.GetEnemyHeroes(bot, cast_range)

  if NumberOfTargetableUnits(enemies) < 3 then
    return false, nil end

  local target = bot:FindAoELocation(
    true,
    true,
    bot:GetLocation(),
    cast_range,
    ability:GetSpecialValueInt("radius"),
    0,
    ability:GetAbilityDamage())

  if 3 <= target.count
    and GetUnitToLocationDistance(bot, target.targetloc) < cast_range then
    return true, target.targetloc
  end

  return false, nil
end

function M.toggle_on_attack_enemy_hero(bot, ability)
  local target = bot:GetTarget()

  if target == nil then
    return false, nil end

  if not ability:GetAutoCastState() and target:IsHero() then
    -- Enable the ability when we are attacking an enemy hero

    logger.Print("toggle_on_attack_enemy_hero() - " ..
      bot:GetUnitName() .. " activates " .. ability:GetName())

    ability:ToggleAutoCast()
  elseif ability:GetAutoCastState() and not target:IsHero() then
    -- Disable the ability when we are attacking a creep

    logger.Print("toggle_on_attack_enemy_hero() - " ..
      bot:GetUnitName() .. " deactivates " .. ability:GetName())

    ability:ToggleAutoCast()
  end

  return false, nil
end

local function UseOnAttackEnemyUnit(
  bot,
  ability,
  check_function,
  radius)

  local target = bot:GetTarget()

  if target == nil
    or not check_function(target)
    or radius < GetUnitToUnitDistance(bot, target) then

    return false, nil
  end

  return true, GetTarget(target, ability)
end

function M.use_on_attack_enemy_hero_aoe(bot, ability)
  return UseOnAttackEnemyUnit(
    bot,
    ability,
    function(unit) return unit:IsHero() end,
    ability:GetAOERadius())
end

function M.use_on_attack_enemy_hero_melee(bot, ability)
  return UseOnAttackEnemyUnit(
    bot,
    ability,
    function(unit) return unit:IsHero() end,
    constants.MELEE_ATTACK_RADIUS)
end

function M.use_on_attack_enemy_hero_ranged(bot, ability)
  return UseOnAttackEnemyUnit(
    bot,
    ability,
    function(unit) return unit:IsHero() end,
    ability:GetCastRange())
end

function M.use_on_attack_enemy_creep_aoe(bot, ability)
  return UseOnAttackEnemyUnit(
    bot,
    ability,
    function(unit) return unit:IsCreep() end,
    ability:GetAOERadius())
end

function M.use_on_attack_enemy_creep_melee(bot, ability)
  return UseOnAttackEnemyUnit(
    bot,
    ability,
    function(unit) return unit:IsCreep() end,
    constants.MELEE_ATTACK_RADIUS)
end

local function GetUnitManaLevel(unit)
  return unit:GetMana() / unit:GetMaxMana()
end

function M.use_on_attack_enemy_with_mana_when_low_mp(bot, ability)
  if GetUnitManaLevel(bot) > constants.UNIT_LOW_MANA_LEVEL then
    return false, nil
  end

  return UseOnAttackEnemyUnit(
    bot,
    ability,
    function(unit) return 0 < unit:GetMana() end,
    ability:GetCastRange())
end

function M.three_and_more_enemy_creeps_aoe(bot, ability)
  local enemies = functions.GetEnemyCreeps(bot, ability:GetAOERadius())

  if 3 <= NumberOfTargetableUnits(enemies) then
    return true, nil end

  return false, nil
end

function M.low_hp_self(bot, ability)
  if functions.GetUnitHealthLevel(bot)
     < constants.UNIT_LOW_HEALTH_LEVEL then

    return true, GetTarget(bot, ability)
  end

  return false, nil
end

function M.low_hp_ally_hero(bot, ability)
  local ally_heroes = functions.GetAllyHeroes(bot, ability:GetCastRange())
  local ally_hero = functions.GetElementWith(
    ally_heroes,
    CompareMinHealth,
    function(unit)
      return IsTargetable(unit)
             and functions.GetUnitHealthLevel(unit)
                 <= constants.UNIT_LOW_HEALTH_LEVEL
    end)

  if ally_hero == nil then
    return false, nil end

  return true, GetTarget(ally_hero, ability)
end

function M.low_hp_ally_creep(bot, ability)
  local allies = functions.GetAllyCreeps(bot, ability:GetCastRange())
  local ally_creep = functions.GetElementWith(
    allies,
    CompareMinHealth,
    function(unit)
      return IsTargetable(unit)
             and functions.GetUnitHealthLevel(unit)
                 <= constants.UNIT_LOW_HEALTH_LEVEL
    end)

  if ally_creep == nil then
    return false, nil end

  return true, GetTarget(ally_creep, ability)
end

function M.three_and_more_ally_creeps_aoe(bot, ability)
  local allies = functions.GetAllyCreeps(bot, ability:GetAOERadius())

  if 3 <= #allies then
    return true, nil end

  return false, nil
end

function M.move_target(bot, ability)
  local target = GetExtrapolatedLocation(40)

  if constants.MIN_TELEPORT_RADIUS
     < GetUnitToLocationDistance(bot, target) then
    return true, target end

  return false, nil
end

-- Provide an access to local functions and variables for unit tests only
M.test_IsTargetable = IsTargetable
M.test_IsEnoughDamageToKill = IsEnoughDamageToKill
M.test_GetTarget = GetTarget
M.test_UseOnAttackEnemyUnit = UseOnAttackEnemyUnit
M.test_GetUnitManaLevel = GetUnitManaLevel

return M
