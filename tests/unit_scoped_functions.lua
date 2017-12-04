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
