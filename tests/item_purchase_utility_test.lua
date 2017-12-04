package.path = package.path .. ";../?.lua"
require("global_functions")
local item_purchase_utility = require("item_purchase_utility")

local itemsToBuy = {
    "item_tango"
};

item_purchase_utility.PurchaseItem(itemsToBuy)

-- Buy an item_tango with 150 gold cost at the beginning
assert((TestBot.gold == 475), "item_purchase_utility.PurchaseItem() - failed")
