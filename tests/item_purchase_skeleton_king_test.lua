package.path = package.path .. ";../?.lua"
require("global_functions")
require("item_purchase_skeleton_king")

ItemPurchaseThink()

-- Buy an item_tango with 150 gold cost at the beginning
assert((TestBot.gold == 475), "ItemPurchaseThink() - failed")
