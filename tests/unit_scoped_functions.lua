Unit = {}

function Unit:new()
    local newObj = {name = "test", health = 100, offensivePower = 100}
    self.__index = self
    return setmetatable(newObj, self)
end

function Unit:GetUnitName()
    return self.name
end

function Unit:GetHealth()
    return self.health
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

function Bot:ActionImmediate_PurchaseItem(item)
    self.gold = self.gold - GetItemCost(item)
end

function Bot:GetGold()
    return self.gold
end

function Bot:FindItemSlot(itemName)
  return 0
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
  return {count = 2, {1.2, 3.4}}
end

function Bot:GetLocation()
  return {1.2, 3.4}
end

function Bot:ActionPush_UseAbilityOnLocation()
end

function Bot:Action_UseAbilityOnEntity()
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

------------------------------------------------

TEAM_RADIANT = 0
TEAM_DIRE = 1

LANE_TOP = 0
LANE_MID = 1
LANE_BOT = 2

function GetTeam()
    return TEAM_RADIANT
end

function GetTeamPlayers(team)
    return {1, 2, 3, 4, 5}
end

function IsPlayerBot(playerId)
    return true
end

SelectedHero = {}

function SelectHero(playerId, heroName)
    SelectedHero[playerId] = heroName
end
