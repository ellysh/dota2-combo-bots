package.path = package.path .. ";../?.lua"
require("global_functions")
require("item_purchase_shadow_shaman")

ItemPurchaseThink()

-- Buy an item_courier with 200 gold cost at the beginning
assert((GetBot():GetGold() == 425), "ItemPurchaseThink() - failed")
