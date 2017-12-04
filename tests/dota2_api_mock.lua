Bot = {}

function Bot:new()
    local newObj = {}
    self.__index = self
    return setmetatable(newObj, self)
end

function Bot:SetNextItemPurchaseValue(cost)
    print('Bot:SetNextItemPurchaseValue() - cost = ' .. cost)
end

function Bot:Action_PurchaseItem(item)
    print('Bot:Action_PurchaseItem() - item = ' .. item)
end

function Bot:GetGold()
    return 100
end

function GetItemCost()
    return 10
end

function GetBot()
    return Bot:new()
end
