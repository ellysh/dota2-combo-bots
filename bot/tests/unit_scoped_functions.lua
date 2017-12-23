package.path = package.path .. ";../?.lua"
require("global_constants")

Unit = {}

function Unit:new()
  local newObj = {
    name = "npc_dota_hero_crystal_maiden",
    health = 200,
    max_health = 200,
    offensive_power = 100,
    is_alive = true}

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
  local newObj = {
    gold = 625,
    inventory = {}
  }
  self.__index = self
  return setmetatable(newObj, self)
end

function Bot:SetNextItemPurchaseValue(cost)
end

function Bot:ActionImmediate_PurchaseItem(item)
  self.gold = self.gold - GetItemCost(item)

  table.insert(self.inventory, item)

  return PURCHASE_ITEM_SUCCESS
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

function Bot:IsChanneling()
  return false
end

function Bot:IsUsingAbility()
  return false
end

function Bot:IsCastingAbility()
  return false
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
