local logger = require(
    GetScriptDirectory() .."/utility/logger")

local M = {}

local function GetEnemiesNearLocation(loc, dist)
  if loc ==nil then return {} end

  local enemies={}

  for _,enemy in pairs(GetUnitList(UNIT_LIST_ENEMY_HEROES)) do
    if(GetUnitToLocationDistance(enemy, loc) < dist)
    then
      table.insert(enemies,enemy)
    end
  end

  return enemies
end

local Towers = {
    TOWER_TOP_1,
    TOWER_TOP_2,
    TOWER_TOP_3,
    TOWER_MID_1,
    TOWER_MID_2,
    TOWER_MID_3,
    TOWER_BOT_1,
    TOWER_BOT_2,
    TOWER_BOT_3,
    TOWER_BASE_1,
    TOWER_BASE_2
}

local function IsBotBusy(npcBot)
  return npcBot:IsChanneling()
        or npcBot:IsUsingAbility()
        or npcBot:IsCastingAbility()
end

function M.UseGlyph(npcBot)
  if IsBotBusy(npcBot) then return end

  -- TODO: This check always returns 108 second.
  --if GetGlyphCooldown() > 0 then return end

  for i, buildingId in pairs(Towers) do
    local tower = GetTower(GetTeam(), buildingId)

    if tower ~= nil then

      local tableNearbyEnemyHeroes = GetEnemiesNearLocation(
        tower:GetLocation(),
        800)

      if 150 <= tower:GetHealth() and tower:GetHealth() <= 1600
          and 2 <= #tableNearbyEnemyHeroes then

        --logger.Print("M.UseGlyph() - use glyph to " .. tower:GetUnitName() .. ". HP = " .. tower:GetHealth() .. " enemies = " .. #tableNearbyEnemyHeroes)

        npcBot:ActionImmediate_Glyph()
        break
      end
    end
  end
end

function M.GetHeroWith(npcBot, comparison, attr, radius, enemy)

  local heroes = npcBot:GetNearbyHeroes(radius, enemy, BOT_MODE_NONE)
  local hero = npcBot
  local value = npcBot[attr](npcBot)

  if enemy then
    hero = nil
    value = 10000
  end

  if comparison == 'max' then
    value = 0
  end

  if heroes == nil or #heroes == 0 then
    return hero, value
  end

  for _, h in pairs(heroes) do

    if h ~= nil and h:IsAlive() then

      local valueToCompare = h[attr](h)
      local success = valueToCompare < value

      if comparison == 'max' then
        success = valueToCompare > value
      end

      if success then
        value = valueToCompare
        hero = h
      end

    end
  end

  return hero, value

end

local function IsAbilityCastable(ability)

  return ability:IsFullyCastable()
    and ability:IsOwnersManaEnough()
    and ability:IsCooldownReady()
    and ability:IsTrained()
    and bit.band(ability:GetBehavior(), ABILITY_BEHAVIOR_PASSIVE) == 0
end

-----------------------

-- TODO: Remove this block of usage abilites function

function M.UseWard(npcBot, abilityName)
  if IsBotBusy(npcBot) then return end

  local ability = npcBot:GetAbilityByName(abilityName)

  if not IsAbilityCastable(ability) then return end

  local castRange = ability:GetCastRange()
  local target = npcBot:FindAoELocation(
    true,
    true,
    npcBot:GetLocation(),
    castRange,
    400,        -- TODO: With Aghanim the wards radius became 875
    0,
    0)

  if target.count >= 2 then

    logger.Print("M.UseWard() - " .. npcBot:GetUnitName() .. " cast #1 " .. abilityName .. " to " .. target.count)

    return npcBot:ActionPush_UseAbilityOnLocation(
      ability,
      target.targetloc)
  end

  local towers = npcBot:GetNearbyTowers(castRange, true)
  if #towers > 0 then
    target = towers[1]:GetLocation()

    logger.Print("M.UseWard() - " .. npcBot:GetUnitName() .. " cast #2 " .. abilityName .. " to " .. target:GetUnitName())

    return npcBot:ActionPush_UseAbilityOnLocation(ability, target)
  end

  local barracks = npcBot:GetNearbyBarracks(castRange, true)
  if #barracks > 0 then
    target = barracks[1]:GetLocation()

    logger.Print("M.UseWard() - " .. npcBot:GetUnitName() .. " cast #3 " .. abilityName .. " to " .. target:GetUnitName())

    return npcBot:ActionPush_UseAbilityOnLocation(ability, target)
  end
end

function M.UseChanneledNoTargetDisable(npcBot, abilityName)
  if IsBotBusy(npcBot) then return end

  local ability = npcBot:GetAbilityByName(abilityName)

  if not IsAbilityCastable(ability) then return end

  local target = npcBot:FindAoELocation(
    true,
    true,
    npcBot:GetLocation(),
    700,
    700,        -- This is the crystal_maiden_freezing_field radius
    0,
    0)

  if target.count >= 3 then

    logger.Print("M.UseChanneledNoTargetDisable() - " .. npcBot:GetUnitName() .. " cast " .. abilityName .. " to " .. target.count)

    return npcBot:ActionPush_UseAbility(ability)
  end
end

function M.UseChanneledSingleDisable(npcBot, abilityName)
  if IsBotBusy(npcBot) then return end

  local ability = npcBot:GetAbilityByName(abilityName)

  if not IsAbilityCastable(ability) then return end

  -- Check if an ally hero is near. He will attack the disabled enemy
  if #npcBot:GetNearbyHeroes(700, false, BOT_MODE_NONE) == 0 then return end

  local castRange = ability:GetCastRange()
  local target = M.GetHeroWith(
    npcBot,
    'max',
    'GetRawOffensivePower',
    castRange,
    true)

  if target ~= nil then

    logger.Print("M.UseChanneledSingleDisable() - " .. npcBot:GetUnitName() .. " cast " .. abilityName .. " to " .. target:GetUnitName())

    return npcBot:Action_UseAbilityOnEntity(ability, target)
  end
end

function M.UseSingleDisable(npcBot, abilityName)
  if IsBotBusy(npcBot) then return end

  local ability = npcBot:GetAbilityByName(abilityName)

  if not IsAbilityCastable(ability) then return end

  local castRange = ability:GetCastRange()

  -- Disable the most dangerous enemy in teamfight
  local enemies = npcBot:GetNearbyHeroes(castRange, true, BOT_MODE_NONE)

  if #enemies >= 3 then

    local target = M.GetHeroWith(
      npcBot,
      'max',
      'GetRawOffensivePower',
      castRange,
      true)

    if target ~= nil then

      logger.Print("M.UseSingleDisable() - " .. npcBot:GetUnitName() .. " cast " .. abilityName .. " to " .. target:GetUnitName())

      return npcBot:Action_UseAbilityOnEntity(ability, target)
    end
  end

  -- Disable the damaged enemy
  local target = M.GetHeroWith(
    npcBot,
    'min',
    'GetHealth',
    castRange,
    true)

  if target ~= nil and target:GetHealth() <= target:GetMaxHealth() then

    logger.Print("M.UseSingleDisable() - " .. npcBot:GetUnitName() .. " cast " .. abilityName .. " to " .. target:GetUnitName())

    return npcBot:Action_UseAbilityOnEntity(ability, target)
  end

end

function M.UseMultiNuke(npcBot, abilityName)
  if npcBot:IsChanneling() or npcBot:IsUsingAbility() then
    return
  end

  local ability = npcBot:GetAbilityByName(abilityName)

  if not IsAbilityCastable(ability) then return end

  local castRange = ability:GetCastRange()

  local target = npcBot:GetNearbyHeroes(castRange, true, BOT_MODE_NONE)

  if #target >= 2 then

    logger.Print("M.UseMultiNuke() - " .. npcBot:GetUnitName() .. " cast " .. abilityName .. " to " .. target[1]:GetUnitName())

    return npcBot:Action_UseAbilityOnEntity(ability, target[1])
  end

  target = M.GetHeroWith(
    npcBot,
    'min',
    'GetHealth',
    castRange,
    true)

  if target ~= nil and target:GetHealth() <= target:GetMaxHealth() then

    logger.Print("M.UseMultiNuke() - " .. npcBot:GetUnitName() .. " cast " .. abilityName .. " to " .. target:GetUnitName())

    return npcBot:Action_UseAbilityOnEntity(ability, target)
  end
end

function M.UseAreaNuke(npcBot, abilityName)
  if npcBot:IsChanneling() or npcBot:IsUsingAbility() then
    return
  end

  local ability = npcBot:GetAbilityByName(abilityName)

  if not IsAbilityCastable(ability) then return end

  local castRange = ability:GetCastRange()
  local target = npcBot:FindAoELocation(
    true,
    true,
    npcBot:GetLocation(),
    castRange,
    castRange,
    0,
    0)

  if target.count >= 2 then

    logger.Print("M.UseAreaNuke() - " .. npcBot:GetUnitName() .. " cast #1 " ..   abilityName .. " to " .. target.count)

    return npcBot:ActionPush_UseAbilityOnLocation(
      ability,
      target.targetloc)
  end

  target = M.GetHeroWith(
    npcBot,
    'min',
    'GetHealth',
    castRange,
    true)

  if target ~= nil and target:GetHealth() <= target:GetMaxHealth() then

    logger.Print("M.UseAreaNuke() - " .. npcBot:GetUnitName() .. " cast " .. abilityName .. " to " .. target:GetUnitName())

    return npcBot:Action_ActionPush_UseAbilityOnLocation(ability, target)
  end
end

-------

local function CreateAbilityObject(ability)
  local result = {}

  result.name = ability:GetName()
  result.ability = ability
  result.castRange = ability:GetCastRange()
  result.damage = ability:GetAbilityDamage()
  result.damageType = ability:GetDamageType()
    -- DAMAGE_TYPE_PHYSICAL
    -- DAMAGE_TYPE_MAGICAL
    -- DAMAGE_TYPE_PURE

  result.duration = ability:GetDuration()
  result.targetTeam = ability:GetTargetTeam()
    -- ABILITY_TARGET_TEAM_NONE
    -- ABILITY_TARGET_TEAM_FRIENDLY
    -- ABILITY_TARGET_TEAM_ENEMY

  result.targetType = ability:GetTargetType()
  result.targetFlags = ability:GetTargetFlags()
    -- ABILITY_TARGET_FLAG_MANA_ONLY

  result.manaCost = ability:GetManaCost()
  result.behavior = ability:GetBehavior()
    -- ABILITY_BEHAVIOR_NO_TARGET
    -- ABILITY_BEHAVIOR_UNIT_TARGET
    -- ABILITY_BEHAVIOR_POINT
    -- ABILITY_BEHAVIOR_AOE

  return result
end

function M.InitAbilities(npcBot, abilities)

  for i = 0, 25, 1 do
    local ability = npcBot:GetAbilityInSlot(i)

    if ability == nil
      or ability:GetName() == "generic_hidden" then goto continue end

    if not ability:IsTalent() then
      table.insert(abilities, CreateAbilityObject(ability))
    end

    ::continue::
  end

  logger.Print("M.InitAbilities() - " .. npcBot:GetUnitName() .. " loads " .. #abilities .. " abilities" )
end

local function IsOffensiveMode(npcBot)
  return npcBot:GetActiveMode() == BOT_MODE_ATTACK
    or npcBot:GetActiveMode() == BOT_MODE_ROAM
    or npcBot:GetActiveMode() == BOT_MODE_TEAM_ROAM
    or npcBot:GetActiveMode() == BOT_MODE_PUSH_TOWER_TOP
    or npcBot:GetActiveMode() == BOT_MODE_PUSH_TOWER_MID
    or npcBot:GetActiveMode() == BOT_MODE_PUSH_TOWER_BOT
end

local function IsDefensiveMode(npcBot)
  return npcBot:GetActiveMode() == BOT_MODE_RETREAT
    or npcBot:GetActiveMode() == BOT_MODE_DEFEND_ALLY
    or npcBot:GetActiveMode() == BOT_MODE_EVASIVE_MANEUVERS
    or npcBot:GetActiveMode() == BOT_MODE_DEFEND_TOWER_TOP
    or npcBot:GetActiveMode() == BOT_MODE_DEFEND_TOWER_MID
    or npcBot:GetActiveMode() == BOT_MODE_DEFEND_TOWER_BOT
end

local function IsAlliesGroupHaveOffensiveMode(heroes)
  for _, hero in pairs(heroes) do
    if IsOffensiveMode(hero) then return true end
  end

  return false
end

-- TODO: Generalize this and above functions
local function IsAlliesGroupHaveDevensiveMode(heroes)
  for _, hero in pairs(heroes) do
    if IsDefensiveMode(hero) then return true end
  end

  return false
end

local MAX_ATTACK_RANGE = 950

local function GetNearbyEnemies(npcBot)
  return npcBot:GetNearbyHeroes(MAX_ATTACK_RANGE, true, BOT_MODE_NONE)
end

local function GetNearbyAllies(npcBot)
  return npcBot:GetNearbyHeroes(MAX_ATTACK_RANGE, false, BOT_MODE_NONE)
end

local function IsTeamfight(npcBot)
  local allies = GetNearbyAllies(npcBot)

  if 3 <= #GetNearbyEnemies(npcBot) and 3 <= #allies then
    return IsAlliesGroupHaveOffensiveMode(allies)
  end
end

local function IsChasing(npcBot)
  local allies = GetNearbyAllies(npcBot)

  if 0 < #allies and 0 < #GetNearbyEnemies(npcBot) and #GetNearbyEnemies(npcBot) < #allies then
    return IsAlliesGroupHaveOffensiveMode(allies)
  end
end

local function IsDefending(npcBot)
  local allies = GetNearbyAllies(npcBot)

  if #allies < #GetNearbyEnemies(npcBot) then
    return IsAlliesGroupHaveDevensiveMode(allies)
  end
end

local function IsAbilityOffensive(ability)
  return ability.targetTeam ~= ABILITY_TARGET_TEAM_FRIENDLY
end

local function EstimateOffensiveAbilityPower(ability)
  -- Estimation from 0 to 100

  local result = 0

  if not IsAbilityOffensive(ability) then return 0 end

  if ability.targetFlags == ABILITY_TARGET_FLAG_MANA_ONLY then return 10 end

  if bit.band(ability.behavior, ABILITY_BEHAVIOR_AOE) ~= 0
    or bit.band(ability.behavior, ABILITY_BEHAVIOR_NO_TARGET) ~= 0 then

    result = result + 20
  end

  if bit.band(ability.behavior, ABILITY_BEHAVIOR_CHANNELLED) ~= 0 then
    result = result + 20
  end

  if bit.band(ability.behavior, ABILITY_BEHAVIOR_ROOT_DISABLES) ~= 0 then
    result = result + 15
  end

  if ability.damageType == DAMAGE_TYPE_PURE then
    result = result + 10
  end

  if ability.damageType == DAMAGE_TYPE_MAGICAL then
    result = result + 5
  end

  local damage = ability.damage
  if ability.duration > 0 then
    result = result + 5
    damage = damage * ability.duration
  end

  result = result + damage / 100

  return result
end

local function GetStrongestAbility(decisionTable)
  local result = nil
  local maxPower = 0

  for _, ability in pairs(decisionTable) do
    if ability.power > maxPower then
      result = ability.ability
      maxPower = ability.power
    end
  end

  return result
end

local function FindStrongestOffensiveAbility(npcBot, abilities)
  local decisionTable = {}

  for _, ability in pairs(abilities) do

    if not IsAbilityCastable(ability.ability)
      or not IsAbilityOffensive(ability) then goto continue end

    local decisionAbility = {}
    decisionAbility.ability = ability
    decisionAbility.power = EstimateOffensiveAbilityPower(ability)

    table.insert(decisionTable, decisionAbility)

    ::continue::
  end

  return GetStrongestAbility(decisionTable)
end

local EnemyChoice = {
  STRONGEST_ENEMY,
  MIN_HP_ENEMY
}

local function GetEnemy(npcBot, enemyChoice, radius)
  if enemyChoice == STRONGEST_ENEMY then
    return M.GetHeroWith(
      npcBot,
      'max',
      'GetRawOffensivePower',
      radius,
      true)
  end
  if enemyChoice == MIN_HP_ENEMY then
    return M.GetHeroWith(
      npcBot,
      'min',
      'GetHealth',
      radius,
      true)
  end
end

local function UseOffensiveAbility(npcBot, ability, enemyChoice)

  -- TODO: Process the case when enemy stands far than the ability radius
  if bit.band(ability.behavior, ABILITY_BEHAVIOR_NO_TARGET) ~= 0 then

      logger.Print("UseOffensiveAbility() - " .. npcBot:GetUnitName()
        .. "cast " .. ability.name)

    return npcBot:ActionPush_UseAbility(ability.ability)
  end

  if bit.band(ability.behavior, ABILITY_BEHAVIOR_UNIT_TARGET) ~= 0 then

    local target = GetEnemy(npcBot, enemyChoice, ability.castRange)

    if target ~= nil then

      logger.Print("UseOffensiveAbility() - " .. npcBot:GetUnitName()
        .. " cast " .. ability.name .. " to " .. target:GetUnitName())

      return npcBot:Action_UseAbilityOnEntity(ability.ability, target)
    end
  end

  if bit.band(ability.behavior, ABILITY_BEHAVIOR_POINT) ~= 0 then
    local target = npcBot:FindAoELocation(
      true,
      true,
      npcBot:GetLocation(),
      ability.castRange,
      400,  -- TODO: Fix this magic number
      0,
      0)

    logger.Print("UseOffensiveAbility() - " .. npcBot:GetUnitName()
      .. "cast " .. ability.name .. " to " .. target.count .. " targets")

    return npcBot:ActionPush_UseAbilityOnLocation(
      ability.ability,
      target.targetloc)
  end
end

local function UseStrongestOffensiveAbility(
  npcBot,
  abilities,
  enemyChoice)

  local useAbility = FindStrongestOffensiveAbility(npcBot, abilities)

  if useAbility == nil then return end

  UseOffensiveAbility(npcBot, useAbility, enemyChoice)
end

local function UseStrongestDefensiveAbility(
  npcBot,
  abilities,
  enemyChoice)

  -- TODO: Use FindStrongestDefensiveAbility(), which prefers disable skills
  local useAbility = FindStrongestOffensiveAbility(npcBot, abilities)

  if useAbility == nil then return end

  UseOffensiveAbility(npcBot, useAbility, enemyChoice)
end

local function UseAbilityOffensive(npcBot, abilities)

  if not IsOffensiveMode(npcBot) then return end

  if IsTeamfight(npcBot) then
    UseStrongestOffensiveAbility(npcBot, abilities, STRONGEST_ENEMY)
  end

  if IsChasing(npcBot) then
    UseStrongestOffensiveAbility(npcBot, abilities, MIN_HP_ENEMY)
  end

end

local function UseAbilityDefensive(npcBot, abilities)

  if not IsDefensiveMode(npcBot) then return end

  if IsDefending(npcBot) then
    UseStrongestDefensiveAbility(npcBot, abilities, STRONGEST_ENEMY)
  end
end

function M.UseAbility(npcBot, abilities)

  if IsBotBusy(npcBot) then return end

  UseAbilityOffensive(npcBot, abilities)

  UseAbilityDefensive(npcBot, abilities)
end

-------

return M
