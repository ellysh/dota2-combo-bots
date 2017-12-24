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
    offensive_power = 100,
    is_alive = true,
    location = {0, 0},
    gold = 625,
    inventory = {}
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

function Unit:GetMaxHealth()
  return self.max_health
end

function Unit:IsAlive()
  return self.is_alive
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

local function AssembleItem(item, inventory)
  if item ~= "item_ring_of_health" then return false end

  local index = functions.GetElementIndexInList(
    "item_void_stone",
    inventory)

  if index == -1 then return false end

  inventory[index] = "item_pers"
  return true
end

function Unit:ActionImmediate_PurchaseItem(item)
  self.gold = self.gold - GetItemCost(item)

  -- Assemble item_pers for the item purchase test
  if AssembleItem(item, self.inventory) then
    return PURCHASE_ITEM_SUCCESS
  end

  if #self.inventory < constants.INVENTORY_AND_STASH_SIZE then
    table.insert(self.inventory, item)
    return PURCHASE_ITEM_SUCCESS
  end

  local index = functions.GetElementIndexInList(
    "nil",
    self.inventory)

  if index == -1 then return PURCHASE_ITEM_DISALLOWED_ITEM end

  self.inventory[index] = item

  return PURCHASE_ITEM_SUCCESS
end

function Unit:ActionImmediate_SellItem(item)
  local index = functions.GetElementIndexInList(
    item.name,
    self.inventory)

  if index == -1 then return end

  self.gold = self.gold - GetItemCost(item.name)

  self.inventory[index] = "nil"
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

function Bot:GetItemInSlot(slot)
  local item_in_slot = self.inventory[slot]

  if item_in_slot == nil then return nil end

  local item = Item:new()
  item.name = self.inventory[slot]
  return item
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

local TestUnit = Unit:new()

function Bot:GetNearbyHeroes(radius, enemies, mode)
  return { TestUnit, TestUnit }
end

IS_CHANNELING = false

function Bot:IsChanneling()
  return IS_CHANNELING
end

IS_USING_ABILITY = false

function Bot:IsUsingAbility()
  return IS_USING_ABILITY
end

IS_CASTING_ABILITY = false

function Bot:IsCastingAbility()
  return IS_CASTING_ABILITY
end

function Bot:FindAoELocation()
  return {count = 3, {1.2, 3.4}}
end

function Bot:GetLocation()
  return {1.2, 3.4}
end

function Bot:ActionPush_UseAbilityOnLocation()
end

function Bot:Action_UseAbilityOnEntity()
end

function Bot:ActionPush_UseAbility()
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

BOT_LEVEL = 1

function Bot:GetLevel()
  return BOT_LEVEL
end

------------------------------------------

Ability = {}

function Ability:new()
  local newObj = {cast_range = 600}
  self.__index = self
  return setmetatable(newObj, self)
end

local TestAbility = Ability:new()

function Bot:GetAbilityByName(abilityName)
  return TestAbility
end

function Ability:GetCastRange()
  return self.cast_range
end

function Ability:IsFullyCastable()
  return true
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

function Ability:GetAbilityDamage()
  return 100
end

------------------------------------------------

function GetTeam()
  return TEAM_RADIANT
end

function GetOpposingTeam()
  return TEAM_DIRE
end

function GetTeamPlayers(team)
  return {1, 2, 3, 4, 5}
end

function IsPlayerBot(playerId)
  return true
end

SELECTED_HEROES = {}

function SelectHero(playerId, heroName)
  SELECTED_HEROES[playerId] = heroName
end
