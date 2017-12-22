Unit = {}

function Unit:new()
    local newObj = {
      name = "npc_dota_hero_crystal_maiden",
      health = 100,
      maxHealth = 200,
      offensivePower = 100}

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
  return self.maxHealth
end

function Unit:IsAlive()
    return true
end

function Unit:GetRawOffensivePower()
  return self.offensivePower
end

-----------------------------------------------

Bot = Unit:new()

function Bot:new()
    local newObj = {gold = 625}
    self.__index = self
    return setmetatable(newObj, self)
end

function Bot:SetNextItemPurchaseValue(cost)
end

PURCHASED_ITEMS = {}

function Bot:ActionImmediate_PurchaseItem(item)
    self.gold = self.gold - GetItemCost(item)

    PURCHASED_ITEMS = {}
    table.insert(PURCHASED_ITEMS, item)
end

function Bot:GetGold()
    return self.gold
end

function Bot:FindItemSlot(itemName)
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

------------------------------------------

Ability = {}

function Ability:new()
    local newObj = {castRange = 600}
    self.__index = self
    return setmetatable(newObj, self)
end

local TestAbility = Ability:new()

function Bot:GetAbilityByName(abilityName)
  return TestAbility
end

function Ability:GetCastRange()
  return self.castRange
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

TEAM_RADIANT = 0
TEAM_DIRE = 1

LANE_TOP = 0
LANE_MID = 1
LANE_BOT = 2

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
