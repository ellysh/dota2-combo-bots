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

function Unit:new()
  local newObj = {
    name = "npc_dota_hero_crystal_maiden",
    health = 200,
    max_health = 200,
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

function Unit:ActionImmediate_PurchaseItem(item)
  self.gold = self.gold - GetItemCost(item)

  table.insert(self.inventory, item)

  return PURCHASE_ITEM_SUCCESS
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

function Unit:GetExtrapolatedLocation()
  return self.location
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

function Unit:GetAttackTarget()
  return Unit:new()
end

UNIT_IS_HERO = true

function Unit:IsHero()
  return UNIT_IS_HERO
end

function Unit:IsCreep()
  return not UNIT_IS_HERO
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

function Unit:GetItemInSlot(slot)
  local item_in_slot = self.inventory[slot]

  if item_in_slot == nil then return nil end

  local item = Item:new()
  item.name = self.inventory[slot]
  return item
end

function Unit:GetTeam()
  return TEAM_RADIANT
end

-----------------------------------------------

Item = {}

function Item:new()
  local newObj = { name = nil }
  self.__index = self
  return setmetatable(newObj, self)
end

function Item:GetName()
  return self.name
end

-----------------------------------------------

Bot = Unit:new()

function Bot:new()
  local newObj = {}
  self.__index = self
  return setmetatable(newObj, self)
end

function Bot:SetNextItemPurchaseValue(cost)
end

function Bot:GetGold()
  return self.gold
end

function Bot:FindItemSlot(itemName)
  for i, item in pairs(self.inventory) do
    if item == itemName then return i end
  end

  return -1
end

function Bot:GetNearbyHeroes(radius, enemies, mode)
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

function Bot:GetNearbyCreeps(radius, enemies)
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

  return { unit1, unit2, unit3 }
end

BOT_IS_NEARBY_TOWERS = true

function Bot:GetNearbyTowers(radius, enemies, mode)
  if not BOT_IS_NEARBY_TOWERS then return {} end

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

function Bot:GetNearbyBarracks(radius, enemies, mode)
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

function Bot:FindAoELocation()
  return {count = 3, targetloc = {1.2, 3.4}}
end

BOT_ABILITY = nil
BOT_ABILITY_LOCATION = nil

function Bot:Action_UseAbilityOnLocation(ability, location)
  BOT_ABILITY = ability
BOT_ABILITY_LOCATION = location
end

BOT_ABILITY_ENTITY = nil

function Bot:Action_UseAbilityOnEntity(ability, entity)
  BOT_ABILITY = ability
BOT_ABILITY_ENTITY = entity
end

function Bot:Action_UseAbility(ability)
  BOT_ABILITY = ability
end

function Bot:GetPlayerID()
  return 5
end

COURIER_VALUE = 0

function Bot:GetCourierValue()
  return COURIER_VALUE
end

BOT_MODE = BOT_MODE_NONE

function Bot:GetActiveMode()
  return BOT_MODE
end

COURIER_ACTION = nil

function Bot:ActionImmediate_Courier(courier, action)
  COURIER_ACTION = action
end

STASH_VALUE = 0

function Bot:GetStashValue()
  return STASH_VALUE
end

WAS_DAMAGED = false

function Bot:WasRecentlyDamagedByAnyHero()
  return WAS_DAMAGED
end

BOT_ACTION = nil
BOT_MOVE_LOCATION = nil

function Bot:Action_MoveToLocation(location)
  BOT_ACTION = BOT_ACTION_TYPE_MOVE_TO
  BOT_MOVE_LOCATION = location
end

function Bot:GetLevel()
  return self.level
end

BOT_ABILITIES = {}

function Bot:GetAbilityInSlot(slot_number)
  -- The first ability has the 0 slot in the game.
  return BOT_ABILITIES[slot_number + 1]
end

BOT_LEVELUP_ABILITY = nil

function Bot:ActionImmediate_LevelAbility(ability_name)
  BOT_LEVELUP_ABILITY = ability_name
end

ATTACK_MOVE_LOCATION = nil

function Bot:Action_AttackMove(location)
  ATTACK_MOVE_LOCATION = location
end

function Bot:GetAbilityPoints()
  return self.ability_points
end

function Bot:WasRecentlyDamagedByHero(unit, time)
  return true
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

function Bot:GetAbilityByName(abilityName)
  return Ability:new(abilityName)
end

function Ability:GetCastRange()
  return self.cast_range
end

function Ability:IsFullyCastable()
  return string.find(self.name, "crystal_maiden") ~= nil
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
