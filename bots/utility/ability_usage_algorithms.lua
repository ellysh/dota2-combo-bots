local logger = require(
  GetScriptDirectory() .."/utility/logger")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local M = {}

local function SetDefaultRadius(radius)
  if radius == nil or radius == 0 then
    return constants.DEFAULT_ABILITY_USAGE_RADIUS
  end

  -- TODO: Trick with MAX_ABILITY_USAGE_RADIUS breaks Sniper's ult.
  -- But the GetNearbyHeroes function has the maximum radius 1600.

  return functions.ternary(
    constants.MAX_ABILITY_USAGE_RADIUS < radius,
    constants.MAX_ABILITY_USAGE_RADIUS,
    radius)
end

local function GetEnemyHeroes(bot, radius)
  radius = SetDefaultRadius(radius)
  return bot:GetNearbyHeroes(radius, true, BOT_MODE_NONE)
end

local function GetAllyHeroes(bot, radius)
  radius = SetDefaultRadius(radius)
  return bot:GetNearbyHeroes(radius, false, BOT_MODE_NONE)
end

local function GetEnemyCreeps(bot, radius)
  radius = SetDefaultRadius(radius)
  return bot:GetNearbyCreeps(radius, true)
end

local function GetAllyCreeps(bot, radius)
  radius = SetDefaultRadius(radius)
  return bot:GetNearbyCreeps(radius, false)
end

local function GetEnemyBuildings(bot, radius)
  radius = SetDefaultRadius(radius)
  local towers = bot:GetNearbyTowers(radius, true)

  if #towers ~= 0 then
    return towers end

  return bot:GetNearbyBarracks(radius, true)
end

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

local function CompareMaxHealth(t, a, b)
  return t[b]:GetHealth() < t[a]:GetHealth()
end

local function CompareMinHealth(t, a, b)
  return t[a]:GetHealth() < t[b]:GetHealth()
end

local function CompareMaxHeroKills(t, a, b)
  return GetHeroKills(t[b]:GetPlayerID()) <
    GetHeroKills(t[a]:GetPlayerID())
end

function M.min_hp_enemy_hero_to_kill(bot, ability)
  local enemy_heroes = GetEnemyHeroes(bot, ability:GetCastRange())
  local enemy_hero = functions.GetElementWith(
    enemy_heroes,
    CompareMinHealth,
    IsTargetable)

  if enemy_hero == nil
    or not IsTargetable(enemy_hero)
    or not IsEnoughDamageToKill(enemy_hero, ability) then

    return false, nil
  end

  return true, GetTarget(enemy_hero, ability)
end

function M.channeling_enemy_hero(bot, ability)
  local enemies = GetEnemyHeroes(bot, ability:GetCastRange())

  for _, enemy in pairs(enemies) do
    if enemy ~= nil
      and enemy:IsChanneling()
      and IsTargetable(enemy) then

      return true, GetTarget(enemy, ability)
    end
  end

  return false, nil
end

function M.max_kills_enemy_hero(bot, ability)
  local enemy_heroes = GetEnemyHeroes(bot, ability:GetCastRange())
  local enemy_hero = functions.GetElementWith(
    enemy_heroes,
    CompareMaxHeroKills,
    IsTargetable)

  if enemy_hero == nil
    or not IsTargetable(enemy_hero) then

    return false, nil
  end

  return true, GetTarget(enemy_hero, ability)
end

local function NumberOfTargetableUnits(units)
  return functions.GetNumberOfElementsWith(
    units,
    function(unit) return IsTargetable(unit) end)
end

function M.three_and_more_enemy_heroes_aoe(bot, ability)
  local enemies = GetEnemyHeroes(bot, ability:GetAOERadius())

  if 3 <= NumberOfTargetableUnits(enemies) then
    return true, nil end

  return false, nil
end

-- TODO: Generalize this function. We can pass a list of units
-- as an input parameter.
local function GetLastAttackedEnemyHero(bot, radius)
  local enemies = GetEnemyHeroes(bot, radius)

  if #enemies == 0 then
    return nil end

  for _, enemy in pairs(enemies) do
    if enemy == nil or not enemy:IsAlive() then
      goto continue end

    if bot:WasRecentlyDamagedByHero(enemy, 2.0) then
      return enemy
    end

    ::continue::
  end

  return nil
end

function M.last_attacked_enemy_hero(bot, ability)
  local enemy_hero = GetLastAttackedEnemyHero(
    bot,
    ability:GetCastRange())

  if enemy_hero == nil
    or not IsTargetable(enemy_hero) then

    return false, nil
  end

  return true, GetTarget(enemy_hero, ability)
end

function M.three_and_more_creeps(bot, ability)
  local cast_range = ability:GetCastRange()
  local enemies = GetEnemyCreeps(bot, cast_range)

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

function M.max_hp_creep(bot, ability)
  local creeps = GetEnemyCreeps(bot, ability:GetCastRange())
  local creep = functions.GetElementWith(
    creeps,
    CompareMaxHealth,
    IsTargetable)

  if creep == nil
    or not IsTargetable(creep) then

    return false, nil
  end

  return true, GetTarget(creep, ability)
end

function M.three_and_more_enemy_heroes(bot, ability)
  local cast_range = ability:GetCastRange()
  local enemies = GetEnemyHeroes(bot, cast_range)

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
  local target = bot:GetAttackTarget()

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

local function CompareMaxEstimatedDamage(t, a, b)
  local b_damage = t[b]:GetEstimatedDamageToTarget(
    true,
    GetBot(),
    3.0,
    DAMAGE_TYPE_ALL)

  local a_damage = t[a]:GetEstimatedDamageToTarget(
    true,
    GetBot(),
    3.0,
    DAMAGE_TYPE_ALL)

  return b_damage < a_damage
end

function M.max_estimated_damage_enemy_hero(bot, ability)
  local enemy_heroes = GetEnemyHeroes(bot, ability:GetCastRange())
  local enemy_hero = functions.GetElementWith(
    enemy_heroes,
    CompareMaxEstimatedDamage,
    IsTargetable)

  if enemy_hero == nil
    or not IsTargetable(enemy_hero) then

    return false, nil
  end

  return true, GetTarget(enemy_hero, ability)
end

local function UseOnAttackEnemyUnit(
  bot,
  ability,
  check_function,
  radius)

  local target = bot:GetAttackTarget()

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
  local enemies = GetEnemyCreeps(bot, ability:GetAOERadius())

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
  local ally_heroes = GetAllyHeroes(bot, ability:GetCastRange())
  local ally_hero = functions.GetElementWith(
    ally_heroes,
    CompareMinHealth,
    IsTargetable)

  if ally_hero == nil
    or not IsTargetable(ally_hero)
    or functions.GetUnitHealthLevel(ally_hero) > constants.UNIT_LOW_HEALTH_LEVEL then

    return false, nil
  end

  return true, GetTarget(ally_hero, ability)
end

function M.low_hp_ally_creep(bot, ability)
  local allies = GetAllyCreeps(bot, ability:GetCastRange())
  local ally_creep = functions.GetElementWith(
    allies,
    CompareMinHealth,
    IsTargetable)

  if ally_creep == nil
    or not IsTargetable(ally_creep)
    or functions.GetUnitHealthLevel(ally_creep) > constants.UNIT_LOW_HEALTH_LEVEL
    then

    return false, nil
  end

  return true, GetTarget(ally_creep, ability)
end

function M.three_and_more_ally_creeps_aoe(bot, ability)
  local allies = GetAllyCreeps(bot, ability:GetAOERadius())

  if 3 <= #allies then
    return true, nil end

  return false, nil
end

function M.min_hp_enemy_building(bot, ability)
  local enemy_buildings =
    GetEnemyBuildings(bot, ability:GetCastRange())

  local enemy_building = functions.GetElementWith(
    enemy_buildings,
    CompareMinHealth,
    IsTargetable)

  if enemy_building == nil
    or not IsTargetable(enemy_building) then

    return false, nil
  end

  return true, GetTarget(enemy_building, ability)
end

-- Provide an access to local functions and variables for unit tests only
M.test_SetDefaultRadius = SetDefaultRadius
M.test_GetEnemyHeroes = GetEnemyHeroes
M.test_GetAllyHeroes = GetAllyHeroes
M.test_GetEnemyCreeps = GetEnemyCreeps
M.test_GetAllyCreeps = GetAllyCreeps
M.test_GetEnemyBuildings = GetEnemyBuildings
M.test_IsTargetable = IsTargetable
M.test_IsEnoughDamageToKill = IsEnoughDamageToKill
M.test_GetTarget = GetTarget
M.test_UseOnAttackEnemyUnit = UseOnAttackEnemyUnit
M.test_GetUnitManaLevel = GetUnitManaLevel
M.test_GetLastAttackedEnemyHero = GetLastAttackedEnemyHero

return M
