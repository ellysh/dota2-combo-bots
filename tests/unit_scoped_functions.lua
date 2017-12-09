Unit = {}

function Unit:new()
    local newObj = {name = "test", health = 100}
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
    return { TestUnit }
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

