package.path = package.path .. ";../utility/?.lua"
require("global_functions")
local item_purchase_utility = require("item_purchase_utility")

local itemsToBuy = {
    "item_tango",
    "item_flask"
};

item_purchase_utility.PurchaseItem(itemsToBuy)
item_purchase_utility.PurchaseItem(itemsToBuy)

-- Buy an item_tango with 150+110 gold cost at the beginning
assert((GetBot():GetGold() == 365), "item_purchase_utility.PurchaseItem() - failed")
assert((#itemsToBuy == 0), "item_purchase_utility.PurchaseItem() - failed")
