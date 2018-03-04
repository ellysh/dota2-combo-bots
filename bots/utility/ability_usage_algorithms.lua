local logger = require(
  GetScriptDirectory() .."/utility/logger")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local common_algorithms = require(
  GetScriptDirectory() .."/utility/common_algorithms")

local M = {}

local function IsTargetable(unit)
  return unit:IsAlive()
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
  if target == nil then
    return nil end

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

local function CheckEnemyHero(bot, ability, check_function)
  local enemy_heroes = common_algorithms.GetEnemyHeroes(
    bot,
    common_algorithms.GetAbilityRadius(ability))

  local enemy_hero = functions.GetElementWith(
    enemy_heroes,
    common_algorithms.CompareMaxHeroKills,
    check_function)

  return enemy_hero ~= nil, GetTarget(enemy_hero, ability)
end

function M.min_hp_enemy_hero_to_kill(bot, ability)
  return CheckEnemyHero(
    bot,
    ability,
    function(unit)
      return IsTargetable(unit) and IsEnoughDamageToKill(unit, ability)
    end)
end

function M.channeling_enemy_hero(bot, ability)
  return CheckEnemyHero(
    bot,
    ability,
    function(unit)
      return IsTargetable(unit) and unit:IsChanneling()
    end)
end

local function IsUnitRetreat(bot, unit)
  -- If unit turned away from the bot, he is retreating

  return not unit:IsFacingLocation(bot:GetLocation(), 30)
end

function M.retreat_enemy_hero(bot, ability)
  return CheckEnemyHero(
    bot,
    ability,
    function(unit)
      return IsTargetable(unit) and IsUnitRetreat(bot, unit)
    end)
end

local function AttackedEnemyUnit(bot, ability, check_function)
  local target = bot:GetTarget()

  local is_succeed =
    (target ~= nil
     and check_function(target)
     and GetUnitToUnitDistance(bot, target)
         <= common_algorithms.GetAbilityRadius(ability)
     and IsTargetable(target))

  return is_succeed, GetTarget(target, ability)
end

function M.attacked_enemy_hero(bot, ability)
  return AttackedEnemyUnit(bot, ability, bot.IsHero)
end

local function IsDisabled(unit)
  return unit:IsStunned()
         or unit:IsHexed()
         or unit:IsRooted()
         or unit:IsSilenced()
         or unit:IsNightmared()
         or unit:IsDisarmed()
         or unit:IsBlind()
         or unit:IsMuted()
end

function M.attacked_not_disabled_enemy_hero(bot, ability)
  local target = bot:GetTarget()

  if target == nil or IsDisabled(target) then
    return false, nil end

  return AttackedEnemyUnit(bot, ability, bot.IsHero)
end

function M.attacked_enemy_creep(bot, ability)
  return AttackedEnemyUnit(bot, ability, bot.IsCreep)
end

function M.attacked_enemy_building(bot, ability)
  return AttackedEnemyUnit(bot, ability, bot.IsBuilding)
end

local function NumberOfTargetableUnits(units)
  return functions.GetNumberOfElementsWith(
    units,
    function(unit) return IsTargetable(unit) end)
end

function M.last_attacked_enemy_hero(bot, ability)
  local enemy_heroes = common_algorithms.GetEnemyHeroes(
    bot,
    common_algorithms.GetAbilityRadius(ability))

  local enemy_hero = functions.GetElementWith(
    enemy_heroes,
    common_algorithms.CompareMaxHeroKills,
    function(hero)
      return bot:WasRecentlyDamagedByHero(hero, 2.0)
             and IsTargetable(hero)
    end)

  return enemy_hero ~= nil, GetTarget(enemy_hero, ability)
end

local function ThreeAndMoreUnitsAoe(bot, ability, get_function)
  local cast_range = common_algorithms.GetAbilityRadius(ability)
  local enemies = common_algorithms[get_function](bot, cast_range)

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

function M.three_and_more_enemy_creeps_aoe(bot, ability)
  return ThreeAndMoreUnitsAoe(bot, ability, "GetEnemyCreeps")
end

function M.three_and_more_neutral_creeps_aoe(bot, ability)
  return ThreeAndMoreUnitsAoe(bot, ability, "GetNeutralCreeps")
end

function M.three_and_more_enemy_heroes_aoe(bot, ability)
  return ThreeAndMoreUnitsAoe(bot, ability, "GetEnemyHeroes")
end

function M.autocast_on_attack_enemy_hero(bot, ability)
  local target = bot:GetTarget()

  if target == nil then
    return false, nil end

  if not ability:GetAutoCastState() and target:IsHero() then
    -- Enable the ability when we are attacking an enemy hero

    logger.Print("autocast_on_attack_enemy_hero() - " ..
      bot:GetUnitName() .. " activates " .. ability:GetName())

    ability:ToggleAutoCast()
  elseif ability:GetAutoCastState() and not target:IsHero() then
    -- Disable the ability when we are attacking a creep

    logger.Print("autocast_on_attack_enemy_hero() - " ..
      bot:GetUnitName() .. " deactivates " .. ability:GetName())

    ability:ToggleAutoCast()
  end

  return false, nil
end

function M.toggle_on_attack_enemy_hero(bot, ability)
  local target = bot:GetTarget()
  local is_activated = ability:GetToggleState()

  if is_activated then
    if target == nil
       or not target:IsHero()
       or common_algorithms.IsUnitLowHp(bot) then

      logger.Print("toggle_on_attack_enemy_hero() - " ..
        bot:GetUnitName() .. " deactivates " .. ability:GetName())

      return true, GetTarget(bot, ability)
    end
  else
    if target ~= nil
       and target:IsHero()
       and not common_algorithms.IsUnitLowHp(bot) then

      logger.Print("toggle_on_attack_enemy_hero() - " ..
        bot:GetUnitName() .. " activates " .. ability:GetName())

      return true, GetTarget(bot, ability)
    end
  end
  return false, nil
end

local function UseOnAttackEnemyUnit(bot, ability, check_function)

  local ability_radius = common_algorithms.GetAbilityRadius(ability)
  local radius = functions.ternary(
    ability_radius ~= 0,
    ability_radius,
    bot:GetAttackRange())

  local target = bot:GetTarget()

  local is_succeed =
    (target ~= nil
     and check_function(target)
     and GetUnitToUnitDistance(bot, target) <= radius)

  return is_succeed, GetTarget(target, ability)
end

function M.use_on_attack_enemy_hero(bot, ability)
  return UseOnAttackEnemyUnit(
    bot,
    ability,
    function(unit) return unit:IsHero() end)
end

function M.use_on_attack_enemy_creep(bot, ability)
  return UseOnAttackEnemyUnit(
    bot,
    ability,
    function(unit) return unit:IsCreep() end)
end

function M.use_on_attack_enemy_with_mana_when_low_mp(bot, ability)
  if not common_algorithms.IsUnitLowMp(bot) then
    return false, nil
  end

  return UseOnAttackEnemyUnit(
    bot,
    ability,
    function(unit) return 0 < unit:GetMana() end)
end

local function ThreeAndMoreUnitsSelfAoe(bot, ability, get_function)
  local cast_range = common_algorithms.GetAbilityRadius(ability)
  local enemies = common_algorithms[get_function](bot, cast_range)

  return (3 <= NumberOfTargetableUnits(enemies)), nil
end

function M.three_and_more_enemy_heroes_self_aoe(bot, ability)
  return ThreeAndMoreUnitsSelfAoe(bot, ability, "GetEnemyHeroes")
end

function M.three_and_more_enemy_creeps_self_aoe(bot, ability)
  return ThreeAndMoreUnitsSelfAoe(bot, ability, "GetEnemyCreeps")
end

function M.three_and_more_neutral_creeps_self_aoe(bot, ability)
  return ThreeAndMoreUnitsSelfAoe(bot, ability, "GetNeutralCreeps")
end

function M.three_and_more_ally_creeps_self_aoe(bot, ability)
  return ThreeAndMoreUnitsSelfAoe(bot, ability, "GetAllyCreeps")
end

local function CheckSelf(bot, ability, check_function)
  return common_algorithms[check_function](bot), GetTarget(bot, ability)
end

function M.low_hp_self(bot, ability)
  return CheckSelf(bot, ability, "IsUnitLowHp")
end

function M.low_hp_charges_self(bot, ability)
  if 0 < ability:GetCurrentCharges() then
    return CheckSelf(bot, ability, "IsUnitLowHp")
  else
    return false, nil
  end
end

function M.low_mp_self(bot, ability)
  return CheckSelf(bot, ability, "IsUnitLowMp")
end

function M.half_hp_self(bot, ability)
  return CheckSelf(bot, ability, "IsUnitHalfHp")
end

function M.half_hp_tree(bot, ability)
  if not common_algorithms.IsUnitHalfHp(bot)
     or bot:HasModifier("modifier_tango_heal") then
    return false, nil
  end

  local trees = bot:GetNearbyTrees(1000);
  if trees[1] ~= nil then
    bot:Action_UseAbilityOnTree(ability, trees[1]);
  end

  return false, nil
end

local function CheckUnit(bot, ability, get_function, check_function)
  local cast_range = common_algorithms.GetAbilityRadius(ability)
  local units = common_algorithms[get_function](bot, cast_range)

  local unit = functions.GetElementWith(
    units,
    nil,
    function(unit)
      return IsTargetable(unit)
             and common_algorithms[check_function](unit)
    end)

  return unit ~= nil, GetTarget(unit, ability)
end

function M.low_hp_ally_hero(bot, ability)
  return CheckUnit(bot, ability, "GetAllyHeroes", "IsUnitLowHp")
end

function M.half_hp_ally_hero(bot, ability)
  return CheckUnit(bot, ability, "GetAllyHeroes", "IsUnitHalfHp")
end

function M.low_hp_ally_creep(bot, ability)
  return CheckUnit(bot, ability, "GetAllyCreeps", "IsUnitLowHp")
end

local function IsLastHit(unit, ability)
  return unit:GetHealth() <= ability:GetAbilityDamage()
end

function M.last_hit_enemy_creep(bot, ability)
  local creeps = common_algorithms.GetEnemyCreeps(
    bot,
    common_algorithms.GetAbilityRadius(ability))

  local creep = functions.GetElementWith(
    creeps,
    common_algorithms.CompareMinHealth,
    function(unit)
      return common_algorithms.IsAttackTargetable(unit)
             and IsLastHit(unit, ability)
    end)

  return creep ~= nil, GetTarget(creep, ability)
end

function M.always_self(bot, ability)
  return true, GetTarget(bot, ability)
end

function M.group_enemy_heroes(bot, ability)
  local cast_range = common_algorithms.GetAbilityRadius(ability)
  local units = common_algorithms.GetEnemyHeroes(bot, cast_range)

  if NumberOfTargetableUnits(units) < 2 then
    return false, nil end

  local unit = functions.GetElementWith(
    units,
    common_algorithms.CompareMaxHeroKills,
    function(unit)
      return IsTargetable(unit)
             and common_algorithms.GetAllyHeroes(
               unit,
               constants.MAX_TARGET_GROUP_RADIUS)
    end)

  return unit ~= nil, GetTarget(unit, ability)
end

-- Provide an access to local functions and variables for unit tests only
M.test_IsTargetable = IsTargetable
M.test_NumberOfTargetableUnits = NumberOfTargetableUnits
M.test_IsEnoughDamageToKill = IsEnoughDamageToKill
M.test_GetTarget = GetTarget
M.test_UseOnAttackEnemyUnit = UseOnAttackEnemyUnit
M.test_GetUnitManaLevel = GetUnitManaLevel
M.test_IsDisabled = IsDisabled

return M
