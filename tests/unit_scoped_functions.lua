Bot = {}

function Bot:new()
    local newObj = {gold = 625, item_cost = 0}
    self.__index = self
    return setmetatable(newObj, self)
end

TestBot = Bot:new()

function Bot:SetNextItemPurchaseValue(cost)
    TestBot.item_cost = cost
end

function Bot:ActionImmediate_PurchaseItem(item)
    TestBot.gold = TestBot.gold - TestBot.item_cost
end

function Bot:GetGold()
    return TestBot.gold
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
