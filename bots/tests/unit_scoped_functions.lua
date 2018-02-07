package.path = package.path .. ";../?.lua"
require("global_constants")

function GetScriptDirectory()
  return ".."
end

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

Unit = {}

function Unit:new(name)
  local newObj = {
    name = functions.ternary(
      name ~= nil,
      name,
      "npc_dota_hero_crystal_maiden"),

    health = 400,
    max_health = 400,
    mana = 200,
    max_mana = 200,
    offensive_power = 100,
    gold = 625,
    ability_points = 1,
    level = 1,
    inventory = {},
    location = {10, 10},
    networth = 500,
    damage = 100
  }

  self.__index = self
  return setmetatable(newObj, self)
end

function Unit:GetUnitName()
  return self.name
end

function Unit:GetHealth()
  return self.health
end

function Unit:GetMana()
  return self.mana
end

function Unit:GetMaxMana()
  return self.max_mana
end

function Unit:GetMaxHealth()
  return self.max_health
end

function Unit:IsAlive()
  return 0 < self.health
end

function Unit:GetRawOffensivePower()
  return self.offensivePower
end

DISTANCE_FROM_SHOP = 0

function Unit:DistanceFromSecretShop()
  return DISTANCE_FROM_SHOP
end

function Unit:DistanceFromSideShop()
  return DISTANCE_FROM_SHOP
end

function Unit:DistanceFromFountain()
  return DISTANCE_FROM_SHOP
end

UNIT_PURCHASE_RESULT = PURCHASE_ITEM_SUCCESS

function Unit:ActionImmediate_PurchaseItem(item)
  self.gold = self.gold - GetItemCost(item)

  table.insert(self.inventory, item)

  return UNIT_PURCHASE_RESULT
end

function Unit:ActionImmediate_SellItem(item)
  local index = functions.GetElementIndexInList(
    self.inventory,
    item.name)

  if index == -1 then return end

  self.gold = self.gold - GetItemCost(item.name)

  self.inventory[index] = "nil"
end

UNIT_CAN_BE_SEEN = true

function Unit:CanBeSeen()
  return UNIT_CAN_BE_SEEN
end

UNIT_IS_MAGIC_IMMUNE = false

function Unit:IsMagicImmune()
  return UNIT_IS_MAGIC_IMMUNE
end

UNIT_IS_INVULNERABLE = false

function Unit:IsInvulnerable()
  return UNIT_IS_INVULNERABLE
end

UNIT_IS_ILLUSION = false

function Unit:IsIllusion()
  return UNIT_IS_ILLUSION
end

function Unit:GetActualIncomingDamage(damage, damage_type)
  return damage
end

function Unit:GetLocation()
  return self.location
end

UNIT_EXTRAPOLATED_LOCATION = {10, 10}

function Unit:GetExtrapolatedLocation()
  return UNIT_EXTRAPOLATED_LOCATION
end

UNIT_IS_CHANNELING = false

function Unit:IsChanneling()
  return UNIT_IS_CHANNELING
end

UNIT_IS_USING_ABILITY = false

function Unit:IsUsingAbility()
  return UNIT_IS_USING_ABILITY
end

UNIT_IS_CASTING_ABILITY = false

function Unit:IsCastingAbility()
  return UNIT_IS_CASTING_ABILITY
end

function Unit:GetNetWorth()
  return self.networth
end

UNIT_IS_HERO = true

function Unit:IsHero()
  return UNIT_IS_HERO
end

function Unit:IsCreep()
  return not UNIT_IS_HERO
end

UNIT_IS_BUILDING = true

function Unit:IsBuilding()
  return UNIT_IS_BUILDING
end

function Unit:GetOffensivePower()
  return self.offensive_power
end

function Unit:GetPlayerID()
  return 0
end

function Unit:GetEstimatedDamageToTarget(
  currently_available,
  target,
  duration,
  damage_type)

  return self.damage
end

function Unit:IsNull()
  return false
end

function Unit:GetTeam()
  return TEAM_RADIANT
end

UNIT_CLEAR_ACTIONS = false

function Unit:Action_ClearActions()
  UNIT_CLEAR_ACTIONS = true
end

-----------------------------------------------

Item = {}

function Item:new(n)
  local newObj = { name = n }
  self.__index = self
  return setmetatable(newObj, self)
end

function Unit:GetItemInSlot(slot)
  local item_in_slot = self.inventory[slot + 1]

  if item_in_slot == nil then return nil end

  local item = Item:new()
  item.name = self.inventory[slot + 1]
  return item
end

function Item:GetName()
  return self.name
end

ITEM_IS_FULLY_CASTABLE = true

function Item:IsFullyCastable()
  return ITEM_IS_FULLY_CASTABLE
end

-----------------------------------------------

function Unit:SetNextItemPurchaseValue(cost)
end

function Unit:GetGold()
  return self.gold
end

function Unit:FindItemSlot(itemName)
  for i, item in pairs(self.inventory) do
    if item == itemName then
      return (i - 1) end
  end

  return -1
end

UNIT_NO_NEARBY_UNITS = false
UNIT_NO_NEARBY_ALLIES = false

function Unit:GetNearbyHeroes(radius, enemies, mode)
  if UNIT_NO_NEARBY_UNITS then
    return {} end

  if UNIT_NO_NEARBY_ALLIES and not enemies then
    return {} end

  local unit1 = Unit:new()
  unit1.name = "unit1"
  unit1.health = 10
  unit1.location = {10, 10}
  unit1.damage = 100

  local unit2 = Unit:new()
  unit2.name = "unit2"
  unit2.health = 200
  unit2.networth = 1000
  unit2.location = {20, 20}
  unit2.damage = 200

  local unit3 = Unit:new()
  unit3.name = "unit3"
  unit3.health = 180
  unit3.networth = 180
  unit3.location = {15, 15}
  unit3.damage = 180

  return { unit1, unit2, unit3 }
end

NEARBY_CREEPS_COUNT = 3

function Unit:GetNearbyCreeps(radius, enemies)
  if UNIT_NO_NEARBY_UNITS then
    return {} end

  local unit1 = Unit:new()
  unit1.name = "creep1"
  unit1.health = 10
  unit1.location = {10, 10}

  local unit2 = Unit:new()
  unit2.name = "creep2"
  unit2.health = 200
  unit2.networth = 1000
  unit2.location = {20, 20}

  local unit3 = Unit:new()
  unit3.name = "creep3"
  unit3.health = 180
  unit3.networth = 180
  unit3.location = {15, 15}

  if NEARBY_CREEPS_COUNT == 3 then
    return { unit1, unit2, unit3 }
  else
    return { unit1, unit2 }
  end
end

function Unit:GetNearbyTowers(radius, enemies, mode)
  if not UNIT_IS_NEARBY_TOWERS then
    return {} end

  if UNIT_NO_NEARBY_UNITS then
    return {} end

  local unit1 = Unit:new()
  unit1.name = "tower1"
  unit1.health = 10
  unit1.location = {10, 10}
  unit1.offensive_power = 100

  local unit2 = Unit:new()
  unit2.name = "tower2"
  unit2.health = 200
  unit2.networth = 1000
  unit2.location = {20, 20}
  unit2.offensive_power = 200

  local unit3 = Unit:new()
  unit3.name = "tower3"
  unit3.health = 180
  unit3.networth = 180
  unit3.location = {15, 15}
  unit3.offensive_power = 180

  return { unit1, unit2, unit3 }
end

function Unit:GetNearbyBarracks(radius, enemies, mode)
  if UNIT_NO_NEARBY_UNITS then
    return {} end

  local unit1 = Unit:new()
  unit1.name = "barrak1"
  unit1.health = 10
  unit1.location = {10, 10}
  unit1.offensive_power = 100

  local unit2 = Unit:new()
  unit2.name = "barrak2"
  unit2.health = 200
  unit2.networth = 1000
  unit2.location = {20, 20}
  unit2.offensive_power = 200

  return { unit1, unit2 }
end

function Unit:GetNearbyShrines(radius, enemy)
  local unit1 = Unit:new()
  unit1.name = "shrine1"
  unit1.health = 10
  unit1.location = {900, 900}
  unit1.offensive_power = 100

  return { unit1 }
end

FIND_AOE_LOCATION_COUNT = 3

function Unit:FindAoELocation()
  return {count = FIND_AOE_LOCATION_COUNT, targetloc = {1.2, 3.4}}
end

UNIT_ABILITY = nil
UNIT_ABILITY_LOCATION = nil

function Unit:Action_UseAbilityOnLocation(ability, location)
  UNIT_ABILITY = ability
UNIT_ABILITY_LOCATION = location
end

UNIT_ABILITY_ENTITY = nil

function Unit:Action_UseAbilityOnEntity(ability, entity)
  UNIT_ABILITY = ability
UNIT_ABILITY_ENTITY = entity
end

function Unit:Action_UseAbility(ability)
  UNIT_ABILITY = ability
end

function Unit:GetPlayerID()
  return 5
end

COURIER_VALUE = 0

function Unit:GetCourierValue()
  return COURIER_VALUE
end

UNIT_MODE = BOT_MODE_NONE

function Unit:GetActiveMode()
  return UNIT_MODE
end

COURIER_ACTION = nil

function Unit:ActionImmediate_Courier(courier, action)
  COURIER_ACTION = action
end

STASH_VALUE = 0

function Unit:GetStashValue()
  return STASH_VALUE
end

WAS_DAMAGED = false

function Unit:WasRecentlyDamagedByAnyHero()
  return WAS_DAMAGED
end

UNIT_ACTION = nil
UNIT_MOVE_LOCATION = nil

function Unit:Action_MoveToLocation(location)
  UNIT_ACTION = UNIT_ACTION_TYPE_MOVE_TO
  UNIT_MOVE_LOCATION = location
end

UNIT_PICKUP_RUNE = nil

function Unit:Action_PickUpRune(rune)
  UNIT_PICKUP_RUNE = rune
end

UNIT_USE_SHRINE = nil

function Unit:Action_UseShrine(shrine)
  UNIT_USE_SHRINE = shrine
end

function Unit:GetLevel()
  return self.level
end

UNIT_ABILITIES = {}

function Unit:GetAbilityInSlot(slot_number)
  -- The first ability has the 0 slot in the game.
  return UNIT_ABILITIES[slot_number + 1]
end

UNIT_LEVELUP_ABILITY = nil

function Unit:ActionImmediate_LevelAbility(ability_name)
  UNIT_LEVELUP_ABILITY = ability_name
end

ATTACK_MOVE_LOCATION = nil

function Unit:Action_AttackMove(location)
  ATTACK_MOVE_LOCATION = location
end

function Unit:GetAbilityPoints()
  return self.ability_points
end

function Unit:WasRecentlyDamagedByHero(unit, time)
  return true
end

function Unit:GetCurrentVisionRange()
  return 1600
end

ATTACK_TARGET = nil

function Unit:Action_AttackUnit(target, is_once)
  ATTACK_TARGET = target
end

function Unit:SetTarget(target)
  ATTACK_TARGET = target
end

function Unit:GetTarget(target)
  return ATTACK_TARGET
end

function Unit:GetAttackTarget()
  return ATTACK_TARGET
end

function Unit:GetAttackDamage()
  return 60
end

UNIT_HAS_BUYBACK = true

function Unit:HasBuyback()
  return UNIT_HAS_BUYBACK
end

function Unit:GetBuybackCost()
  return 500
end

function Unit:GetBaseMovementSpeed()
  return 150
end

function Unit:GetAttackRange()
  return 550
end

UNIT_ITEM_SLOT_TYPE = ITEM_SLOT_TYPE_MAIN

function Unit:GetItemSlotType()
  return UNIT_ITEM_SLOT_TYPE
end

UNIT_MODIFIER = nil

function Unit:HasModifier(modifier_name)
  return UNIT_MODIFIER == modifier_name
end

------------------------------------------

Ability = {}

function Ability:new(n)
  local newObj = {
    name = n,
    cast_range = 600}

  self.__index = self
  return setmetatable(newObj, self)
end

function Unit:GetAbilityByName(abilityName)
  return Ability:new(abilityName)
end

function Unit:GetCurrentActiveAbility()
  return Ability:new("crystal_maiden_freezing_field")
end

function Ability:GetCastRange()
  return self.cast_range
end

ABILITY_IS_FULLY_CASTABLE = true
ABILITY_CASTABLE_NAME = nil

function Ability:IsFullyCastable()
  return ABILITY_IS_FULLY_CASTABLE
         and (ABILITY_CASTABLE_NAME == nil or
              (ABILITY_CASTABLE_NAME ~= nil and
               self.name == ABILITY_CASTABLE_NAME))
end

function Ability:IsAbilityCastable()
  return true
end

function Ability:IsOwnersManaEnough()
  return true
end

function Ability:IsCooldownReady()
  return true
end

function Ability:IsTrained()
  return true
end

function Ability:IsTalent()
  return string.match(self.name, "special_bonus")
end

ABILITY_DAMAGE = 100

function Ability:GetAbilityDamage()
  return ABILITY_DAMAGE
end

function Ability:GetName()
  return self.name
end

ABILITY_CAN_BE_UPGRADED = true

function Ability:CanAbilityBeUpgraded()
  return ABILITY_CAN_BE_UPGRADED
end

ABILITY_BEHAVIOR = 0

function Ability:GetBehavior()
  return ABILITY_BEHAVIOR
end

function Ability:GetDamageType()
  return DAMAGE_TYPE_MAGICAL
end

function Ability:GetAOERadius()
  return 600
end

function Ability:GetSpecialValueInt(value_name)
  return 600
end

ABILITY_TOGGLE_STATE = false

function Ability:GetAutoCastState()
  return ABILITY_TOGGLE_STATE
end

function Ability:ToggleAutoCast()
  ABILITY_TOGGLE_STATE = not ABILITY_TOGGLE_STATE
end

ABILITY_IS_NULL = false

function Ability:IsNull()
  return ABILITY_IS_NULL
end
